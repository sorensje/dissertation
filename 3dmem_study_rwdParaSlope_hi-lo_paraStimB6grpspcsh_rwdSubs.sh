#!/bin/tcsh -xef

3dMEMA  -prefix hi-lo_rwdSubs_paraRwd_all_23  \
	   -jobs 4      \
	   -mask  allSubs_StudyMask+tlrc \
		-set  hi-lo_all  \
			PARC_sub_2699	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2699_REML+tlrc'[23]'	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2699_REML+tlrc'[24]'	\
			PARC_sub_2718	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2718_REML+tlrc'[23]'	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2718_REML+tlrc'[24]'	\
			PARC_sub_2788	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2788_REML+tlrc'[23]'	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2788_REML+tlrc'[24]'	\
			PARC_sub_2825	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2825_REML+tlrc'[23]'	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2825_REML+tlrc'[24]'	\
			PARC_sub_2874	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2874_REML+tlrc'[23]'	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2874_REML+tlrc'[24]'	\
			PARC_sub_2879	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2879_REML+tlrc'[23]'	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2879_REML+tlrc'[24]'	\
			PARC_sub_2903	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2903_REML+tlrc'[23]'	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2903_REML+tlrc'[24]'	\
			PARC_sub_2917	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2917_REML+tlrc'[23]'	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2917_REML+tlrc'[24]'	\
			PARC_sub_2939	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2939_REML+tlrc'[23]'	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2939_REML+tlrc'[24]'	\
			PARC_sub_2993	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2993_REML+tlrc'[23]'	stats.studyParaRWD_grpspc_stimFP.PARC_sub_2993_REML+tlrc'[24]'	\
			PARC_sub_3010	stats.studyParaRWD_grpspc_stimFP.PARC_sub_3010_REML+tlrc'[23]'	stats.studyParaRWD_grpspc_stimFP.PARC_sub_3010_REML+tlrc'[24]'	\
		-HKtest \
		-model_outliers \
		-max_zeros .33    \
		-residual_Z


3drefit -atrstring AFNI_CLUSTSIM_NN1 file:ClustSim_studyGrp.NN1.niml \
	-atrstring AFNI_CLUSTSIM_MASK file:ClustSim_studyGrp.mask \
	-atrstring AFNI_CLUSTSIM_NN2 file:ClustSim_studyGrp.NN2.niml \
	-atrstring AFNI_CLUSTSIM_NN3 file:ClustSim_studyGrp.NN3.niml \
	 hi-lo_rwdSubs_paraRwd_all_23+tlrc
