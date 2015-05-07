### checking which participants need preprocessing


scan_analysis_overfolder <-"~/PARC_study/scandata_for_analysis/" 
setwd(scan_analysis_overfolder)
subdirpossibilities <- paste("PARC_sub_",subs$Subject,sep="")
alreadymade <- dir()
tomake <- setdiff(factor(subdirpossibilities),factor(alreadymade)) #subects w/o data?

# check data 

preProcessed <- NULL

for(sub in tomake){
  filePattern <- paste0("/Users/Jim/PARC_study/mvpa2/scaleup_study/",sub,".results/pb01.", sub, ".r01.oblique.tshift+orig.HEAD")
  print(filePattern)
  print(file.exists(filePattern))
  if(file.exists(filePattern)){
    preProcessed <- c(preProcessed,sub)
  }
}

needPreProcessing <- setdiff(tomake,preProcessed)
