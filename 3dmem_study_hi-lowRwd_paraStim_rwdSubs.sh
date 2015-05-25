#!/bin/tcsh -xef

# see 3dmema files for excluded subs

3dMEMA  -prefix hi-lowRwd_paraStim_rwdSubs  \
	   -jobs 4      \
	   -mask allSubs_StudyMask+tlrc \
		-set  hi-lo  \
			PARC_sub_2699	stats.studyParaStim_grpspc_FP.PARC_sub_2699_REML+tlrc'[17]'	stats.studyParaStim_grpspc_FP.PARC_sub_2699_REML+tlrc'[18]'	\
			PARC_sub_2718	stats.studyParaStim_grpspc_FP.PARC_sub_2718_REML+tlrc'[17]'	stats.studyParaStim_grpspc_FP.PARC_sub_2718_REML+tlrc'[18]'	\
			PARC_sub_2788	stats.studyParaStim_grpspc_FP.PARC_sub_2788_REML+tlrc'[17]'	stats.studyParaStim_grpspc_FP.PARC_sub_2788_REML+tlrc'[18]'	\
			PARC_sub_2825	stats.studyParaStim_grpspc_FP.PARC_sub_2825_REML+tlrc'[17]'	stats.studyParaStim_grpspc_FP.PARC_sub_2825_REML+tlrc'[18]'	\
			PARC_sub_2874	stats.studyParaStim_grpspc_FP.PARC_sub_2874_REML+tlrc'[17]'	stats.studyParaStim_grpspc_FP.PARC_sub_2874_REML+tlrc'[18]'	\
			PARC_sub_2879	stats.studyParaStim_grpspc_FP.PARC_sub_2879_REML+tlrc'[17]'	stats.studyParaStim_grpspc_FP.PARC_sub_2879_REML+tlrc'[18]'	\
			PARC_sub_2903	stats.studyParaStim_grpspc_FP.PARC_sub_2903_REML+tlrc'[17]'	stats.studyParaStim_grpspc_FP.PARC_sub_2903_REML+tlrc'[18]'	\
			PARC_sub_2917	stats.studyParaStim_grpspc_FP.PARC_sub_2917_REML+tlrc'[17]'	stats.studyParaStim_grpspc_FP.PARC_sub_2917_REML+tlrc'[18]'	\
			PARC_sub_2939	stats.studyParaStim_grpspc_FP.PARC_sub_2939_REML+tlrc'[17]'	stats.studyParaStim_grpspc_FP.PARC_sub_2939_REML+tlrc'[18]'	\
			PARC_sub_2993	stats.studyParaStim_grpspc_FP.PARC_sub_2993_REML+tlrc'[17]'	stats.studyParaStim_grpspc_FP.PARC_sub_2993_REML+tlrc'[18]'	\
			PARC_sub_3010	stats.studyParaStim_grpspc_FP.PARC_sub_3010_REML+tlrc'[17]'	stats.studyParaStim_grpspc_FP.PARC_sub_3010_REML+tlrc'[18]'	\
		-HKtest \
		-model_outliers \
		-max_zeros .33    \
		-residual_Z


3drefit -atrstring AFNI_CLUSTSIM_NN1 file:ClustSim_studyGrp.NN1.niml \
	-atrstring AFNI_CLUSTSIM_MASK file:ClustSim_studyGrp.mask \
	-atrstring AFNI_CLUSTSIM_NN2 file:ClustSim_studyGrp.NN2.niml \
	-atrstring AFNI_CLUSTSIM_NN3 file:ClustSim_studyGrp.NN3.niml \
	 hi-lowRwd_paraStim_rwdSubs+tlrc
