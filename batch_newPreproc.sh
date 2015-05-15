#!/bin/tcsh/ -xef


set script_dir = '~/PARC_study/Jim_scripts/dissertation'

# run script to make study
# cd '/Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study'
# 
# 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 PARC_sub_2955 \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	
# 	tcsh ${script_dir}/preproc_study_fs_skullstripped.sh $subj fs_brain Study |& tee output.Study.${subj}.txt
# end
# 
# 
# 
# run script to make test
# cd '/Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test'
# 
# 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 PARC_sub_2955 \
# 	 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	 # no 2956 cause broken
# 	
# 	tcsh ${script_dir}/preproc_study_fs_skullstripped.sh $subj fs_brain Test |& tee output.Test.${subj}.txt
# end



# run script to make study
# cd '/Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study'
# 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 PARC_sub_2955 \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2956 in
# 	
# 	tcsh ${script_dir}/studyUnivariate.sh $subj fs_brain Test |& tee output.Test.${subj}.txt
# end


#######
# there was something wrong w/ PARC_sub_2993's behavioral files. that's fixed now. (I hope)

# ### univariate study
# cd '/Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study'
# set subj = PARC_sub_2993
# tcsh ${script_dir}/studyUnivariate.sh $subj fs_brain Test |& tee output.Test.${subj}.txt
# 
# ##### mumford betas
# set studyPrefix = LSSbetas.BLOCK6.study
# set testPrefix = LSSbetas.GAM.test
# 
# set study_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study/
# set test_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/
# set mvpa_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_mvpa/
#  
# 
# #	estimtate betas study
# set subj_dir = ${study_dir}${subj}.results
# cd -v $subj_dir	
# tcsh -xef ~/PARC_study/Jim_scripts/dissertation/decon_3DLSS_scaleup_study_messingwithHRF.sh ${subj} |& tee est_output_singleB_study.{$subj}
# # COMBINE betas
# tcsh -xef ~/PARC_study/Jim_scripts/try_mvpa/combine_LSS4mvpa.sh ${subj} $studyPrefix
# #move files
# cp *.uber.nii $mvpa_dir
# # fs_brain once
# cp fs_brain.subj.nii.gz $mvpa_dir/${subj}_fs_brain.subj.nii.gz
# #	estimtate betas test
# set subj_dir = ${test_dir}${subj}.results
# cd -v $subj_dir	
# 
# # ESTIMATE betas
# tcsh -xef ~/PARC_study/Jim_scripts/dissertation/decon_3DLSS_scaleup_test_messingwithHRF.sh ${subj} |& tee est_output_singleB_test.{$subj}
# # COMBINE betas
# tcsh -xef ~/PARC_study/Jim_scripts/try_mvpa/combine_LSS4mvpa.sh ${subj} $testPrefix 
# #Move files
# cp *.uber.nii $mvpa_dir
# 
# 
# set afnifilesDir =  /Users/Jim/PARC_study/scandata_for_analysis/${subj}/afni_files/
# cd $afnifilesDir
# cp *.csv $mvpa_dir
# 
# set anatdir = /Users/Jim/PARC_study/scandata_for_analysis/${subj}/anat
# cd anatdir
# cp *FSPGR_1.nii.gz $mvpa_dir	
# 

###### univariate TEST on EVERYONE

# cd '/Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test'
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 PARC_sub_2955 \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2956 in
# 		
# 	# univariate analysis, gamma function for hits vs. misses (stim onset), modeling all responses (no condition)
# # 	cd '/Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test'
# 	tcsh ${script_dir}/testUnivariate.sh $subj recallGAM |& tee output.recallGAM.${subj}.txt
#  	
# # 	set subj_dir = ${test_dir}${subj}.results
# # 	cd -v $subj_dir	
# 	# tlrc brains for later
# # 	@auto_tlrc  -base TT_N27+tlrc -no_ss -input ${subj}_fs_brain+orig
# 	
# end
# 
# #### WARP STUDY ##### 
# set study_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study/
# 
# 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 PARC_sub_2955 \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2956 in
# 		
# 
# 	set subj_dir = ${study_dir}${subj}.results
# 	cd -v $subj_dir	
# 	# tlrc brains for later
# 	@auto_tlrc  -base TT_N27+tlrc -no_ss -input anat_final.${subj}+orig
# 	adwarp -apar anat_final.${subj}+tlrc -dpar stats.fs_brain.$subj+orig -dxyz 3
# 	adwarp -apar anat_final.${subj}+tlrc -dpar $subj.fs_brain.study.rbuck+orig -dxyz 3
# 	
# end



# #### WARP TEST ##### 
# set study_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/
# 
# 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 PARC_sub_2955 \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2956 in
# 		
# 
# 	set subj_dir = ${study_dir}${subj}.results
# 	cd -v $subj_dir	
# 	# tlrc brains for later
# 	adwarp -apar ${subj}_fs_brain+tlrc -dpar stats.recallGAM.$subj+orig -dxyz 3
# 	adwarp -apar ${subj}_fs_brain+tlrc -dpar rbuck.recallGAM.$subj+orig -dxyz 3
# 	
# end

