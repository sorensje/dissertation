#!/bin/tcsh -xef

#####
# decon to make single betas for each subject for study and test.
#
# for study and test run relevant decon_3DLSS_scaleup_study_messingwithHRF.sh script to run deconvolve (to get x-mat) and 3dLSS (to get single beta estimations ala mumford)
#     # each of these scripts hard codes the names of the stim files and the HRF to use
# then run combine_LSS4mvpa to jam all the betas together into single file. 
#
# this file is being run on newly reprocessed brains (on SNI)
####


set studyPrefix = LSSbetas.BLOCK6.study
set testPrefix = LSSbetas.GAM.test

echo ' ********************'
echo 'estimating study betas.... '
echo ' ********************'

set study_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study/
set test_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/
set mvpa_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_mvpa/
 

foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 PARC_sub_2955 \
	PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
	# no 2956 ..for now
	set subj_dir = ${study_dir}${subj}.results
	cd -v $subj_dir	
	#	estimtate betas
	tcsh -xef ~/PARC_study/Jim_scripts/dissertation/decon_3DLSS_scaleup_study_messingwithHRF.sh ${subj} |& tee est_output_singleB_study.{$subj}
	# COMBINE betas
	tcsh -xef ~/PARC_study/Jim_scripts/try_mvpa/combine_LSS4mvpa.sh ${subj} $studyPrefix
	#move files
	cp *.uber.nii $mvpa_dir
	# fs_brain once
	cp fs_brain.subj.nii.gz $mvpa_dir/${subj}_fs_brain.subj.nii.gz
end


echo ' ********************'
echo 'estimating test betas.... '
echo ' ********************'


## batch test (removed 2956, there's a problem w/ that one)

foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 PARC_sub_2955 \
	PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
	#	estimtate betas
	set subj_dir = ${test_dir}${subj}.results
	cd -v $subj_dir	

	# ESTIMATE betas
	tcsh -xef ~/PARC_study/Jim_scripts/dissertation/decon_3DLSS_scaleup_test_messingwithHRF.sh ${subj} |& tee est_output_singleB_test.{$subj}
	# COMBINE betas
	tcsh -xef ~/PARC_study/Jim_scripts/try_mvpa/combine_LSS4mvpa.sh ${subj} $testPrefix 
	#Move files
	cp *.uber.nii $mvpa_dir
end


echo ' ********************'
echo ' moving files .... '
echo ' ********************'


# ### move shit to analysis dir (removed 2956, there's a problem w/ that one)
foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 PARC_sub_2955 \
	PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
	
	set afnifilesDir =  /Users/Jim/PARC_study/scandata_for_analysis/${subj}/afni_files/
	cd $afnifilesDir
	cp *.csv $mvpa_dir
	
	set anatdir = /Users/Jim/PARC_study/scandata_for_analysis/${subj}/anat
	cd anatdir
	cp *FSPGR_1.nii.gz $mvpa_dir	
end

#
