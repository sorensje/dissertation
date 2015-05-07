#!/bin/tcsh -xef

# dissertation version: major change: expects to be called inside subj.results dir.

# the user may specify a single subject to run with
if ( $#argv > 0 ) then
    set subj = $argv[1]
else
    set subj = 2
endif

echo $subj 

# set list of runs
set runs = (`count -digits 2 1 6`)



cp /Users/Jim/PARC_study/scandata_for_analysis/${subj}/afni_files/${subj}_*_study_trialonsets.1D ./stimuli/
    

#### 3ddeconvolve w/ 

foreach run ( $runs )
	3dDeconvolve -input pb04.$subj.r$run.scale+orig                       \
		-censor motion_r${run}_${subj}_censor.1D                  	        \
		-polort 3                                                           \
		-num_stimts 7                                                      	 \
		-global_times 	\
		-stim_times_IM 1 stimuli/${subj}_run_${run}_study_trialonsets.1D 'BLOCK(6,1)' -stim_label 1 onset \
		-stim_label 1 study_run1_onsets   \
		-stim_file 2 motion_demean.r$run.1D'[0]' -stim_base 2 -stim_label 2 roll  \
		-stim_file 3 motion_demean.r$run.1D'[1]' -stim_base 3 -stim_label 3 pitch \
		-stim_file 4 motion_demean.r$run.1D'[2]' -stim_base 4 -stim_label 4 yaw   \
		-stim_file 5 motion_demean.r$run.1D'[3]' -stim_base 5 -stim_label 5 dS    \
		-stim_file 6 motion_demean.r$run.1D'[4]' -stim_base 6 -stim_label 6 dL    \
		-stim_file 7 motion_demean.r$run.1D'[5]' -stim_base 7 -stim_label 7 dP    \
		-x1D X.BLOCK6.xmat.r$run.1D -xjpeg X.BLOCK6.r$run.jpg                             \
		-x1D_uncensored X.BLOCK6.nocensor.xmatr$run..1D                                  
		
end



3dLSS -matrix X.BLOCK6.xmat.r01.1D										\
	-input pb04.$subj.r01.scale+orig   				\
	-automask								\
	-prefix LSSbetas.BLOCK6.study.$subj.r01							 \
	-save1d LSSestimators.BLOCK6.$subj.r01.1D \
	-verb
	
3dLSS -matrix X.BLOCK6.xmat.r02.1D										\
	-input pb04.$subj.r02.scale+orig   				\
	-automask								\
	-prefix LSSbetas.BLOCK6.study.$subj.r02							 \
	-save1d LSSestimators.BLOCK6.$subj.r02.1D \
	-verb

3dLSS -matrix X.BLOCK6.xmat.r03.1D										\
	-input pb04.$subj.r03.scale+orig   				\
	-automask								\
	-prefix LSSbetas.BLOCK6.study.$subj.r03							 \
	-save1d LSSestimators.BLOCK6.$subj.r03.1D \
	-verb

3dLSS -matrix X.BLOCK6.xmat.r04.1D										\
	-input pb04.$subj.r04.scale+orig   				\
	-automask								\
	-prefix LSSbetas.BLOCK6.study.$subj.r04							 \
	-save1d LSSestimators.BLOCK6.$subj.r04.1D \
	-verb

3dLSS -matrix X.BLOCK6.xmat.r05.1D										\
	-input pb04.$subj.r05.scale+orig   				\
	-automask								\
	-prefix LSSbetas.BLOCK6.study.$subj.r05							 \
	-save1d LSSestimators.BLOCK6.$subj.r05.1D \
	-verb
	
3dLSS -matrix X.BLOCK6.xmat.r06.1D										\
	-input pb04.$subj.r06.scale+orig   				\
	-automask								\
	-prefix LSSbetas.BLOCK6.study.$subj.r06							 \
	-save1d LSSestimators.BLOCK6.$subj.r06.1D \
	-verb
	