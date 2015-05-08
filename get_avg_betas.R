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

## visualize..
library('ggplot2')
betas <- merge(subDF,subDat, by.x = 'subID', by.y = 'ID')

ggplot(betas, aes(x = Group, y = paraTest_dlpfc_beta, color = Group)) + geom_boxplot() + geom_point()

## some problem w/... 2784: no variety in responses.
xtabs(~corrected_resp, bothtest[bothtest$Subject == 2784, ])


  