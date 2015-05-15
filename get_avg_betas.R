## pull parameter estimates for effect.

bothtest <- readRDS("~/Dropbox/Dissertation/data_files/bothTest_toMakeRegressors.rds")
study_finalcorrect <- readRDS("~/Dropbox/Dissertation/data_files/study_finalcorrect_toMakeRegressors.rds")

source("~/Dropbox/R/R_helperfunctions/RtoAfni_helper.R")


betafolder <- '/Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/Group_stats/recallGAM'



setwd(betafolder)

subs <- unique(bothtest$Subject)
subs <- subs[! subs %in% c(2955,2829, 2908)]

subDF <- data.frame(subID = subs)

for(s in subs){
  subBucket <- paste0('stats.paraTest.PARC_sub_',s,'_REML+tlrc')
  avgB <- afni_getavgbeta(bucketfilename = subBucket,index = 3, 'dlpfc_paraAll_p05_mask+tlrc')
  subDF[subDF$subID == s, 'paraTest_dlpfc_beta'] <- avgB
}

saveRDS(subDF, "~/Dropbox/Dissertation/data_files/dlpfcBetat_paraTest.rds")
## visualize..
library('ggplot2')
betas <- merge(subDF,subDat, by.x = 'subID', by.y = 'ID')

ggplot(betas, aes(x = Group, y = paraTest_dlpfc_beta, color = Group)) + geom_boxplot() + geom_point()

## some problem w/... 2784: no variety in responses.
xtabs(~corrected_resp, bothtest[bothtest$Subject == 2784, ])
afni_getavgbeta(bucketfilename = 'stats.paraTest.PARC_sub_',2784,'_REML+tlrc',index = 4, 'dlpfc_paraAll_p05_mask+tlrc')

### dlpfc mask from group betas.

## group space mask n shit.
# 3dclust -1Dformat -nosum -1dindex 5 -1tindex 5 -2thresh -2.728 2.728 -inmask -dxyz=1 1.44 100 /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_test/Group_Stats/tst_grpspc_para_CTL-MDD_no2784_tlrcMSK+tlrc.HEAD
# Writing mask dataset ./Rdlpfc_grpSpc_mask+tlrc.BRIK
# + 3dclust -1Dformat -nosum -1dindex 5 -1tindex 5 -2thresh -2.728 2.728 -inmask -dxyz=1 -savemask Rdlpfc_grpSpc_mask 1.44 100 /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_test/Group_Stats/tst_grpspc_para_CTL-MDD_no2784_tlrcMSK+tlrc.HEAD


### getting betas from group space version.
betafolder <- '/Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_test/Group_Stats/'

setwd(betafolder)
subs <- unique(bothtest$Subject)
subs <- subs[! subs %in% c(2955,2829, 2908, 2784)]
subDF <- data.frame(subID = subs)

for(s in subs){
  subBucket <- paste0('stats.paraTestgrp.PARC_sub_',s,'_REML+tlrc')
  avgB <- afni_getavgbeta(bucketfilename = subBucket,index = 3, 'Rdlpfc_grpSpc_mask+tlrc')
  subDF[subDF$subID == s, 'paraTest_dlpfc_beta'] <- avgB
}

betas <- merge(subDF,subDat, by.x = 'subID', by.y = 'ID')
ggplot(betas, aes(x = Group, y = paraTest_dlpfc_beta, color = Group)) + geom_boxplot() + geom_point()
saveRDS(subDF, "~/Dropbox/Dissertation/data_files/dlpfcBetat_paraTestALLstim_slope_grpSpc.rds")



