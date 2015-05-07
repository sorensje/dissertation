### read in files
#
# filenames are meant to be defined in 'get_behavioral_data_dissertation'


# studyfilename <- '~/Dropbox/PARC_Scan_behavioralfiles/all_sub_study_9_5_14.csv'
# testfilename <- '~/Dropbox/PARC_Scan_behavioralfiles/all_sub_test_9_5_14.csv'
# setwd('~/Dropbox/PARC_Scan_behavioralfiles/')
# 
# studyfilename <- 'all_sub_study_4_27_15.csv'
# testfilename <- 'all_sub_test__4_27_15.csv'

#study
studytdat <- read.csv(studyfilename)
# str(studytdat)
studytdat$trial <- studytdat$index
studytdat$Subject <- factor(studytdat$Subject)
studytdat$study_trial <- studytdat$trial

#test
test_dat <- read.csv(testfilename)
# str(test_dat)
test_dat$test_trial <- test_dat$index
test_dat$Subject <- factor(test_dat$Subject)
subs <- unique(test_dat$Subject)
  
  
## correct information now can come from Kira stacked
scoredInfo <- read.csv("~/Dropbox/Dissertation/PARC_dissertation_analysis/scoring vocal data/kiraScoredStacked_annotate.csv")

# recode vars
scoredInfo$correct <- as.numeric(scoredInfo$ScoredwithNextTrials == 1)
scoredInfo$Subject <- factor(scoredInfo$participant)
scoredInfo$final_trial <- scoredInfo$trial
scoredInfo$imgFile <- scoredInfo$Actual


  
# merge in study and test info
to_merge <- scoredInfo[,c('imgFile','correct','Subject','final_trial')]
names(to_merge)<- c('imgFile','finaltest_correct','Subject','final_trial')
  
print("Creating bothest and study_finalcorrect")
bothtest <- merge(test_dat,to_merge)
study_finalcorrect <-  merge(studytdat,to_merge)

## reward variable is off
bothtest$reward <- substr(bothtest$condkey,2,2)
study_finalcorrect$reward <- substr(study_finalcorrect$condkey,2,2)

### reshuffle
study_finalcorrect <- study_finalcorrect[order(study_finalcorrect$index),]
study_finalcorrect <- study_finalcorrect[order(study_finalcorrect$Subject),]

bothtest <- bothtest[order(bothtest$index),]
bothtest <- bothtest[order(bothtest$Subject),]

## correct multiple responses in matlab files. 
bothtest$threeresps = is.finite(bothtest$Rate.resp)+is.finite(bothtest$resp)+is.finite(bothtest$ISI.resp)
bothtest$abnormal_resp = !(bothtest$threeresps==1 & is.finite(bothtest$Rate.resp))

bothtest$corrected_resp = 0
for( ii in 1:length(bothtest[,1])){
  if(bothtest$abnormal_resp[ii]==FALSE){
    bothtest$corrected_resp[ii] = bothtest$Rate.resp[ii]
  } 
  else {
    if(is.finite(bothtest$resp[ii])){
      bothtest$corrected_resp[ii] = bothtest$resp[ii]
    } else if (is.finite(bothtest$Rate.resp[ii])){
      bothtest$corrected_resp[ii] = bothtest$Rate.resp[ii]
    } else if (is.finite(bothtest$ISI.resp[ii])){
      bothtest$corrected_resp[ii] = bothtest$ISI.resp[ii]
    } else{
      bothtest$corrected_resp[ii] = NA
    }
  }
#     print(ii)
}


