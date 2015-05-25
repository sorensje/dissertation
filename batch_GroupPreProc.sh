#!/bin/tcsh/ -xef

# this script will run the group space preprocessing.  god I can't believe I'm doing this again.

set script_dir = '~/PARC_study/Jim_scripts/dissertation'


# #### GRoup ##### 
# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_test
# 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 PARC_sub_2955 \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	
# 	tcsh ${script_dir}/preproc_groupSpace.sh $subj Test |& tee output.groupProcTest.$subj.txt	
# 	
# end
# 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945  \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2955, 2928 out b/c too many NAs in corrected resp.
# 	
# 	tcsh ${script_dir}/parametricTest_afterGroupPreProc.sh $subj paraTestgrp |& tee output.paraTestgrp.$subj.txt	
# end
# 
# #3 failed for 2699 b/c folder existed.
# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_test
# 	
# tcsh ${script_dir}/parametricTest_afterGroupPreProc.sh PARC_sub_2699 paraTestgrp |& tee output.paraTestgrp.PARC_sub_2699.txt	

# set testDir = /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_test
# 
# ## copy group masks into folder. 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945  PARC_sub_2955\
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2955, 2928 IN
# 	
# 	cp -v ${testDir}/${subj}.results/mask_group+tlrc.BRIK.gz	${testDir}/GroupMasks/${subj}.mask_group+tlrc.BRIK.gz
# 	cp -v ${testDir}/${subj}.results/mask_group+tlrc.HEAD	${testDir}/GroupMasks/${subj}.mask_group+tlrc.HEAD
# end
# 


# ### re proc study
# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_study
# 
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945  PARC_sub_2955\
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	
# # 	tcsh ${script_dir}/preproc_groupSpace.sh $subj Study |& tee output.groupProc.Study.$subj.txt	
# # 	tcsh ${script_dir}/univariateStudy_afterGroupSpc.sh $subj paraStimB6grpspc |& tee output.paraStimB6grpspc.$subj.txt
# # 	tcsh ${script_dir}/parametricStudy_para_allStim_grpSpc.sh $subj studParaAllgrpspc |& tee output.studParaAllgrpspc.$subj.txt
# end

# ### Parametric Test - face vs place ### 
# # 
# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_test
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945  \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2955, 2829 out b/c too many NAs in corrected resp.
# 	
# # 	tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/parametricTest_facePlace_grpSpc.sh $subj paraTest_FP_grp |& tee output.paraTest_FP_grp.$subj.txt	
# # 	tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/parametricTest_LoHiRwd_grpSpc.sh $subj paraTest_paraRwd_grp |& tee output.paraTest_paraRwd_grp.$subj.txt	
# end


#### finishing up study decon. #### 
# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_study

# foreach subj (PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945  PARC_sub_2955\
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	
# 	tcsh ${script_dir}/univariateStudy_afterGroupSpc.sh $subj paraStimB6grpspc |& tee output.paraStimB6grpspc.$subj.txt
# end
# 

# move group masks.
# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_study
# set studydir = /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_study
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945 PARC_sub_2955 \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2955, 2829 out b/c too many NAs in corrected resp.
# 	
# 	cp -v ${studydir}/${subj}.results/mask_group+tlrc.BRIK.gz	${studydir}/GroupMasks/${subj}.mask_group+tlrc.BRIK.gz
# 	cp -v ${studydir}/${subj}.results/mask_group+tlrc.HEAD	${studydir}/GroupMasks/${subj}.mask_group+tlrc.HEAD
# end


# 
# 
# #### rest of decons on list for study  overnight may 13
# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_study
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
# 	tcsh ${script_dir}/parametricStudy_para_allStim_grpSpc.sh $subj studParaAllgrpspc |& tee output.studParaAllgrpspc.$subj.txt
# 	tcsh ${script_dir}/parametricStudy_para_FcPlc_grpSpc.sh $subj studyParaStim_grpspc_FP |& tee output.studyParaStim_grpspc_FP.$subj.txt
# 	tcsh ${script_dir}/parametricStudy_paraRwd_fcplc_grpSpc.sh $subj studyParaRWD_grpspc_stimFP |& tee output.studyParaRWD_grpspc_stimFP.$subj.txt
# end
# 
# 
# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_test
# foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
# 	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
# 	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
# 	PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
# 	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
# 	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945  \
# 	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
# 	# 2955, 2829 out b/c too many NAs in corrected resp.
# 	
# 	tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/parametricTest_paraFP_paraRW_grpSpc.sh $subj test_paraRW_paraFP_grpspc |& tee output.test_paraRW_paraFP_grpspc.$subj.txt	
# end



# 
# ### run some memas
# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_study/GroupStats
# 
# tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/3dmem_study_hi-lowRWD_MDD-CTL_paraStimB6grpspcsh.sh
# tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/3dmem_study_hi-lowRWD_paraStimB6grpspcsh.sh
# tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/3dmem_study_hi-lowRWD_hits_MDD-CTL_paraStimB6grpspcsh.sh
# tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/3dmem_study_hi-lowRWD_hits_paraStimB6grpspcsh.sh
# # end overnight overnight may 13


### get blur estimates for just hippocampus

# cd /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_study/
cd /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_test/
foreach subj (PARC_sub_2699 PARC_sub_2718 PARC_sub_2726 PARC_sub_2736 PARC_sub_2747 \
	PARC_sub_2754 PARC_sub_2759 PARC_sub_2761 PARC_sub_2778 PARC_sub_2784 PARC_sub_2786 \
	PARC_sub_2787 PARC_sub_2788 PARC_sub_2792 PARC_sub_2796 PARC_sub_2799 PARC_sub_2825 \
	PARC_sub_2829 PARC_sub_2834 PARC_sub_2838 PARC_sub_2841 PARC_sub_2848 PARC_sub_2853 \
	PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885 PARC_sub_2903 PARC_sub_2908 \
	PARC_sub_2917 PARC_sub_2927 PARC_sub_2938 PARC_sub_2939 PARC_sub_2945  PARC_sub_2955\
	PARC_sub_2956 PARC_sub_2958 PARC_sub_2967 PARC_sub_2987 PARC_sub_2993 PARC_sub_3010)
	tcsh /Users/Jim/PARC_study/Jim_scripts/dissertation/hippoBlurest_grpspc.sh $subj

end


