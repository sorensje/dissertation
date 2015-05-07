### get behavioral data for subject
# modified version, worked on airplane


library('R.matlab')
library('stringr')
library('R.utils')
source("/Users/Jim/PARC_study/Jim_scripts/matreaderPARC_dbugtes.R")
source("~/Dropbox/for airplane parc/Jim_scripts/matreaderPARC.R")
source("/Users/Jim/PARC_study/Jim_scripts/dissertation/aggregate_studyfiles_dissertation_PARC.R")
source("/Users/Jim/PARC_study/Jim_scripts/dissertation/aggregate_testfiles_dissertation_PARC.R")



#### variables to change 
setwd("~/PARC_study/behavioral_data/")
studyfilename <- 'all_sub_study_4_27_15.csv'
testfilename <- 'all_sub_test__4_27_15.csv'
#how many blocks? 
nblocks <- 6

# 
### which subs?
# subs <- dir("~/PARC_study/scandata_for_analysis/freesurf_subdir/")
# subs <- grep("PARC",subs,value=TRUE)
# subs <- substring(subs,10,14)
# subs<- subs[!subs==2782] # didn't use 2782

subList <- read.csv('~/PARC_study/PARC_date_exam_subject.csv') # need to update this with info from nims 
subs <- subList$Subject
subs<- subs[!subs %in% c(2782,2844)] # didn't use 2782, missing correct file for 2853
subs <- sort(subs)



#### get subs 
# print(subs[1])
# allsubs_dat <- aggregate_studyfiles_PARC(subs[1],nblocks)
# aggregate_studyfiles_PARC(2792,nblocks)
#subs <-c("26", "2788" ,"2792" ,"2796" ,"2799")

allsubs_dat <- NULL
for (ii in 1:length(subs)){
  print(subs[ii])
  sub_studydat <- NULL
  sub_studydat <- aggregate_studyfiles_PARC_diss(subs[ii],nblocks)
  sub_studydat$Subject <- subs[ii]
  if(length(sub_studydat) > 0 ){
    allsubs_dat <- rbind(allsubs_dat,sub_studydat)
  } else{
    print(paste("problem aggregating subject:", subs[ii]))
  }
}

xtabs(~Subject,allsubs_dat) #any duplicates?



#### get test

# print(subs[1])
allsubs_dat_test <- NULL

for (ii in 1:length(subs)){
  print(subs[ii])
  sub_testDat <- NULL
  sub_testDat<-aggregate_testfiles_PARC_disser(subs[ii],nblocks)
  sub_testDat$Subject <- subs[ii]
  
  if(length(sub_testDat) > 0 ){
    allsubs_dat_test <- rbind(allsubs_dat_test,sub_testDat)
  } else{
    print(paste("problem aggregating subject:", subs[ii]))
  }
}

xtabs(~Subject,allsubs_dat_test) #any duplicates?
allsubs_dat_test_nodupes <- allsubs_dat_test[!duplicated(allsubs_dat_test),]
xtabs(~Subject,allsubs_dat_test_nodupes) #any duplicates?



### write data 

write.csv(allsubs_dat,studyfilename,row.names=FALSE)
write.csv(allsubs_dat_test_nodupes,testfilename,row.names=FALSE)


