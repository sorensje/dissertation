#!/bin/tcsh -xef

# script to run univariate parametric analysis of test data 

# the user may specify a single subject to run with
if ( $#argv > 0 ) then
    set subj = $argv[1]
endif

if ( $#argv > 1 ) then
    set glm_prefix = $argv[2]
else
	set glm_prefix = test_para
endif


#### THINK ABOUT OUTPUT DIR
# assign output directory name
set output_dir = $subj.results
echo $output_dir
cd $output_dir

# ====== get files. 
set oldTestFolder = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/
cp ${oldTestFolder}/${output_dir}/stimuli/* ./stimuli

# def runs.
set runs = (`count -digits 2 1 6`)

# make motion files
cat motion_r0*_${subj}_censor.1D > motion_${subj}_censor.1D
cat motion_demean.r0*.1D > motion_demean.1D


3dDeconvolve -input pb04.$subj.r*.scale+tlrc.HEAD                          \
    -censor  motion_${subj}_censor.1D 					\
    -polort A                                                              \
    -num_stimts 8                                                         \
    -mask mask_anat.$subj+tlrc									\
	-stim_file 1 motion_demean.1D'[0]' -stim_base 1 -stim_label 1 roll     \
    -stim_file 2 motion_demean.1D'[1]' -stim_base 2 -stim_label 2 pitch    \
    -stim_file 3 motion_demean.1D'[2]' -stim_base 3 -stim_label 3 yaw      \
    -stim_file 4 motion_demean.1D'[3]' -stim_base 4 -stim_label 4 dS       \
    -stim_file 5 motion_demean.1D'[4]' -stim_base 5 -stim_label 5 dL       \
    -stim_file 6 motion_demean.1D'[5]' -stim_base 6 -stim_label 6 dP       \
    -stim_times_AM2 7 stimuli/${subj}_recall_stimOnset_parametric_allblocks.txt       \
    'SPMG1'                                                           \
    -stim_label 7 stim_para \
    -stim_times 8 stimuli/${subj}_test_MemJudge_all_allblocks.txt       \
    'SPMG1'                                                           \
    -stim_label 8 all_mem_Judge \
    -gltsym 'SYM: stim_para[1] -stim_para[0]'         \
    -glt_label 1 slope-mean                                                     \
    -fout -tout -x1D X.$glm_prefix.xmat.1D -xjpeg X.jpg                                \
    -x1D_uncensored X.$glm_prefix.nocensor.xmat.1D                                     \
    -fitts fitts.${glm_prefix}.${subj}                                                     \
    -errts errts.${glm_prefix}.${subj}                                                   \
    -bucket stats.${glm_prefix}.$subj

## create non labeled versions because suck.

cp X.$glm_prefix.nocensor.xmat.1D X.nocensor.xmat.1D
cp X.$glm_prefix.xmat.1D X.xmat.1D


# display any large pariwise correlations from the X-matrix
1d_tool.py -show_cormat_warnings -infile X.$glm_prefix.xmat.1D |& tee out.$glm_prefix.cormat_warn.txt

# create an all_runs dataset to match the fitts, errts, etc.
3dTcat -prefix all_runs.$subj pb04.$subj.r*.scale+tlrc.HEAD

# --------------------------------------------------
# create a temporal signal to noise ratio dataset 
#    signal: if 'scale' block, mean should be 100
#    noise : compute standard deviation of errts
3dTstat -mean -prefix rm.signal.all all_runs.$subj+tlrc
3dTstat -stdev -prefix rm.noise.all errts.${glm_prefix}.${subj}+tlrc
3dcalc -a rm.signal.all+tlrc                                                  \
       -b rm.noise.all+tlrc                                                   \
       -c full_mask.$subj+tlrc                                                \
       -expr 'c*a/b' -prefix TSNR.${glm_prefix}.$subj 


# --------------------------------------------------------
# compute sum of non-baseline regressors from the X-matrix
# (use 1d_tool.py to get list of regressor colums)

set reg_cols = `1d_tool.py -infile X.nocensor.xmat.1D -show_indices_interest`
3dTstat -sum -prefix sum_ideal.1D X.nocensor.xmat.1D"[$reg_cols]"

# also, create a stimulus-only X-matrix, for easy review
1dcat X.nocensor.xmat.1D"[$reg_cols]" > X.stim.xmat.1D

# ============================ blur estimation =============================
# compute blur estimates
touch blur_est.$subj.1D   # start with empty file

# -- estimate blur for each run in epits --
touch blur.epits.1D

# restrict to uncensored TRs, per run
foreach run ( $runs )
    set trs = `1d_tool.py -infile X.xmat.1D -show_trs_uncensored encoded      \
                          -show_trs_run $run`
    if ( $trs == "" ) continue
    3dFWHMx -detrend -mask full_mask.$subj+tlrc                               \
        all_runs.$subj+tlrc"[$trs]" >> blur.epits.1D
end

# compute average blur and append
set blurs = ( `3dTstat -mean -prefix - blur.epits.1D\'` )
echo average epits blurs: $blurs
echo "$blurs   # epits blur estimates" >> blur_est.$subj.1D

# -- estimate blur for each run in errts --
touch blur.errts.1D

# restrict to uncensored TRs, per run
foreach run ( $runs )
    set trs = `1d_tool.py -infile X.xmat.1D -show_trs_uncensored encoded      \
                          -show_trs_run $run`
    if ( $trs == "" ) continue
    3dFWHMx -detrend -mask full_mask.$subj+tlrc                               \
        errts.${glm_prefix}.${subj}+tlrc"[$trs]" >> blur.errts.1D
end

# compute average blur and append
set blurs = ( `3dTstat -mean -prefix - blur.errts.1D\'` )
echo average errts blurs: $blurs
echo "$blurs   # errts blur estimates" >> blur_est.$subj.1D
echo "$blurs   # errts blur estimates" >> blur_est.${glm_prefix}.$subj.1D


# add 3dClustSim results as attributes to the stats dset
set fxyz = ( `tail -1 blur_est.$subj.1D` )
3dClustSim -both -NN 123 -mask full_mask.$subj+tlrc                           \
           -fwhmxyz $fxyz[1-3] -prefix ClustSim
3drefit -atrstring AFNI_CLUSTSIM_MASK file:ClustSim.mask                      \
        -atrstring AFNI_CLUSTSIM_NN1  file:ClustSim.NN1.niml                  \
        -atrstring AFNI_CLUSTSIM_NN2  file:ClustSim.NN2.niml                  \
        -atrstring AFNI_CLUSTSIM_NN3  file:ClustSim.NN3.niml                  \
        stats.$subj+tlrc

# ======= Jim REML


3dREMLfit -matrix X.${glm_prefix}.xmat.1D \
 -mask mask_anat.$subj+tlrc \
 -input "pb04.${subj}.r01.scale+tlrc.HEAD pb04.${subj}.r02.scale+tlrc.HEAD pb04.${subj}.r03.scale+tlrc.HEAD pb04.${subj}.r04.scale+tlrc.HEAD pb04.${subj}.r05.scale+tlrc.HEAD pb04.${subj}.r06.scale+tlrc.HEAD" \
 -fout -tout -Rbuck stats.${glm_prefix}.${subj}_REML -Rvar stats.${glm_prefix}.${subj}_REMLvar \
 -Rfitts fitts.${glm_prefix}.${subj}_REML -Rerrts errts.${glm_prefix}.${subj}_REML -verb
 
 
 #+====== clean up
 
rm rm*

 
 