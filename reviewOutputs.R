#### check univariate warnings!

### read in data files
bothtest <- readRDS("~/Dropbox/Dissertation/data_files/bothTest_toMakeRegressors.rds")
study_finalcorrect <- readRDS("~/Dropbox/Dissertation/data_files/study_finalcorrect_toMakeRegressors.rds")


### output study files. 
overfolder <- "/Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study/"
setwd(overfolder)
subs <- as.character(unique(study_finalcorrect$Subject))

### load output files
s <- subs[1]
s <- '2967'
for(s in subs){
 outputName <- paste0("output.Test.PARC_sub_",s,".txt") 
 txt <- scan(outputName,what='character')
 if(any(sapply(txt,function(x)grepl("FATAL",x))))
   cat("\n Fatal error for sub ", s)
}

## I have fatal errors for 2980 and 2967.  Not tooooooo bad.
# 2967 was going to be thrown out for VERY poor performance anyway, 2908 was super jittery

