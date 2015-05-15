#!/bin/tcsh -xef
## redoing comparison we already know about w/ outlier modeling


3dMEMA  -prefix tst_grpspc_para_MDD-CTL_goodFormat  \
	   -jobs 4      \
	   -groups CTL MDD\
	   -mask  allSubs_TestMask+tlrc \
		-set  para_CTL  \
			PARC_sub_2699	stats.paraTestgrp.PARC_sub_2699_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2699_REML+tlrc'[4]'	\
			PARC_sub_2754	stats.paraTestgrp.PARC_sub_2754_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2754_REML+tlrc'[4]'	\
			PARC_sub_2778	stats.paraTestgrp.PARC_sub_2778_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2778_REML+tlrc'[4]'	\
			PARC_sub_2786	stats.paraTestgrp.PARC_sub_2786_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2786_REML+tlrc'[4]'	\
			PARC_sub_2792	stats.paraTestgrp.PARC_sub_2792_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2792_REML+tlrc'[4]'	\
			PARC_sub_2796	stats.paraTestgrp.PARC_sub_2796_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2796_REML+tlrc'[4]'	\
			PARC_sub_2825	stats.paraTestgrp.PARC_sub_2825_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2825_REML+tlrc'[4]'	\
			PARC_sub_2841	stats.paraTestgrp.PARC_sub_2841_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2841_REML+tlrc'[4]'	\
			PARC_sub_2848	stats.paraTestgrp.PARC_sub_2848_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2848_REML+tlrc'[4]'	\
			PARC_sub_2885	stats.paraTestgrp.PARC_sub_2885_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2885_REML+tlrc'[4]'	\
			PARC_sub_2945	stats.paraTestgrp.PARC_sub_2945_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2945_REML+tlrc'[4]'	\
			PARC_sub_2958	stats.paraTestgrp.PARC_sub_2958_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2958_REML+tlrc'[4]'	\
			PARC_sub_2987	stats.paraTestgrp.PARC_sub_2987_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2987_REML+tlrc'[4]'	\
			PARC_sub_2993	stats.paraTestgrp.PARC_sub_2993_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2993_REML+tlrc'[4]'	\
			PARC_sub_3010	stats.paraTestgrp.PARC_sub_3010_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_3010_REML+tlrc'[4]'	\
		-set  para_MDD  \
			PARC_sub_2718	stats.paraTestgrp.PARC_sub_2718_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2718_REML+tlrc'[4]'	\
			PARC_sub_2726	stats.paraTestgrp.PARC_sub_2726_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2726_REML+tlrc'[4]'	\
			PARC_sub_2736	stats.paraTestgrp.PARC_sub_2736_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2736_REML+tlrc'[4]'	\
			PARC_sub_2747	stats.paraTestgrp.PARC_sub_2747_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2747_REML+tlrc'[4]'	\
			PARC_sub_2759	stats.paraTestgrp.PARC_sub_2759_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2759_REML+tlrc'[4]'	\
			PARC_sub_2761	stats.paraTestgrp.PARC_sub_2761_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2761_REML+tlrc'[4]'	\
			PARC_sub_2787	stats.paraTestgrp.PARC_sub_2787_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2787_REML+tlrc'[4]'	\
			PARC_sub_2788	stats.paraTestgrp.PARC_sub_2788_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2788_REML+tlrc'[4]'	\
			PARC_sub_2799	stats.paraTestgrp.PARC_sub_2799_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2799_REML+tlrc'[4]'	\
			PARC_sub_2838	stats.paraTestgrp.PARC_sub_2838_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2838_REML+tlrc'[4]'	\
			PARC_sub_2853	stats.paraTestgrp.PARC_sub_2853_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2853_REML+tlrc'[4]'	\
			PARC_sub_2865	stats.paraTestgrp.PARC_sub_2865_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2865_REML+tlrc'[4]'	\
			PARC_sub_2874	stats.paraTestgrp.PARC_sub_2874_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2874_REML+tlrc'[4]'	\
			PARC_sub_2879	stats.paraTestgrp.PARC_sub_2879_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2879_REML+tlrc'[4]'	\
			PARC_sub_2903	stats.paraTestgrp.PARC_sub_2903_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2903_REML+tlrc'[4]'	\
			PARC_sub_2917	stats.paraTestgrp.PARC_sub_2917_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2917_REML+tlrc'[4]'	\
			PARC_sub_2927	stats.paraTestgrp.PARC_sub_2927_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2927_REML+tlrc'[4]'	\
			PARC_sub_2938	stats.paraTestgrp.PARC_sub_2938_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2938_REML+tlrc'[4]'	\
			PARC_sub_2939	stats.paraTestgrp.PARC_sub_2939_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2939_REML+tlrc'[4]'	\
			PARC_sub_2956	stats.paraTestgrp.PARC_sub_2956_REML+tlrc'[3]'	stats.paraTestgrp.PARC_sub_2956_REML+tlrc'[4]'	\
			-HKtest \
			-model_outliers \
			-max_zeros .33    \
			-unequal_variance \
			-residual_Z


3drefit -atrstring AFNI_CLUSTSIM_NN1 file:ClustSim_paraTestGrp.NN1.niml \
	-atrstring AFNI_CLUSTSIM_MASK file:ClustSim_paraTestGrp.mask \
	-atrstring AFNI_CLUSTSIM_NN2 file:ClustSim_paraTestGrp.NN2.niml \
	-atrstring AFNI_CLUSTSIM_NN3 file:ClustSim_paraTestGrp.NN3.niml \
	tst_grpspc_para_MDD-CTL_goodFormat+tlrc
