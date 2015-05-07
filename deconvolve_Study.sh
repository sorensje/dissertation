#!/bin/tcsh -xef

# the user may specify a single subject to run with
if ( $#argv > 0 ) then
    set subj = $argv[1]
endif

if ( $#argv > 1 ) then
    set glm_prefix = $argv[2]
else
	set glm_prefix = study_stimGAM
endif

#### THINK ABOUT OUTPUT DIR
# assign output directory name
# set output_dir = $subj.results
# echo $output_dir
# cd $output_dir
echo `pwd`

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
    'GAM'                                                           \
    -stim_label 11 pers_enc_MISS                                 \
    -stim_times 12 stimuli/${subj}_person_encode_HIT_allblocks.txt       \
    'GAM'                                                           \
    -stim_label 12 pers_enc_HIT                                 \
    -stim_times 13 stimuli/${subj}_place_encode_MISS_allblocks.txt\
    'GAM'                                                           \
    -stim_label 13 plc_enc_MISS         \
    -stim_times 14 stimuli/${subj}_place_encode_HIT_allblocks.txt\
    'GAM'                                                           \
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
