#!/bin/tcsh -xef

#####
# decon to make single betas for each subject for study and test.
#
# for study and test run relevant decon_3DLSS_scaleup_study_messingwithHRF.sh script to run deconvolve (to get x-mat) and 3dLSS (to get single beta estimations ala mumford)
#     # each of these scripts hard codes the names of the stim files and the HRF to use
# then run combine_LSS4mvpa to jam all the betas together into single file. 
#
####


set studyPrefix = LSSbetas.BLOCK6.study
set testPrefix = LSSbetas.GAM.test

echo ' ********************'
echo 'estimating study betas.... '
echo ' ********************'

# batch study
# foreach subj (PARC_sub_2903 PARC_sub_2908 PARC_sub_2917 PARC_sub_2938 PARC_sub_2945 PARC_sub_2956 PARC_sub_2955 PARC_sub_2958 PARC_sub_2927 PARC_sub_2967 PARC_sub_2939 PARC_sub_2993)
foreach subj (PARC_sub_3010 PARC_sub_2987)
	#	estimtate betas
	cd /Users/Jim/PARC_study/mvpa2/scaleup_study
	tcsh -xef ~/PARC_study/Jim_scripts/try_mvpa/decon_3DLSS_scaleup_study_messingwithHRF.sh ${subj} |& tee est_output_singleB_study.{$subj}
	# COMBINE betas
	set studydir = /Users/Jim/PARC_study/mvpa2/scaleup_study/${subj}.results
	cd studydir
	tcsh -xef ~/PARC_study/Jim_scripts/try_mvpa/combine_LSS4mvpa.sh ${subj} $studyPrefix 
end


## batch test (removed 2956, there's a problem w/ that one)
# foreach subj (PARC_sub_2903 PARC_sub_2908 PARC_sub_2917 PARC_sub_2938 PARC_sub_2945 PARC_sub_2955 PARC_sub_2958 PARC_sub_2927 PARC_sub_2967 PARC_sub_2939 PARC_sub_2993)
foreach subj (PARC_sub_3010 PARC_sub_2987)
	#	estimtate betas
	cd /Users/Jim/PARC_study/mvpa2/scaleup_test
	tcsh -xef ~/PARC_study/Jim_scripts/try_mvpa/decon_3DLSS_scaleup_test_messingwithHRF.sh ${subj} |& tee est_output_singleB_test.{$subj}
	# COMBINE betas
	set testdir = /Users/Jim/PARC_study/mvpa2/scaleup_test/${subj}.results
	cd testdir
	tcsh -xef ~/PARC_study/Jim_scripts/try_mvpa/combine_LSS4mvpa.sh ${subj} $testPrefix 
end


echo ' ********************'
echo 'estimating test betas.... '
echo ' ********************'


### move shit to analysis dir (removed 2956, there's a problem w/ that one)
foreach subj (PARC_sub_3010 PARC_sub_2987)
# foreach subj (PARC_sub_2903 PARC_sub_2908 PARC_sub_2917 PARC_sub_2938 PARC_sub_2945 PARC_sub_2955 PARC_sub_2958 PARC_sub_2927 PARC_sub_2967 PARC_sub_2939 PARC_sub_2993)
	set afnifilesDir =  /Users/Jim/PARC_study/scandata_for_analysis/${subj}/afni_files/
	cd afnifilesDir
	cp *.csv /Users/Jim/Dropbox/learn/pymvpa/common_mvpa_folder/
	
	set anatdir = /Users/Jim/PARC_study/scandata_for_analysis/${subj}/anat
	cd anatdir
	cp *FSPGR_1.nii.gz /Users/Jim/Dropbox/learn/pymvpa/common_mvpa_folder/
	
	set studydir = /Users/Jim/PARC_study/mvpa2/scaleup_study/${subj}.results
	cd studydir
	cp *.uber.nii /Users/Jim/Dropbox/learn/pymvpa/common_mvpa_folder/
	
	set testdir = /Users/Jim/PARC_study/mvpa2/scaleup_test/${subj}.results
	cd testdir
	cp *.uber.nii /Users/Jim/Dropbox/learn/pymvpa/common_mvpa_folder/
end

