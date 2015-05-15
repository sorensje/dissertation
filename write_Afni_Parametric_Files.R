write_Afni_Parametric_Files <- function(sData, fileName, onsetVarName, paraVarName, possibleParaValues,n_blocks){
  # setup
  missingLevels <- setdiff(possibleParaValues, unique(sData[, paraVarName]))
#   n_blocks <- length(unique(sData$block)) #bad idea! if subsetted data, will miss missing blocks.
  onsets<- list()
  trialCount <- 0 
  
  #loop over block to get times.
  for (iter_block in 1: n_blocks){
    onsets_iter <- paste0(sData[sData$block==iter_block ,onsetVarName],"*",sData[sData$block==iter_block ,paraVarName])
    if(length(onsets_iter) >0){
      onsets[[iter_block]] <- onsets_iter
    }else (onsets[[iter_block]] <-"*") #necessary for empty blocks
    trialCount <- trialCount + length(onsets_iter)
  }
  
  
  if(length(missingLevels) > 2 ) {
    cat("\n warning! ", fileName," is missing levels: ", missingLevels)
  }
  
  # write files
  sink(file=fileName)
  # necessary for levels of parametric regressor that are absent
  for(missL in missingLevels){
    cat(paste0("-1","*",missL," "))
  }
  # write onsets
  for (iter_block in 1: n_blocks){
    cat(onsets[[iter_block]],"\n",sep=" ")
  }
  sink(file=NULL)
}