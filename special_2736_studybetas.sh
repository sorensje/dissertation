#!/bin/tcsh -xef

# ##### mumford betas
set subj = PARC_sub_2736

set studyPrefix = LSSbetas.BLOCK6.study
set study_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study/
set mvpa_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_mvpa/


#	estimtate betas study
# set subj_dir = ${study_dir}${subj}.results
# cd -v $subj_dir	
tcsh -xef ~/PARC_study/Jim_scripts/dissertation/decon_3DLSS_scaleup_study_messingwithHRF.sh ${subj} |& tee est_output_singleB_study.{$subj}
# COMBINE betas
tcsh -xef ~/PARC_study/Jim_scripts/try_mvpa/combine_LSS4mvpa.sh ${subj} $studyPrefix
# move files



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