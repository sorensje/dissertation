#!/bin/tcsh -xef


3dMEMA  -prefix memJudge_MDD-CTL_tlrcMSK  \
	   -jobs 4      \
	   -groups CTL MDD\
	   -mask tlrcTemplate_mask+tlrc \
		-set  judge_CTL  \
			PARC_sub_2699	rbuck.recallGAM.PARC_sub_2699+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2699+tlrc'[18]'	\
			PARC_sub_2754	rbuck.recallGAM.PARC_sub_2754+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2754+tlrc'[18]'	\
			PARC_sub_2778	rbuck.recallGAM.PARC_sub_2778+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2778+tlrc'[18]'	\
			PARC_sub_2784	rbuck.recallGAM.PARC_sub_2784+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2784+tlrc'[18]'	\
			PARC_sub_2786	rbuck.recallGAM.PARC_sub_2786+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2786+tlrc'[18]'	\
			PARC_sub_2792	rbuck.recallGAM.PARC_sub_2792+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2792+tlrc'[18]'	\
			PARC_sub_2796	rbuck.recallGAM.PARC_sub_2796+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2796+tlrc'[18]'	\
			PARC_sub_2825	rbuck.recallGAM.PARC_sub_2825+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2825+tlrc'[18]'	\
			PARC_sub_2834	rbuck.recallGAM.PARC_sub_2834+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2834+tlrc'[18]'	\
			PARC_sub_2841	rbuck.recallGAM.PARC_sub_2841+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2841+tlrc'[18]'	\
			PARC_sub_2848	rbuck.recallGAM.PARC_sub_2848+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2848+tlrc'[18]'	\
			PARC_sub_2885	rbuck.recallGAM.PARC_sub_2885+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2885+tlrc'[18]'	\
			PARC_sub_2945	rbuck.recallGAM.PARC_sub_2945+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2945+tlrc'[18]'	\
			PARC_sub_2955	rbuck.recallGAM.PARC_sub_2955+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2955+tlrc'[18]'	\
			PARC_sub_2958	rbuck.recallGAM.PARC_sub_2958+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2958+tlrc'[18]'	\
			PARC_sub_2987	rbuck.recallGAM.PARC_sub_2987+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2987+tlrc'[18]'	\
			PARC_sub_2993	rbuck.recallGAM.PARC_sub_2993+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2993+tlrc'[18]'	\
			PARC_sub_3010	rbuck.recallGAM.PARC_sub_3010+tlrc'[17]'	rbuck.recallGAM.PARC_sub_3010+tlrc'[18]'	\
		-set  judge_MDD  \
			PARC_sub_2718	rbuck.recallGAM.PARC_sub_2718+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2718+tlrc'[18]'	\
			PARC_sub_2726	rbuck.recallGAM.PARC_sub_2726+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2726+tlrc'[18]'	\
			PARC_sub_2736	rbuck.recallGAM.PARC_sub_2736+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2736+tlrc'[18]'	\
			PARC_sub_2747	rbuck.recallGAM.PARC_sub_2747+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2747+tlrc'[18]'	\
			PARC_sub_2759	rbuck.recallGAM.PARC_sub_2759+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2759+tlrc'[18]'	\
			PARC_sub_2761	rbuck.recallGAM.PARC_sub_2761+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2761+tlrc'[18]'	\
			PARC_sub_2787	rbuck.recallGAM.PARC_sub_2787+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2787+tlrc'[18]'	\
			PARC_sub_2788	rbuck.recallGAM.PARC_sub_2788+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2788+tlrc'[18]'	\
			PARC_sub_2799	rbuck.recallGAM.PARC_sub_2799+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2799+tlrc'[18]'	\
			PARC_sub_2829	rbuck.recallGAM.PARC_sub_2829+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2829+tlrc'[18]'	\
			PARC_sub_2838	rbuck.recallGAM.PARC_sub_2838+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2838+tlrc'[18]'	\
			PARC_sub_2853	rbuck.recallGAM.PARC_sub_2853+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2853+tlrc'[18]'	\
			PARC_sub_2865	rbuck.recallGAM.PARC_sub_2865+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2865+tlrc'[18]'	\
			PARC_sub_2874	rbuck.recallGAM.PARC_sub_2874+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2874+tlrc'[18]'	\
			PARC_sub_2879	rbuck.recallGAM.PARC_sub_2879+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2879+tlrc'[18]'	\
			PARC_sub_2903	rbuck.recallGAM.PARC_sub_2903+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2903+tlrc'[18]'	\
			PARC_sub_2917	rbuck.recallGAM.PARC_sub_2917+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2917+tlrc'[18]'	\
			PARC_sub_2927	rbuck.recallGAM.PARC_sub_2927+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2927+tlrc'[18]'	\
			PARC_sub_2938	rbuck.recallGAM.PARC_sub_2938+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2938+tlrc'[18]'	\
			PARC_sub_2939	rbuck.recallGAM.PARC_sub_2939+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2939+tlrc'[18]'	\
			PARC_sub_2956	rbuck.recallGAM.PARC_sub_2956+tlrc'[17]'	rbuck.recallGAM.PARC_sub_2956+tlrc'[18]'	\
		-max_zeros .33    \
	   -model_outliers \
	   -unequal_variance \
	   -residual_Z

