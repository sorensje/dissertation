### checking missing analysis

# I've created a spreadsheet that tells me where the reml files should be, and what they should be, but I haven't systematically checked to make sure everything came through.
# Let's do that here. this will be a script I can modify to verify the existance of files for a certain subject.

bothTest <- readRDS("/Users/Jim/Dropbox/Dissertation/data_files/bothTest_toMakeRegressors.rds")

overfolder <- "/Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_study/"
# overfolder <- "/Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_test/"
remlPattern <- quote(paste0('stats.paraStimB6grpspc.', sub_prefix,'_REML'))

subs <- unique(study_finalcorrect$Subject)
sub_prefixes <- paste("PARC_sub_",subs,sep="")

# sub_iter = 1
# subs <- 3010


notFound <- vector()

for(sub_iter in 1:length(subs)){  
  # set subject specific files
  subject <- subs[sub_iter]
  sub_prefix<-paste("PARC_sub_",subject,sep="")
  subfolder <- paste(overfolder,sub_prefix,".results/",sep="")
  setwd(subfolder)
  if(length(dir(subfolder,pattern = eval(remlPattern))) == 0){
    notFound <- c(notFound, as.character(subject))
  }
}
cat("\n example search string: ", eval(remlPattern))
cat("\n no files found for ", notFound)  