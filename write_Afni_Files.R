write_Afni_Files <- function(sData, fileName, onsetVarName, n_blocks){
  # setup
#   n_blocks <- length(unique(sData$block))
  onsets<- list()
  trialCount <- 0 
  
  #loop over block to get times.
  for (iter_block in 1: n_blocks){
    onsets_iter <- sData[sData$block==iter_block ,onsetVarName]
    if(length(onsets_iter) >0){
      onsets[[iter_block]] <- onsets_iter
    }else (onsets[[iter_block]] <-"*") #necessary for empty blocks
    trialCount <- trialCount + length(onsets_iter)
  }
  
  if(trialCount < 8) {
    cat("\n warning only ", trialCount, "unique trials in regressor: ", fileName)
  }
  
  
  # write files
  sink(file=fileName)
  # write onsets
  for (iter_block in 1: n_blocks){
    cat(onsets[[iter_block]],"\n",sep=" ")
  }
  sink(file=NULL)
}