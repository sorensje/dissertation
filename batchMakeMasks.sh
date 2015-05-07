#!/bin/tcsh -xef

# got to mvpa dir
set mvpa_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_mvpa/
cd $mvpa_dir

set

foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 PARC_sub_2955 \
	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
	# 2956 in
	
	#make parafusi mask
	tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/make_fs_mask_parafusi.sh $subj
	
 	# create mean func volume (for plotting and such)
	3dTstat -mean -prefix $subj.mean_func.r02.nii.gz pb02.$subj.r02.volreg+orig

	
end
