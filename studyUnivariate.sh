#!/bin/tcsh -xef

# the user may specify a single subject to run with
if ( $#argv > 0 ) then
    set subj = $argv[1]
endif

if ( $#argv > 1 ) then
    set glm_prefix = $argv[2]
else
	set glm_prefix = study_stimB6
endif

#### THINK ABOUT OUTPUT DIR
# assign output directory name
set output_dir = $subj.results
echo $output_dir
cd $output_dir


cat motion_r0*_${subj}_censor.1D > motion_${subj}_censor.1D
cat motion_demean.r0*.1D > motion_demean.1D

3dDeconvolve -input pb04.$subj.r*.scale+orig.HEAD                          \
    -censor  motion_${subj}_censor.1D 					\
    -polort A                                                              \
    -num_stimts 14                                                          \
	-stim_file 1 motion_demean.1D'[0]' -stim_base 1 -stim_label 1 roll     \
    -stim_file 2 motion_demean.1D'[1]' -stim_base 2 -stim_label 2 pitch    \
    -stim_file 3 motion_demean.1D'[2]' -stim_base 3 -stim_label 3 yaw      \
    -stim_file 4 motion_demean.1D'[3]' -stim_base 4 -stim_label 4 dS       \
    -stim_file 5 motion_demean.1D'[4]' -stim_base 5 -stim_label 5 dL       \
    -stim_file 6 motion_demean.1D'[5]' -stim_base 6 -stim_label 6 dP       \
    -stim_times 7 stimuli/${subj}_view_high_rwd_study_MISS_allblocks.txt       \
    'GAM'                                                           \
    -stim_label 7 high_rwd_MISS \
    -stim_times 8 stimuli/${subj}_view_high_rwd_study_HIT_allblocks.txt       \
    'GAM'                                                           \
    -stim_label 8 high_rwd_HIT \
    -stim_times 9 stimuli/${subj}_view_low_rwd_study_MISS_allblocks.txt       \
    'GAM'                                                           \
    -stim_label 9 low_rwd_MISS \
    -stim_times 10 stimuli/${subj}_view_low_rwd_study_HIT_allblocks.txt       \
    'GAM'                                                           \
    -stim_label 10 low_rwd_HIT \
    -stim_times 11 stimuli/${subj}_person_encode_MISS_allblocks.txt       \
    'BLOCK(6,1)'                                                           \
    -stim_label 11 pers_enc_MISS                                 \
    -stim_times 12 stimuli/${subj}_person_encode_HIT_allblocks.txt       \
    'BLOCK(6,1)'                                                           \
    -stim_label 12 pers_enc_HIT                                 \
    -stim_times 13 stimuli/${subj}_place_encode_MISS_allblocks.txt\
    'BLOCK(6,1)'                                                           \
    -stim_label 13 plc_enc_MISS         \
    -stim_times 14 stimuli/${subj}_place_encode_HIT_allblocks.txt\
    'BLOCK(6,1)'                                                           \
    -stim_label 14 plc_enc_HIT         \
    -num_glt 11 \
	-gltsym 'SYM: high_rwd_HIT +high_rwd_MISS -low_rwd_MISS -low_rwd_HIT'         \
    -glt_label 1 high-low                                                       \
    -gltsym 'SYM: high_rwd_HIT -low_rwd_HIT'         \
    -glt_label 2 high-low_HIT                                                       \
    -gltsym 'SYM: high_rwd_MISS -low_rwd_MISS'         \
    -glt_label 3 high-low_MISS      \
    -gltsym 'SYM: high_rwd_HIT +high_rwd_MISS'         \
    -glt_label 4 highrwd\
	-gltsym 'SYM: low_rwd_MISS low_rwd_HIT'         \
	-glt_label 5 lowrwd\
	-gltsym 'SYM: pers_enc_HIT -pers_enc_MISS'         \
	-glt_label 6 pers_HIT-MISS \
	-gltsym 'SYM: plc_enc_HIT -plc_enc_MISS'         \
	-glt_label 7 plc_HIT-MISS \
	-gltsym 'SYM: plc_enc_HIT -pers_enc_HIT'         \
	-glt_label 8 pers-plc_HIT \
	-gltsym 'SYM: pers_enc_MISS -plc_enc_MISS'         \
	-glt_label 9 pers-plc_MISS \
	-gltsym 'SYM: pers_enc_MISS +pers_enc_HIT -plc_enc_HIT -plc_enc_MISS'         \
	-glt_label 10 pers-plc_all \
	-gltsym 'SYM: pers_enc_HIT +plc_enc_HIT -pers_enc_MISS -plc_enc_MISS'         \
	-glt_label 11 stim_HIT-MISS \
    -fout -tout -x1D X.$glm_prefix.study.xmat.1D -xjpeg X.jpg                                \
    -x1D_uncensored X.$glm_prefix.study.nocensor.xmat.1D                                     \
    -fitts fitts.$glm_prefix.study.$subj                                                     \
    -errts errts.$glm_prefix.study.$subj                                                   \
    -bucket stats.$glm_prefix.$subj


# create an all_runs dataset to match the fitts, errts, etc.
3dTcat -prefix all_runs.$glm_prefix.study.$subj pb04.$subj.r*.scale+orig.HEAD

## reml fit is leftover from old version. I think these are the stats I bring to group level?
3dREMLfit -input all_runs.$glm_prefix.study.$subj+orig.HEAD                          \
-matrix X.$glm_prefix.study.xmat.1D   \
-usetemp  \
-tout\
-Rbuck $subj.$glm_prefix.study.rbuck 
    
# display any large pariwise correlations from the X-matrix
1d_tool.py -show_cormat_warnings -infile X.$glm_prefix.study.xmat.1D |& tee out.$glm_prefix.study.cormat_warn.txt


###### FROM OLDER SCRIPT ##### 

# create a temporal signal to noise ratio dataset 
#    signal: if 'scale' block, mean should be 100
#    noise : compute standard deviation of errts
3dTstat -mean -prefix rm.signal.all all_runs.$glm_prefix.study.$subj+orig
3dTstat -stdev -prefix rm.noise.all errts.$glm_prefix.study.$subj+orig
3dcalc -a rm.signal.all+orig                                                  \
       -b rm.noise.all+orig                                                   \
       -c full_mask.$subj+orig                                                \
       -expr 'c*a/b' -prefix TSNR.$glm_prefix.$subj 

# compute and store GCOR (global correlation average)
# - compute as sum of squares of global mean of unit errts
3dTnorm -prefix rm.errts.unit errts.$glm_prefix.study.$subj+orig
3dmaskave -quiet -mask full_mask.$subj+orig rm.errts.unit+orig >              \
    gmean.errts.unit.1D
3dTstat -sos -prefix - gmean.errts.unit.1D\' > out.gcor.1D
echo "-- GCOR = `cat out.gcor.1D`"

# create ideal files for fixed response stim types
1dcat X.$glm_prefix.study.nocensor.xmat.1D'[18]' > ideal_correct_encode_allblocks.1D
1dcat X.$glm_prefix.study.nocensor.xmat.1D'[19]' > ideal_miss_encode_allblocks.1D
1dcat X.$glm_prefix.study.nocensor.xmat.1D > X.study.nocensor.xmat.1D

# compute sum of non-baseline regressors from the X-matrix
# (use 1d_tool.py to get list of regressor colums)
set reg_cols = `1d_tool.py -infile X.study.nocensor.xmat.1D -show_indices_interest`
3dTstat -sum -prefix sum_ideal.1D X.$glm_prefix.study.nocensor.xmat.1D"[$reg_cols]"

# also, create a stimulus-only X-matrix, for easy review
1dcat X.$glm_prefix.study.nocensor.xmat.1D"[$reg_cols]" > X.stim.xmat.1D

# ============================ blur estimation =============================
# compute blur estimates
touch blur_est.$subj.1D   # start with empty file

# -- estimate blur for each run in epits --
touch blur.epits.1D

# -- retrieve tr counts
set tr_counts = `cat tr_Counts.txt`


set b0 = 0     # first index for current run
set b1 = -1    # will be last index for current run
foreach reps ( $tr_counts )
    @ b1 += $reps  # last index for current run
    3dFWHMx -detrend -mask full_mask.$subj+orig                               \
        all_runs.$glm_prefix.study.$subj+orig"[$b0..$b1]" >> blur.epits.1D
    @ b0 += $reps  # first index for next run
end

# compute average blur and append
set blurs = ( `3dTstat -mean -prefix - blur.epits.1D\'` )
echo average epits blurs: $blurs
echo "$blurs   # epits blur estimates" >> blur_est.$subj.1D

# -- estimate blur for each run in errts --
touch blur.errts.1D

set b0 = 0     # first index for current run
set b1 = -1    # will be last index for current run
foreach reps ( $tr_counts )
    @ b1 += $reps  # last index for current run
    3dFWHMx -detrend -mask full_mask.$subj+orig                               \
        errts.$glm_prefix.study.$subj+orig"[$b0..$b1]" >> blur.errts.1D
    @ b0 += $reps  # first index for next run
end

# compute average blur and append
set blurs = ( `3dTstat -mean -prefix - blur.errts.1D\'` )
echo average errts blurs: $blurs
echo "$blurs   # errts blur estimates" >> blur_est.$subj.1D


# add 3dClustSim results as attributes to the stats dset
set fxyz = ( `tail -1 blur_est.$subj.1D` )
3dClustSim -both -NN 123 -mask full_mask.$subj+orig                           \
           -fwhmxyz $fxyz[1-3] -prefix ClustSim
3drefit -atrstring AFNI_CLUSTSIM_MASK file:ClustSim.mask                      \
        -atrstring AFNI_CLUSTSIM_NN1  file:ClustSim.NN1.niml                  \
        -atrstring AFNI_CLUSTSIM_NN2  file:ClustSim.NN2.niml                  \
        -atrstring AFNI_CLUSTSIM_NN3  file:ClustSim.NN3.niml                  \
        stats.$glm_prefix.$subj+orig





# ========================== auto block: finalize ==========================

# remove temporary files
\rm -f rm.*

# return to parent directory
cd ..