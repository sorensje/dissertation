#!/bin/tcsh -xef

# see 3dmema files for excluded subs

3dMEMA  -prefix allStimSlope_grpspc  \
	   -jobs 4      \
	   -mask allSubs_StudyMask+tlrc \
		-set  stimSlope  \
	PARC_sub_2699	stats.studParaAllgrpspc.PARC_sub_2699_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2699_REML+tlrc'[16]'	\
			PARC_sub_2718	stats.studParaAllgrpspc.PARC_sub_2718_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2718_REML+tlrc'[16]'	\
			PARC_sub_2726	stats.studParaAllgrpspc.PARC_sub_2726_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2726_REML+tlrc'[16]'	\
			PARC_sub_2736	stats.studParaAllgrpspc.PARC_sub_2736_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2736_REML+tlrc'[16]'	\
			PARC_sub_2747	stats.studParaAllgrpspc.PARC_sub_2747_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2747_REML+tlrc'[16]'	\
			PARC_sub_2754	stats.studParaAllgrpspc.PARC_sub_2754_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2754_REML+tlrc'[16]'	\
			PARC_sub_2759	stats.studParaAllgrpspc.PARC_sub_2759_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2759_REML+tlrc'[16]'	\
			PARC_sub_2761	stats.studParaAllgrpspc.PARC_sub_2761_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2761_REML+tlrc'[16]'	\
			PARC_sub_2778	stats.studParaAllgrpspc.PARC_sub_2778_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2778_REML+tlrc'[16]'	\
			PARC_sub_2786	stats.studParaAllgrpspc.PARC_sub_2786_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2786_REML+tlrc'[16]'	\
			PARC_sub_2787	stats.studParaAllgrpspc.PARC_sub_2787_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2787_REML+tlrc'[16]'	\
			PARC_sub_2788	stats.studParaAllgrpspc.PARC_sub_2788_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2788_REML+tlrc'[16]'	\
			PARC_sub_2792	stats.studParaAllgrpspc.PARC_sub_2792_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2792_REML+tlrc'[16]'	\
			PARC_sub_2796	stats.studParaAllgrpspc.PARC_sub_2796_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2796_REML+tlrc'[16]'	\
			PARC_sub_2799	stats.studParaAllgrpspc.PARC_sub_2799_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2799_REML+tlrc'[16]'	\
			PARC_sub_2825	stats.studParaAllgrpspc.PARC_sub_2825_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2825_REML+tlrc'[16]'	\
			PARC_sub_2838	stats.studParaAllgrpspc.PARC_sub_2838_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2838_REML+tlrc'[16]'	\
			PARC_sub_2841	stats.studParaAllgrpspc.PARC_sub_2841_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2841_REML+tlrc'[16]'	\
			PARC_sub_2848	stats.studParaAllgrpspc.PARC_sub_2848_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2848_REML+tlrc'[16]'	\
			PARC_sub_2853	stats.studParaAllgrpspc.PARC_sub_2853_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2853_REML+tlrc'[16]'	\
			PARC_sub_2865	stats.studParaAllgrpspc.PARC_sub_2865_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2865_REML+tlrc'[16]'	\
			PARC_sub_2874	stats.studParaAllgrpspc.PARC_sub_2874_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2874_REML+tlrc'[16]'	\
			PARC_sub_2879	stats.studParaAllgrpspc.PARC_sub_2879_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2879_REML+tlrc'[16]'	\
			PARC_sub_2885	stats.studParaAllgrpspc.PARC_sub_2885_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2885_REML+tlrc'[16]'	\
			PARC_sub_2903	stats.studParaAllgrpspc.PARC_sub_2903_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2903_REML+tlrc'[16]'	\
			PARC_sub_2917	stats.studParaAllgrpspc.PARC_sub_2917_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2917_REML+tlrc'[16]'	\
			PARC_sub_2927	stats.studParaAllgrpspc.PARC_sub_2927_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2927_REML+tlrc'[16]'	\
			PARC_sub_2938	stats.studParaAllgrpspc.PARC_sub_2938_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2938_REML+tlrc'[16]'	\
			PARC_sub_2939	stats.studParaAllgrpspc.PARC_sub_2939_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2939_REML+tlrc'[16]'	\
			PARC_sub_2945	stats.studParaAllgrpspc.PARC_sub_2945_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2945_REML+tlrc'[16]'	\
			PARC_sub_2956	stats.studParaAllgrpspc.PARC_sub_2956_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2956_REML+tlrc'[16]'	\
			PARC_sub_2958	stats.studParaAllgrpspc.PARC_sub_2958_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2958_REML+tlrc'[16]'	\
			PARC_sub_2987	stats.studParaAllgrpspc.PARC_sub_2987_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2987_REML+tlrc'[16]'	\
			PARC_sub_2993	stats.studParaAllgrpspc.PARC_sub_2993_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_2993_REML+tlrc'[16]'	\
			PARC_sub_3010	stats.studParaAllgrpspc.PARC_sub_3010_REML+tlrc'[15]'	stats.studParaAllgrpspc.PARC_sub_3010_REML+tlrc'[16]'	\
		-HKtest \
		-model_outliers \
		-max_zeros .33    \
		-residual_Z


3drefit -atrstring AFNI_CLUSTSIM_NN1 file:ClustSim_studyGrp.NN1.niml \
	-atrstring AFNI_CLUSTSIM_MASK file:ClustSim_studyGrp.mask \
	-atrstring AFNI_CLUSTSIM_NN2 file:ClustSim_studyGrp.NN2.niml \
	-atrstring AFNI_CLUSTSIM_NN3 file:ClustSim_studyGrp.NN3.niml \
	 allStimSlope_grpspc+tlrc
