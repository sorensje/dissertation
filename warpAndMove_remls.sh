#!/bin/tcsh -xef


## warp and move rbuckets.

set test_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/


foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
	 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945  \
	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
	# 2829, 2955 out b/c of problems w/ responses 2908 out for mvmt 2967 is out b/c they suck at memory
		

	set subj_dir = ${test_dir}${subj}.results
	cd -v $subj_dir	
	# tlrc brains for later
	adwarp -apar ${subj}_fs_brain+tlrc -dpar stats.paraTest.${subj}_REML+orig -dxyz 3
	cp  stats.paraTest.${subj}_REML+tlrc* ${test_dir}Group_stats/recallGAM/
end


cd ${test_dir}Group_stats/recallGAM/


3dMEMA  -prefix tst_para_CTL-MDD_tlrcMSK  \
	   -jobs 4      \
	   -groups MDD CTL\
	   -mask tlrcTemplate_mask+tlrc \
		-set  hit-mss_MDD  \
			PARC_sub_2718	stats.paraTest.PARC_sub_2718_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2718_REML+tlrc'[4]'	\
			PARC_sub_2726	stats.paraTest.PARC_sub_2726_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2726_REML+tlrc'[4]'	\
			PARC_sub_2736	stats.paraTest.PARC_sub_2736_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2736_REML+tlrc'[4]'	\
			PARC_sub_2747	stats.paraTest.PARC_sub_2747_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2747_REML+tlrc'[4]'	\
			PARC_sub_2759	stats.paraTest.PARC_sub_2759_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2759_REML+tlrc'[4]'	\
			PARC_sub_2761	stats.paraTest.PARC_sub_2761_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2761_REML+tlrc'[4]'	\
			PARC_sub_2787	stats.paraTest.PARC_sub_2787_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2787_REML+tlrc'[4]'	\
			PARC_sub_2788	stats.paraTest.PARC_sub_2788_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2788_REML+tlrc'[4]'	\
			PARC_sub_2799	stats.paraTest.PARC_sub_2799_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2799_REML+tlrc'[4]'	\
			PARC_sub_2838	stats.paraTest.PARC_sub_2838_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2838_REML+tlrc'[4]'	\
			PARC_sub_2853	stats.paraTest.PARC_sub_2853_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2853_REML+tlrc'[4]'	\
			PARC_sub_2865	stats.paraTest.PARC_sub_2865_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2865_REML+tlrc'[4]'	\
			PARC_sub_2874	stats.paraTest.PARC_sub_2874_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2874_REML+tlrc'[4]'	\
			PARC_sub_2879	stats.paraTest.PARC_sub_2879_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2879_REML+tlrc'[4]'	\
			PARC_sub_2903	stats.paraTest.PARC_sub_2903_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2903_REML+tlrc'[4]'	\
			PARC_sub_2917	stats.paraTest.PARC_sub_2917_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2917_REML+tlrc'[4]'	\
			PARC_sub_2927	stats.paraTest.PARC_sub_2927_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2927_REML+tlrc'[4]'	\
			PARC_sub_2938	stats.paraTest.PARC_sub_2938_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2938_REML+tlrc'[4]'	\
			PARC_sub_2939	stats.paraTest.PARC_sub_2939_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2939_REML+tlrc'[4]'	\
			PARC_sub_2956	stats.paraTest.PARC_sub_2956_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2956_REML+tlrc'[4]'	\
		-set  hit-mss_CTL  \
			PARC_sub_2699	stats.paraTest.PARC_sub_2699_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2699_REML+tlrc'[4]'	\
			PARC_sub_2754	stats.paraTest.PARC_sub_2754_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2754_REML+tlrc'[4]'	\
			PARC_sub_2778	stats.paraTest.PARC_sub_2778_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2778_REML+tlrc'[4]'	\
			PARC_sub_2784	stats.paraTest.PARC_sub_2784_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2784_REML+tlrc'[4]'	\
			PARC_sub_2786	stats.paraTest.PARC_sub_2786_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2786_REML+tlrc'[4]'	\
			PARC_sub_2792	stats.paraTest.PARC_sub_2792_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2792_REML+tlrc'[4]'	\
			PARC_sub_2796	stats.paraTest.PARC_sub_2796_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2796_REML+tlrc'[4]'	\
			PARC_sub_2825	stats.paraTest.PARC_sub_2825_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2825_REML+tlrc'[4]'	\
			PARC_sub_2834	stats.paraTest.PARC_sub_2834_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2834_REML+tlrc'[4]'	\
			PARC_sub_2841	stats.paraTest.PARC_sub_2841_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2841_REML+tlrc'[4]'	\
			PARC_sub_2848	stats.paraTest.PARC_sub_2848_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2848_REML+tlrc'[4]'	\
			PARC_sub_2885	stats.paraTest.PARC_sub_2885_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2885_REML+tlrc'[4]'	\
			PARC_sub_2945	stats.paraTest.PARC_sub_2945_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2945_REML+tlrc'[4]'	\
			PARC_sub_2958	stats.paraTest.PARC_sub_2958_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2958_REML+tlrc'[4]'	\
			PARC_sub_2987	stats.paraTest.PARC_sub_2987_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2987_REML+tlrc'[4]'	\
			PARC_sub_2993	stats.paraTest.PARC_sub_2993_REML+tlrc'[3]'	stats.paraTest.PARC_sub_2993_REML+tlrc'[4]'	\
			PARC_sub_3010	stats.paraTest.PARC_sub_3010_REML+tlrc'[3]'	stats.paraTest.PARC_sub_3010_REML+tlrc'[4]'	\
			-max_zeros .33    \
			-residual_Z

