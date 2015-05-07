#!/bin/tcsh -xef


3dMEMA  -prefix hits-miss_CTL-MDD_conserv  \
	   -jobs 4      \
	   -groups MDD CTL \
	   -mask tlrcTemplate_mask+tlrc \
	   		-set  h-m_MDD  \
			PARC_sub_2718	rbuck.recallGAM.PARC_sub_2718+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2718+tlrc'[12]'	\
			PARC_sub_2726	rbuck.recallGAM.PARC_sub_2726+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2726+tlrc'[12]'	\
			PARC_sub_2736	rbuck.recallGAM.PARC_sub_2736+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2736+tlrc'[12]'	\
			PARC_sub_2747	rbuck.recallGAM.PARC_sub_2747+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2747+tlrc'[12]'	\
			PARC_sub_2759	rbuck.recallGAM.PARC_sub_2759+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2759+tlrc'[12]'	\
			PARC_sub_2761	rbuck.recallGAM.PARC_sub_2761+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2761+tlrc'[12]'	\
			PARC_sub_2788	rbuck.recallGAM.PARC_sub_2788+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2788+tlrc'[12]'	\
			PARC_sub_2799	rbuck.recallGAM.PARC_sub_2799+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2799+tlrc'[12]'	\
			PARC_sub_2829	rbuck.recallGAM.PARC_sub_2829+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2829+tlrc'[12]'	\
			PARC_sub_2838	rbuck.recallGAM.PARC_sub_2838+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2838+tlrc'[12]'	\
			PARC_sub_2853	rbuck.recallGAM.PARC_sub_2853+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2853+tlrc'[12]'	\
			PARC_sub_2917	rbuck.recallGAM.PARC_sub_2917+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2917+tlrc'[12]'	\
			PARC_sub_2927	rbuck.recallGAM.PARC_sub_2927+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2927+tlrc'[12]'	\
			PARC_sub_2938	rbuck.recallGAM.PARC_sub_2938+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2938+tlrc'[12]'	\
			PARC_sub_2956	rbuck.recallGAM.PARC_sub_2956+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2956+tlrc'[12]'	\
		-set  h-m_CTL  \
			PARC_sub_2754	rbuck.recallGAM.PARC_sub_2754+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2754+tlrc'[12]'	\
			PARC_sub_2778	rbuck.recallGAM.PARC_sub_2778+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2778+tlrc'[12]'	\
			PARC_sub_2786	rbuck.recallGAM.PARC_sub_2786+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2786+tlrc'[12]'	\
			PARC_sub_2796	rbuck.recallGAM.PARC_sub_2796+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2796+tlrc'[12]'	\
			PARC_sub_2825	rbuck.recallGAM.PARC_sub_2825+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2825+tlrc'[12]'	\
			PARC_sub_2834	rbuck.recallGAM.PARC_sub_2834+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2834+tlrc'[12]'	\
			PARC_sub_2841	rbuck.recallGAM.PARC_sub_2841+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2841+tlrc'[12]'	\
			PARC_sub_2848	rbuck.recallGAM.PARC_sub_2848+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2848+tlrc'[12]'	\
			PARC_sub_2885	rbuck.recallGAM.PARC_sub_2885+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2885+tlrc'[12]'	\
			PARC_sub_2945	rbuck.recallGAM.PARC_sub_2945+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2945+tlrc'[12]'	\
			PARC_sub_2955	rbuck.recallGAM.PARC_sub_2955+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2955+tlrc'[12]'	\
			PARC_sub_2958	rbuck.recallGAM.PARC_sub_2958+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2958+tlrc'[12]'	\
			PARC_sub_2987	rbuck.recallGAM.PARC_sub_2987+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2987+tlrc'[12]'	\
			PARC_sub_2993	rbuck.recallGAM.PARC_sub_2993+tlrc'[11]'	rbuck.recallGAM.PARC_sub_2993+tlrc'[12]'	\
			PARC_sub_3010	rbuck.recallGAM.PARC_sub_3010+tlrc'[11]'	rbuck.recallGAM.PARC_sub_3010+tlrc'[12]'	\
		-max_zeros .33    \
	   -model_outliers \
	   -unequal_variance \
	   -residual_Z