#### REMLS ##### 
# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study/Group_stats/univariate_reml_block6_postTest
# 
# tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/3dmem_study_MDD-CTL_hits-misses.sh
# tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/3dmem_study_CTL-MDD_hits-misses.sh
# tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/3dmem_study_MDD-CTL_pers-plc.sh
# tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/3dmem_study_CTL-MDD_pers-plc.sh
# 
# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/Group_stats/recallGAM
# 
# tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/3dmem_test_CTL-MDD_hit-miss.sh
# # tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/3dmem_test_MDD-CTL_hit-miss.sh
# 
# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/Group_stats/recallGAM
# 
# tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/3dmem_test_MDD-CTL_hit-miss-conserv.sh
# tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/3dmem_test_MDD-CTL_memJudge.sh
# tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/3dmem_test_CTL-MDD_memJudge.sh



# #### Parametric TEST ##### 
# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/
# # 
# # 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945  \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2955, 2928 out b/c too many NAs in corrected resp.
# 	
# 	tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/parametricTest.sh $subj paraTest |& tee output.paraTest.$subj.txt	
# end
# 
# # 
# set runs = (`count -digits 2 1 6`)
# 
# # #### WARP STUDY Blurs ##### 
# set study_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study/
# 
# 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 PARC_sub_2955 \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2956 in
# 		
# 
# 	set subj_dir = ${study_dir}${subj}.results
# 	cd -v $subj_dir
# 	# tlrc brains for later
# 	foreach run ( $runs )
# 			adwarp -apar anat_final.${subj}+tlrc -dpar pb03.$subj.r${run}.blur+orig -dxyz 3		
# 	end
# end
# 
# 
# 
# # #### WARP TEST Blurs ##### 
# set test_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/
# 
# 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 PARC_sub_2955 \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2956 in
# 		
# 
# 	set subj_dir = ${test_dir}${subj}.results
# 	cd -v $subj_dir	
# 	# tlrc brains for later
# 	foreach run ( $runs )
# 			adwarp -apar ${subj}_fs_brain+tlrc -dpar pb03.$subj.r${run}.blur+orig -dxyz 3		
# 	end	
# end


### Parametric Test - face vs place ### 

# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/
# # 
# # 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945  \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2955, 2829 out b/c too many NAs in corrected resp.
# 	
# 	tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/parametricTest_facePlace.sh $subj paraTest_FP |& tee output.paraTest_FP.$subj.txt	
# end


### Parametric Test - face vs place ### 
# 
# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/
# # 
# # 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945  \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2955, 2928 out b/c too many NAs in corrected resp.
# 	
# 	tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/parametricTest_LoHiRwd.sh $subj paraTest_Rwd |& tee output.paraTest_Rwd.$subj.txt
# 	adwarp -apar ${subj}_fs_brain+tlrc -dpar stats.paraTest_FP.${subj}+orig -dxyz 3
# 	adwarp -apar ${subj}_fs_brain+tlrc -dpar stats.paraTest_Rwd.${subj}+orig  -dxyz 3
# end


# ### parametric study all stim parametric ### 
# 
# 
# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study/
# 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945  \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2955, 2829 out b/c too many NAs in corrected resp.
# 	
# 	tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/parametricStudy_para_allStim.sh $subj studyParaStim_all |& tee output.studyParaStim_all.$subj.txt
# 	
# end


### group space-ify test files ### 
# 
# set test_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/
# # 
# # 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945  \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2955, 2829 out b/c too many NAs in corrected resp.
# 	
# 	set subj_dir = ${test_dir}${subj}.results
# 	cd -v $subj_dir	
# 
# 	adwarp -apar ${subj}_fs_brain+tlrc -dpar stats.paraTest_FP.${subj}_REML+orig -dxyz 3
# 	adwarp -apar ${subj}_fs_brain+tlrc -dpar stats.paraTest_Rwd.${subj}_REML+orig  -dxyz 3
# 	cp stats.paraTest_FP.${subj}_REML+tlrc* /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/Group_stats/recallGAM/
# 	cp stats.paraTest_Rwd.${subj}_REML+tlrc* /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/Group_stats/recallGAM/
# end

### group space-ify study files ### 
set study_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study/


foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 \
	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 \
	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
	# 2955, 2829 out b/c too many NAs in corrected resp.		

	set subj_dir = ${study_dir}${subj}.results
	cd -v $subj_dir
	# tlrc brains for later
	adwarp -apar anat_final.${subj}+tlrc -dpar stats.studyParaStim.${subj}_REML+orig -dxyz 3
	adwarp -apar anat_final.${subj}+tlrc -dpar stats.studyParaStim_all.${subj}_REML+orig -dxyz 3
	
	cp stats.studyParaStim.${subj}_REML+tlrc* /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study/Group_stats/univariate_parametric
	cp stats.studyParaStim_all.${subj}_REML+tlrc* /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study/Group_stats/univariate_parametric

	
end


