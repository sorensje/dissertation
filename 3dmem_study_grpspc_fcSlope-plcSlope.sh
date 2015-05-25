#!/bin/tcsh -xef

3dMEMA  -prefix fcSlope-plcSlope_paraFP  \
	   -jobs 4      \
	   -mask  allSubs_StudyMask+tlrc \
		-set  memSlope  \
			PARC_sub_2699	stats.studyParaStim_grpspc_FP.PARC_sub_2699_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2699_REML+tlrc'[30]'	\
			PARC_sub_2718	stats.studyParaStim_grpspc_FP.PARC_sub_2718_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2718_REML+tlrc'[30]'	\
			PARC_sub_2726	stats.studyParaStim_grpspc_FP.PARC_sub_2726_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2726_REML+tlrc'[30]'	\
			PARC_sub_2736	stats.studyParaStim_grpspc_FP.PARC_sub_2736_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2736_REML+tlrc'[30]'	\
			PARC_sub_2747	stats.studyParaStim_grpspc_FP.PARC_sub_2747_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2747_REML+tlrc'[30]'	\
			PARC_sub_2754	stats.studyParaStim_grpspc_FP.PARC_sub_2754_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2754_REML+tlrc'[30]'	\
			PARC_sub_2759	stats.studyParaStim_grpspc_FP.PARC_sub_2759_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2759_REML+tlrc'[30]'	\
			PARC_sub_2761	stats.studyParaStim_grpspc_FP.PARC_sub_2761_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2761_REML+tlrc'[30]'	\
			PARC_sub_2778	stats.studyParaStim_grpspc_FP.PARC_sub_2778_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2778_REML+tlrc'[30]'	\
			PARC_sub_2786	stats.studyParaStim_grpspc_FP.PARC_sub_2786_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2786_REML+tlrc'[30]'	\
			PARC_sub_2787	stats.studyParaStim_grpspc_FP.PARC_sub_2787_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2787_REML+tlrc'[30]'	\
			PARC_sub_2788	stats.studyParaStim_grpspc_FP.PARC_sub_2788_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2788_REML+tlrc'[30]'	\
			PARC_sub_2792	stats.studyParaStim_grpspc_FP.PARC_sub_2792_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2792_REML+tlrc'[30]'	\
			PARC_sub_2796	stats.studyParaStim_grpspc_FP.PARC_sub_2796_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2796_REML+tlrc'[30]'	\
			PARC_sub_2799	stats.studyParaStim_grpspc_FP.PARC_sub_2799_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2799_REML+tlrc'[30]'	\
			PARC_sub_2825	stats.studyParaStim_grpspc_FP.PARC_sub_2825_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2825_REML+tlrc'[30]'	\
			PARC_sub_2838	stats.studyParaStim_grpspc_FP.PARC_sub_2838_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2838_REML+tlrc'[30]'	\
			PARC_sub_2841	stats.studyParaStim_grpspc_FP.PARC_sub_2841_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2841_REML+tlrc'[30]'	\
			PARC_sub_2848	stats.studyParaStim_grpspc_FP.PARC_sub_2848_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2848_REML+tlrc'[30]'	\
			PARC_sub_2853	stats.studyParaStim_grpspc_FP.PARC_sub_2853_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2853_REML+tlrc'[30]'	\
			PARC_sub_2865	stats.studyParaStim_grpspc_FP.PARC_sub_2865_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2865_REML+tlrc'[30]'	\
			PARC_sub_2874	stats.studyParaStim_grpspc_FP.PARC_sub_2874_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2874_REML+tlrc'[30]'	\
			PARC_sub_2879	stats.studyParaStim_grpspc_FP.PARC_sub_2879_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2879_REML+tlrc'[30]'	\
			PARC_sub_2885	stats.studyParaStim_grpspc_FP.PARC_sub_2885_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2885_REML+tlrc'[30]'	\
			PARC_sub_2903	stats.studyParaStim_grpspc_FP.PARC_sub_2903_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2903_REML+tlrc'[30]'	\
			PARC_sub_2917	stats.studyParaStim_grpspc_FP.PARC_sub_2917_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2917_REML+tlrc'[30]'	\
			PARC_sub_2927	stats.studyParaStim_grpspc_FP.PARC_sub_2927_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2927_REML+tlrc'[30]'	\
			PARC_sub_2938	stats.studyParaStim_grpspc_FP.PARC_sub_2938_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2938_REML+tlrc'[30]'	\
			PARC_sub_2939	stats.studyParaStim_grpspc_FP.PARC_sub_2939_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2939_REML+tlrc'[30]'	\
			PARC_sub_2945	stats.studyParaStim_grpspc_FP.PARC_sub_2945_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2945_REML+tlrc'[30]'	\
			PARC_sub_2956	stats.studyParaStim_grpspc_FP.PARC_sub_2956_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2956_REML+tlrc'[30]'	\
			PARC_sub_2958	stats.studyParaStim_grpspc_FP.PARC_sub_2958_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2958_REML+tlrc'[30]'	\
			PARC_sub_2987	stats.studyParaStim_grpspc_FP.PARC_sub_2987_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2987_REML+tlrc'[30]'	\
			PARC_sub_2993	stats.studyParaStim_grpspc_FP.PARC_sub_2993_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_2993_REML+tlrc'[30]'	\
			PARC_sub_3010	stats.studyParaStim_grpspc_FP.PARC_sub_3010_REML+tlrc'[29]'	stats.studyParaStim_grpspc_FP.PARC_sub_3010_REML+tlrc'[30]'	\
			-HKtest \
		-model_outliers \
		-max_zeros .33    \
		-residual_Z


3drefit -atrstring AFNI_CLUSTSIM_NN1 file:ClustSim_studyGrp.NN1.niml \
	-atrstring AFNI_CLUSTSIM_MASK file:ClustSim_studyGrp.mask \
	-atrstring AFNI_CLUSTSIM_NN2 file:ClustSim_studyGrp.NN2.niml \
	-atrstring AFNI_CLUSTSIM_NN3 file:ClustSim_studyGrp.NN3.niml \
	fcSlope-plcSlope_paraFP+tlrc
