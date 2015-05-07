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


## fixing from broken. not removing tlrc stuff, but am removing files that were created by the wrong decon command.
rm ClustSim.NN1.1D ClustSim.NN1.niml ClustSim.NN2.1D ClustSim.NN2.niml ClustSim.NN3.1D
rm ClustSim.NN3.niml ClustSim.mask blur.errts.1D blur_est.$subj.1D blur.epits.1D X.stim.xmat.1D
rm X.study.nocensor.xmat.1D gmean.errts.unit.1D ideal_correct_encode_allblocks.1D ideal_miss_encode_allblocks.1D
rm out.gcor.1D all_runs.recallGAM.study.$subj* out.recallGAM.study.cormat_warn.txt
rm 3dDeconvolve.err motion_${subj}_censor.1D motion_demean.1D




cat motion_r0*_${subj}_censor.1D > motion_${subj}_censor.1D
cat motion_demean.r0*.1D > motion_demean.1D

3dDeconvolve -input pb04.$subj.r*.scale+orig.HEAD                          \
    -censor  motion_${subj}_censor.1D 					\
    -polort A                                                              \
    -num_stimts 11                                                         \
	-stim_file 1 motion_demean.1D'[0]' -stim_base 1 -stim_label 1 roll     \
    -stim_file 2 motion_demean.1D'[1]' -stim_base 2 -stim_label 2 pitch    \
    -stim_file 3 motion_demean.1D'[2]' -stim_base 3 -stim_label 3 yaw      \
    -stim_file 4 motion_demean.1D'[3]' -stim_base 4 -stim_label 4 dS       \
    -stim_file 5 motion_demean.1D'[4]' -stim_base 5 -stim_label 5 dL       \
    -stim_file 6 motion_demean.1D'[5]' -stim_base 6 -stim_label 6 dP       \
    -stim_times_AM2 7 stimuli/${subj}_test_recStim_person_MISS_allblocks.txt       \
    'GAM'                                                           \
    -stim_label 7 stim_pers_miss \
    -stim_times 8 stimuli/${subj}_test_recStim_person_HIT_allblocks.txt       \
    'GAM'                                                           \
    -stim_label 8 stim_pers_hit \
    -stim_times 9 stimuli/${subj}_test_recStim_place_MISS_allblocks.txt       \
    'GAM'                                                           \
    -stim_label 9 stim_plc_hit \
    -stim_times 10 stimuli/${subj}_test_recStim_place_HIT_allblocks.txt       \
    'GAM'                                                           \
    -stim_label 10 stim_plc_miss \
    -stim_times 11 stimuli/${subj}_test_MemJudge_all_allblocks.txt       \
    'GAM'                                                           \
    -stim_label 11 all_mem_Judge \
    -num_glt 6 \
	-gltsym 'SYM: stim_pers_hit +stim_plc_hit -stim_pers_miss -stim_plc_miss'         \
    -glt_label 1 HIT-MISS                                                       \
	-gltsym 'SYM: stim_pers_hit -stim_pers_miss'         \
    -glt_label 2 pers_HIT-MISS                                                       \
    -gltsym 'SYM: stim_plc_hit -stim_plc_miss'         \
    -glt_label 3 plc_HIT-MISS                                                       \
    -gltsym 'SYM: all_mem_Judge'         \
    -glt_label 4 all_memJudge                                                       \
    	-gltsym 'SYM: stim_pers_hit +stim_plc_hit '         \
    -glt_label 5 all_hits                                                       \
    	-gltsym 'SYM: stim_pers_miss +stim_plc_miss'         \
    -glt_label 6 all_misses                                                      \
    -fout -tout -x1D X.$glm_prefix.xmat.1D -xjpeg X.jpg                                \
    -x1D_uncensored X.$glm_prefix.nocensor.xmat.1D                                     \
    -fitts fitts.$glm_prefix.$subj                                                     \
    -errts errts.$glm_prefix.$subj                                                   \
    -bucket stats.$glm_prefix.$subj


# create an all_runs dataset to match the fitts, errts, etc.
3dTcat -prefix all_runs.$glm_prefix.$subj pb04.$subj.r*.scale+orig.HEAD

## reml fit is leftover from old version. I think these are the stats I bring to group level?
3dREMLfit -input all_runs.$glm_prefix.$subj+orig.HEAD                          \
-matrix X.$glm_prefix.xmat.1D   \
-usetemp  \
-tout\
-Rbuck rbuck.$glm_prefix.$subj
    
# display any large pariwise correlations from the X-matrix
1d_tool.py -show_cormat_warnings -infile X.$glm_prefix.xmat.1D |& tee out.$glm_prefix.cormat_warn.txt

# return to parent directory
cd ..