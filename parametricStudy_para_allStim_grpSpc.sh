#!/bin/tcsh -xef

# script to run univariate parametric analysis of study data 
# this analysis will have separate regressors for place vs face. 

# the user may specify a single subject to run with
if ( $#argv > 0 ) then
    set subj = $argv[1]
endif

if ( $#argv > 1 ) then
    set glm_prefix = $argv[2]
else
	set glm_prefix = studParaAllgrpspc
endif


#### THINK ABOUT OUTPUT DIR
# assign output directory name
set output_dir = $subj.results
echo $output_dir
cd $output_dir

# 
# 
3dDeconvolve -input pb04.$subj.r*.scale+tlrc.HEAD                          \
    -censor  motion_${subj}_censor.1D 					\
    -polort A                                                              \
    -num_stimts 9                                                         \
    -mask mask_anat.$subj+tlrc									\
	-stim_file 1 motion_demean.1D'[0]' -stim_base 1 -stim_label 1 roll     \
    -stim_file 2 motion_demean.1D'[1]' -stim_base 2 -stim_label 2 pitch    \
    -stim_file 3 motion_demean.1D'[2]' -stim_base 3 -stim_label 3 yaw      \
    -stim_file 4 motion_demean.1D'[3]' -stim_base 4 -stim_label 4 dS       \
    -stim_file 5 motion_demean.1D'[4]' -stim_base 5 -stim_label 5 dL       \
    -stim_file 6 motion_demean.1D'[5]' -stim_base 6 -stim_label 6 dP       \
    -stim_times 7 stimuli/${subj}_study_hiRwd_rwdOnset_allblocks.txt       \
    'SPMG1'                                                           \
    -stim_label 7 high_rwd \
    -stim_times 8 stimuli/${subj}_study_lowRwd_rwdOnset_allblocks.txt       \
    'SPMG1'                                                           \
    -stim_label 8 low_rwd \
    -stim_times_AM2 9 stimuli/${subj}_encode_stimOnset_parametric_allblocks.txt      \
    'BLOCK(6,1)'                                                           \
    -stim_label 9 stim_para \
	-num_glt 4 \
    -gltsym 'SYM: stim_para[0] -stim_para[0]'         \
    -glt_label 1 paraStim_mean                                                     \
    -gltsym 'SYM: stim_para[1] -stim_para[1]'         \
    -glt_label 2 paraStim_slope                                                     \
    -gltsym 'SYM: high_rwd[1] -low_rwd[1]'         \
    -glt_label 3 hi-low_Rwd                                                      \
    -gltsym 'SYM: stim_para[1] +stim_para[1] -stim_para[0] -stim_para[0]'         \
    -glt_label 4 stim_mean-slope                                                      \
    -fout -tout -x1D X.$glm_prefix.xmat.1D -xjpeg X.jpg                                \
    -x1D_uncensored X.$glm_prefix.nocensor.xmat.1D                                     \
    -fitts fitts.$glm_prefix.$subj                                                     \
    -errts errts.$glm_prefix.$subj                                                   \
    -bucket stats.$glm_prefix.$subj


3dREMLfit -matrix X.${glm_prefix}.xmat.1D \
 -mask mask_anat.$subj+tlrc \
 -input "pb04.${subj}.r01.scale+tlrc.HEAD pb04.${subj}.r02.scale+tlrc.HEAD pb04.${subj}.r03.scale+tlrc.HEAD pb04.${subj}.r04.scale+tlrc.HEAD pb04.${subj}.r05.scale+tlrc.HEAD pb04.${subj}.r06.scale+tlrc.HEAD" \
 -fout -tout -Rbuck stats.${glm_prefix}.${subj}_REML -Rvar stats.${glm_prefix}.${subj}_REMLvar \
 -Rfitts fitts.${glm_prefix}.${subj}_REML -Rerrts errts.${glm_prefix}.${subj}_REML -verb
 
 cd ..
 