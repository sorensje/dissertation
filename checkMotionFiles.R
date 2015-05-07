#### Check motion files created during afni pre-processing. 

library('stringr')
library('ggplot2')
library('reshape2')
# get censored TRs from censor 1D
afni_listCensoredTRs <- function(filename){
  com <- paste0('/Users/Jim/abin/1d_tool.py -infile ', filename, ' -show_trs_censored comma')
  blah<-system(com,intern=TRUE)
  TRs <- as.numeric(unlist(strsplit(blah, ","))) # return as vector of numbers
  if(length(TRs) == 0 ) TRs <- NA
  TRs
}


# list files
# sub <- 2993
# baseFileLoc <- "~/PARC_study/mvpa2/scaleup_study/"
# subSuffix <- paste0("PARC_sub_",sub,".results/")                   
# motionFile <- paste0(baseFileLoc,subSuffix,"motion_r02_PARC_sub_",sub,"_censor.1D")
# afni_listCensoredTRs(file)


### Get motion info for all subs for study ####

baseFileLoc <- "~/PARC_study/mvpa2/scaleup_study/"
subjDirs <- list.dirs(baseFileLoc, recursive = FALSE)
subjDirs <- grep(".results", subjDirs , value = TRUE)

## setup up data file. 
motionInfo <- data.frame()

for(sD in subjDirs){
  motionFiles <- dir(sD,  patter = "_censor.1D") #get all motion files in subjDir
  #pull our subject 
  subj <- gsub("motion_r0\\d_", "", motionFiles[1])
  subj <- gsub("_censor.1D", "", subj)
  
  # update
  cat("\n Checking...", sD)
  
  #interate over motion files, extract censored TRs
  for(mF in motionFiles){
    motionFile <- paste0(sD,"/", mF)
    TRs <- afni_listCensoredTRs(motionFile)
    run <- as.numeric(str_extract(mF, "\\d\\d"))
    tempDF <- list(subID = subj, motionFileLoc = baseFileLoc, motionFile = mF, run = run, censoredTR = TRs, n_Censored_TRs = sum(is.finite(TRs)))
    motionInfo <- rbind(motionInfo, data.frame(tempDF))
  }  
}


### Get motion info for all subs for test ####

baseFileLoc <- "~/PARC_study/mvpa2/scaleup_test/"
subjDirs <- list.dirs(baseFileLoc, recursive = FALSE)
subjDirs <- grep(".results", subjDirs , value = TRUE)


for(sD in subjDirs){
  motionFiles <- dir(sD,  patter = "_censor.1D") #get all motion files in subjDir
  #pull our subject 
  subj <- gsub("motion_r0\\d_", "", motionFiles[1])
  subj <- gsub("_censor.1D", "", subj)
  
  # update
  cat("\n Checking...", sD)
  
  #interate over motion files, extract censored TRs
  for(mF in motionFiles){
    motionFile <- paste0(sD,"/", mF)
    TRs <- afni_listCensoredTRs(motionFile)
    run <- as.numeric(str_extract(mF, "\\d\\d"))
    tempDF <- list(subID = subj, motionFileLoc = baseFileLoc, motionFile = mF, run = run, censoredTR = TRs, n_Censored_TRs = sum(is.finite(TRs)))
    motionInfo <- rbind(motionInfo, data.frame(tempDF))
  }  
}

#recoding and such.

motionInfo$preProc_type <- gsub("~/PARC_study/mvpa2/","", motionInfo$motionFileLoc)
motionInfo$preProc_type <-gsub("/","", motionInfo$preProc_type)

# write.csv(motionInfo,"~/Dropbox/Dissertation/analysis tracking/motionTRs.csv", row.names  = FALSE)



### view...

motionTotals <- unique(motionInfo[ ,c('motionFileLoc','subID','run','n_Censored_TRs','preProc_type')])
ggplot(motionTotals, aes(x = n_Censored_TRs)) + geom_histogram()

# some subjects suck...
xtabs(~subID + n_Censored_TRs, motionTotals)
# I'll need to maybe stablish some cutoffs here.

### write subj totals
motionTotals.m <- melt(motionTotals[ ,c('subID','run','n_Censored_TRs','preProc_type')], id.vars = c('subID','run','preProc_type'))
motionInfoSubTotals <- dcast(data = motionTotals.m, subID ~ preProc_type + run)

write.csv(motionInfoSubTotals,"~/Dropbox/Dissertation/analysis tracking/motionTRs_shortForm.csv", row.names  = FALSE)


