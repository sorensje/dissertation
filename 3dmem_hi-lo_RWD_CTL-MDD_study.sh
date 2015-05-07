#!/bin/tcsh -xef


3dMEMA  -prefix stud_hi-loRWD_CTL-MDD_tlrcMSK  \
	   -jobs 4      \
	   -groups MDD CTL \
	   -mask tlrcTemplate_mask+tlrc \
	   -set  hit-mss_MDD  \
			PARC_sub_2718	PARC_sub_2718.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2718.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2726	PARC_sub_2726.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2726.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2747	PARC_sub_2747.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2747.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2759	PARC_sub_2759.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2759.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2761	PARC_sub_2761.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2761.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2787	PARC_sub_2787.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2787.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2788	PARC_sub_2788.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2788.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2799	PARC_sub_2799.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2799.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2829	PARC_sub_2829.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2829.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2838	PARC_sub_2838.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2838.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2853	PARC_sub_2853.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2853.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2865	PARC_sub_2865.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2865.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2874	PARC_sub_2874.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2874.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2879	PARC_sub_2879.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2879.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2903	PARC_sub_2903.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2903.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2917	PARC_sub_2917.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2917.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2927	PARC_sub_2927.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2927.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2938	PARC_sub_2938.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2938.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2939	PARC_sub_2939.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2939.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2956	PARC_sub_2956.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2956.fs_brain.study.rbuck+tlrc'[18]'	\
		-set  hit-mss_CTL  \
			PARC_sub_2699	PARC_sub_2699.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2699.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2754	PARC_sub_2754.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2754.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2778	PARC_sub_2778.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2778.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2784	PARC_sub_2784.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2784.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2786	PARC_sub_2786.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2786.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2792	PARC_sub_2792.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2792.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2796	PARC_sub_2796.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2796.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2825	PARC_sub_2825.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2825.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2834	PARC_sub_2834.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2834.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2841	PARC_sub_2841.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2841.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2848	PARC_sub_2848.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2848.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2885	PARC_sub_2885.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2885.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2945	PARC_sub_2945.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2945.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2955	PARC_sub_2955.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2955.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2958	PARC_sub_2958.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2958.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2987	PARC_sub_2987.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2987.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_2993	PARC_sub_2993.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_2993.fs_brain.study.rbuck+tlrc'[18]'	\
			PARC_sub_3010	PARC_sub_3010.fs_brain.study.rbuck+tlrc'[17]'	PARC_sub_3010.fs_brain.study.rbuck+tlrc'[18]'	\
		-max_zeros .33    \
	   -residual_Z

