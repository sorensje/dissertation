#!/bin/tcsh -xef

# MVPA directory
set mvpa_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_mvpa/
# FS directory
set fs_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/finishedRecons_Marissa
# Study dir
set study_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study/

# copy over label file

# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903  \
foreach subj (PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 PARC_sub_2955 \
	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
	# 2956 in #2908 didn't make it over.
	
	# freesurfer sub is slightly different of form PARC_1234
	set fs_sub = `echo $subj| sed 's/_sub_/_/g'`
# 	
	cd -v ${fs_dir}/${fs_sub}/mri
# 	
	mri_label2vol --seg aparc+aseg.mgz --regheader aparc+aseg.mgz --o $subj.labelVolume.nii.gz --temp orig/001.mgz 
	cp $subj.labelVolume.nii.gz $mvpa_dir
# 	cp -v ${study_dir}/${subj}.results/pb02.${subj}.r02.volreg+orig* ${mvpa_dir}
end

# 
# 3dcalc -a temp.gmroi_volume.nii.gz -expr 'amongst(a,\
# 1007,\
# 2007,\
# 1016,\
# 2016\
# )'  -prefix temp.unsampled.${subj}.$prefix.nii.gz 
# 
# 
# cp temp.unsampled.${subj}.$prefix.nii.gz $current_dir
# cp /Users/Jim/PARC_study/mvpa2/scaleup_test/${subj}.results/pb04.${subj}.r02.scale+orig* $current_dir
# rm temp.*
# 
# cd $current_dir
# 3dcopy temp.unsampled.${subj}.$prefix.nii.gz temp.afni.unsampled.${subj}.$prefix 
# 3dresample -master pb04.$subj.r02.scale+orig -rmode NN -input temp.afni.unsampled.${subj}.$prefix+orig -prefix temp.$subj.$prefix
# 3dAFNItoNIFTI -prefix $subj.$prefix temp.$subj.$prefix+orig
# rm temp.*
# rm pb04.${subj}.r02.scale+orig*
# 
# 
# end

