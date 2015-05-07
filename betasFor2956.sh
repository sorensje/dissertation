#!/bin/tcsh -xef

#####
# decon to make single betas for each subject for study and test.
#  this one is just for 2956 after I did the custom preproc
####


set studyPrefix = LSSbetas.BLOCK6.study
set testPrefix = LSSbetas.GAM.test

echo ' ********************'
echo 'estimating study betas.... '
echo ' ********************'

set study_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study/
set test_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/
set mvpa_dir = /Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_mvpa/
 

set subj = PARC_sub_2956
### do all study

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


echo ' ********************'
echo 'estimating test betas.... '
echo ' ********************'


set subj_dir = ${test_dir}${subj}.results
cd -v $subj_dir	

# ESTIMATE betas
# tcsh -xef ~/PARC_study/Jim_scripts/dissertation/decon_3DLSS_scaleup_test_messingwithHRF.sh ${subj} |& tee est_output_singleB_test.{$subj}
# COMBINE betas
# tcsh -xef ~/PARC_study/Jim_scripts/try_mvpa/combine_LSS4mvpa.sh ${subj} $testPrefix 
#Move files
cp *.uber.nii $mvpa_dir



echo ' ********************'
echo ' moving files .... '
echo ' ********************'


# ### move shit to analysis dir (removed 2956, there's a problem w/ that one)

set afnifilesDir =  /Users/Jim/PARC_study/scandata_for_analysis/${subj}/afni_files/
cd $afnifilesDir
cp *.csv $mvpa_dir

set anatdir = /Users/Jim/PARC_study/scandata_for_analysis/${subj}/anat
cd anatdir
cp *FSPGR_1.nii.gz $mvpa_dir	


#
