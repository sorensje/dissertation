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

# 
# 
3dDeconvolve -input pb04.$subj.r*.scale+orig.HEAD                          \
    -censor  motion_${subj}_censor.1D 					\
    -polort A                                                              \
    -num_stimts 8                                                         \
    -mask mask_anat.$subj+orig									\
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
    -fout -tout -x1D X.$glm_prefix.xmat.1D -xjpeg X.jpg                                \
    -x1D_uncensored X.$glm_prefix.nocensor.xmat.1D                                     \
    -fitts fitts.$glm_prefix.$subj                                                     \
    -errts errts.$glm_prefix.$subj                                                   \
    -bucket stats.$glm_prefix.$subj


3dREMLfit -matrix X.${glm_prefix}.xmat.1D \
 -mask mask_anat.$subj+orig \
 -input "pb04.${subj}.r01.scale+orig.HEAD pb04.${subj}.r02.scale+orig.HEAD pb04.${subj}.r03.scale+orig.HEAD pb04.${subj}.r04.scale+orig.HEAD pb04.${subj}.r05.scale+orig.HEAD pb04.${subj}.r06.scale+orig.HEAD" \
 -fout -tout -Rbuck stats.${glm_prefix}.${subj}_REML -Rvar stats.${glm_prefix}.${subj}_REMLvar \
 -Rfitts fitts.${glm_prefix}.${subj}_REML -Rerrts errts.${glm_prefix}.${subj}_REML -verb
 
 cd ..
 