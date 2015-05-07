#!/bin/tcsh -xef

# batch study
cd /Users/Jim/PARC_study/mvpa2/scaleup_study

echo `pwd`

# preprocess
# foreach subj (PARC_sub_2736 PARC_sub_2834 PARC_sub_2841 PARC_sub_2844 PARC_sub_2848 PARC_sub_2853 PARC_sub_2865 PARC_sub_2874 PARC_sub_2879 PARC_sub_2885)
# foreach subj (PARC_sub_2903 PARC_sub_2908 PARC_sub_2917 PARC_sub_2938 PARC_sub_2945 PARC_sub_2956 PARC_sub_2955 PARC_sub_2958 PARC_sub_2927 PARC_sub_2967 PARC_sub_2939 PARC_sub_2993)
foreach subj (PARC_sub_2987 PARC_sub_3010)
	tcsh -xef ~/PARC_study/Jim_scripts/try_mvpa/preproc_study.sh ${subj} |& tee preproc_study_output.{$subj}
end


# batch test

cd /Users/Jim/PARC_study/mvpa2/scaleup_test

echo `pwd`

# preprocess
# foreach subj (PARC_sub_2903 PARC_sub_2908 PARC_sub_2917 PARC_sub_2938 PARC_sub_2945 PARC_sub_2956 PARC_sub_2955 PARC_sub_2958 PARC_sub_2927 PARC_sub_2967 PARC_sub_2939 PARC_sub_2993)
foreach subj (PARC_sub_2987 PARC_sub_3010)
	tcsh -xef ~/PARC_study/Jim_scripts/try_mvpa/preproc_test.sh ${subj} |& tee preproc_test_output.{$subj}
end
