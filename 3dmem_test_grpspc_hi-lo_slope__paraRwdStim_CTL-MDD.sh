#!/bin/tcsh -xef

3dMEMA  -prefix hi-lo_slope_paraRS_CTL-MDD  \
	   -jobs 4      \
	   -mask  allSubs_TestMask+tlrc \
	   -groups MDD CTL \
		-set  MDD  \
			PARC_sub_2718	stats.test_paraRW_paraFP_grpspc.PARC_sub_2718_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2718_REML+tlrc'[40]'	\
			PARC_sub_2726	stats.test_paraRW_paraFP_grpspc.PARC_sub_2726_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2726_REML+tlrc'[40]'	\
			PARC_sub_2736	stats.test_paraRW_paraFP_grpspc.PARC_sub_2736_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2736_REML+tlrc'[40]'	\
			PARC_sub_2747	stats.test_paraRW_paraFP_grpspc.PARC_sub_2747_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2747_REML+tlrc'[40]'	\
			PARC_sub_2759	stats.test_paraRW_paraFP_grpspc.PARC_sub_2759_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2759_REML+tlrc'[40]'	\
			PARC_sub_2761	stats.test_paraRW_paraFP_grpspc.PARC_sub_2761_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2761_REML+tlrc'[40]'	\
			PARC_sub_2788	stats.test_paraRW_paraFP_grpspc.PARC_sub_2788_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2788_REML+tlrc'[40]'	\
			PARC_sub_2799	stats.test_paraRW_paraFP_grpspc.PARC_sub_2799_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2799_REML+tlrc'[40]'	\
			PARC_sub_2838	stats.test_paraRW_paraFP_grpspc.PARC_sub_2838_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2838_REML+tlrc'[40]'	\
			PARC_sub_2853	stats.test_paraRW_paraFP_grpspc.PARC_sub_2853_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2853_REML+tlrc'[40]'	\
			PARC_sub_2865	stats.test_paraRW_paraFP_grpspc.PARC_sub_2865_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2865_REML+tlrc'[40]'	\
			PARC_sub_2874	stats.test_paraRW_paraFP_grpspc.PARC_sub_2874_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2874_REML+tlrc'[40]'	\
			PARC_sub_2879	stats.test_paraRW_paraFP_grpspc.PARC_sub_2879_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2879_REML+tlrc'[40]'	\
			PARC_sub_2903	stats.test_paraRW_paraFP_grpspc.PARC_sub_2903_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2903_REML+tlrc'[40]'	\
			PARC_sub_2917	stats.test_paraRW_paraFP_grpspc.PARC_sub_2917_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2917_REML+tlrc'[40]'	\
			PARC_sub_2927	stats.test_paraRW_paraFP_grpspc.PARC_sub_2927_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2927_REML+tlrc'[40]'	\
			PARC_sub_2938	stats.test_paraRW_paraFP_grpspc.PARC_sub_2938_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2938_REML+tlrc'[40]'	\
			PARC_sub_2939	stats.test_paraRW_paraFP_grpspc.PARC_sub_2939_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2939_REML+tlrc'[40]'	\
			PARC_sub_2956	stats.test_paraRW_paraFP_grpspc.PARC_sub_2956_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2956_REML+tlrc'[40]'	\
		-set  CTL  \
			PARC_sub_2699	stats.test_paraRW_paraFP_grpspc.PARC_sub_2699_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2699_REML+tlrc'[40]'	\
			PARC_sub_2754	stats.test_paraRW_paraFP_grpspc.PARC_sub_2754_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2754_REML+tlrc'[40]'	\
			PARC_sub_2778	stats.test_paraRW_paraFP_grpspc.PARC_sub_2778_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2778_REML+tlrc'[40]'	\
			PARC_sub_2786	stats.test_paraRW_paraFP_grpspc.PARC_sub_2786_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2786_REML+tlrc'[40]'	\
			PARC_sub_2796	stats.test_paraRW_paraFP_grpspc.PARC_sub_2796_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2796_REML+tlrc'[40]'	\
			PARC_sub_2825	stats.test_paraRW_paraFP_grpspc.PARC_sub_2825_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2825_REML+tlrc'[40]'	\
			PARC_sub_2841	stats.test_paraRW_paraFP_grpspc.PARC_sub_2841_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2841_REML+tlrc'[40]'	\
			PARC_sub_2848	stats.test_paraRW_paraFP_grpspc.PARC_sub_2848_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2848_REML+tlrc'[40]'	\
			PARC_sub_2885	stats.test_paraRW_paraFP_grpspc.PARC_sub_2885_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2885_REML+tlrc'[40]'	\
			PARC_sub_2945	stats.test_paraRW_paraFP_grpspc.PARC_sub_2945_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2945_REML+tlrc'[40]'	\
			PARC_sub_2958	stats.test_paraRW_paraFP_grpspc.PARC_sub_2958_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2958_REML+tlrc'[40]'	\
			PARC_sub_2987	stats.test_paraRW_paraFP_grpspc.PARC_sub_2987_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2987_REML+tlrc'[40]'	\
			PARC_sub_2993	stats.test_paraRW_paraFP_grpspc.PARC_sub_2993_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_2993_REML+tlrc'[40]'	\
			PARC_sub_3010	stats.test_paraRW_paraFP_grpspc.PARC_sub_3010_REML+tlrc'[39]'	stats.test_paraRW_paraFP_grpspc.PARC_sub_3010_REML+tlrc'[40]'	\
			-HKtest \
			-unequal_variance \
		-model_outliers \
		-max_zeros .33    \
		-residual_Z


3drefit -atrstring AFNI_CLUSTSIM_NN1 file:ClustSim_paraTestGrp.NN1.niml \
	-atrstring AFNI_CLUSTSIM_MASK file:ClustSim_paraTestGrp.mask \
	-atrstring AFNI_CLUSTSIM_NN2 file:ClustSim_paraTestGrp.NN2.niml \
	-atrstring AFNI_CLUSTSIM_NN3 file:ClustSim_paraTestGrp.NN3.niml \
	 hi-lo_slope_paraRS_CTL-MDD+tlrc
