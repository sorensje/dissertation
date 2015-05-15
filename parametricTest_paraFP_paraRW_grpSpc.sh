#!/bin/tcsh -xef

# script to run univariate parametric analysis of test data 
# this analysis will have separate regressors for place vs face. 

# the user may specify a single subject to run with
if ( $#argv > 0 ) then
    set subj = $argv[1]
endif

if ( $#argv > 1 ) then
    set glm_prefix = $argv[2]
else
	set glm_prefix = test_paraRW_paraFP_grpspc
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
    -num_stimts 11                                                         \
    -mask mask_anat.$subj+tlrc									\
	-stim_file 1 motion_demean.1D'[0]' -stim_base 1 -stim_label 1 roll     \
    -stim_file 2 motion_demean.1D'[1]' -stim_base 2 -stim_label 2 pitch    \
    -stim_file 3 motion_demean.1D'[2]' -stim_base 3 -stim_label 3 yaw      \
    -stim_file 4 motion_demean.1D'[3]' -stim_base 4 -stim_label 4 dS       \
    -stim_file 5 motion_demean.1D'[4]' -stim_base 5 -stim_label 5 dL       \
    -stim_file 6 motion_demean.1D'[5]' -stim_base 6 -stim_label 6 dP       \
    -stim_times 7 stimuli/${subj}_test_MemJudge_all_allblocks.txt       \
    'SPMG1'                                                           \
    -stim_label 7 all_mem_Judge  \
    -stim_times_AM2 8 stimuli/${subj}_recall_loRwd_person_stimOnset_parametric_allblocks.txt       \
    'SPMG1'                                                           \
    -stim_label 8 para_Face_lo \
    -stim_times_AM2 9 stimuli/${subj}_recall_loRwd_place_stimOnset_parametric_allblocks.txt       \
    'SPMG1'                                                           \
    -stim_label 9 para_Place_lo \
    -stim_times_AM2 10 stimuli/${subj}_recall_hiRwd_person_stimOnset_parametric_allblocks.txt       \
    'SPMG1'                                                           \
    -stim_label 10 para_Face_hi \
    -stim_times_AM2 11 stimuli/${subj}_recall_hiRwd_place_stimOnset_parametric_allblocks.txt       \
    'SPMG1'                                                           \
    -stim_label 11 para_Place_hi \
    -num_glt 8 \
    -gltsym 'SYM: para_Face_lo[0] +para_Place_lo[0] +para_Face_hi[0] +para_Place_hi[0]'         \
    -glt_label 1 mem_mean                                                     \
    -gltsym 'SYM: para_Face_lo[1] +para_Place_lo[1] +para_Face_hi[1] +para_Place_hi[1]'         \
    -glt_label 2 mem_slope                                                     \
    -gltsym 'SYM: para_Face_lo[0] +para_Face_hi[0] -para_Place_lo[0] -para_Place_hi[0]'         \
    -glt_label 3 pers-place_mean                                                     \
    -gltsym 'SYM: para_Face_lo[1] +para_Face_hi[1] -para_Place_lo[1] -para_Place_hi[1]'         \
    -glt_label 4 pers-place_slope                                                     \
    -gltsym 'SYM: para_Place_hi[0] +para_Face_hi[0] -para_Place_lo[0] -para_Face_lo[0]'         \
    -glt_label 5 hi-lo_mean                                                    \
    -gltsym 'SYM: para_Place_hi[0] +para_Face_hi[0] -para_Place_lo[0] -para_Face_lo[0]'         \
    -glt_label 6 hi-lo_slope                                                     \
    -gltsym 'SYM: para_Place_hi[0] -para_Place_lo[0] -para_Face_hi[0] +para_Face_lo[0]'         \
    -glt_label 7 plcH_fcL-plcL_fcH_mean     	 \
    -gltsym 'SYM: para_Place_hi[1] -para_Place_lo[1] -para_Face_hi[1] +para_Face_lo[1]'         \
    -glt_label 8 plcH_fcL-plcL_fcH_mean		\
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
 