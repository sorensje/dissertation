library('reshape2')

### get regrssor issues df.


bothTest <- readRDS("/Users/Jim/Dropbox/Dissertation/data_files/bothTest_toMakeRegressors.rds")
bothTest$postTest <- factor(bothTest$finaltest_correct, labels = c('miss','hit'))
# hitMiss 
hitmiss <- dcast(bothTest[ , c('Subject','postTest')], Subject~postTest,length)
hitmiss_persplc <- dcast(bothTest[ , c('Subject','postTest','imgType')], Subject~postTest+imgType)
hitmiss_rwd <- dcast(bothTest[ , c('Subject','postTest','reward')], Subject~postTest+reward)
persplc_rwd <- dcast(bothTest[ , c('Subject','imgType','reward')], Subject~imgType+reward)
hitmiss_persplc_rwd <- dcast(bothTest[ , c('Subject','postTest','imgType','reward')], Subject~postTest+imgType+reward)

binCounts <- merge(hitmiss,hitmiss_persplc)
binCounts <- merge(binCounts,hitmiss_rwd)
binCounts <- merge(binCounts,persplc_rwd)
binCounts <- merge(binCounts,hitmiss_persplc_rwd)
binCounts

#
write.csv(binCounts, "~/Dropbox/Dissertation/analysis tracking/binCounts_regressors.csv",row.names = FALSE)

bins <- names(binCounts)[-1] #drop subject
criterion <- 6 

for(b in bins){
  counts <- "no problems"
  indexLowTrials <- binCounts[ , b] <= criterion  
  if(sum(indexLowTrials) > 0 ){
    counts <- paste0(" ",binCounts[indexLowTrials, 'Subject'],": ",binCounts[indexLowTrials, b])
  }
  cat("\n ",b, ":\t", counts)
}


## parametric version
clarity_persplc_rwd <- dcast(bothTest[ , c('Subject','corrected_resp','imgType','reward')], Subject~imgType+reward, value.var = 'corrected_resp', function(x)length(na.omit(unique(x))))
clarity_rwd <- dcast(bothTest[ , c('Subject','corrected_resp','reward')], Subject~reward, value.var = 'corrected_resp', function(x)length(na.omit(unique(x))))
clarity_persplc <- dcast(bothTest[ , c('Subject','corrected_resp','imgType')], Subject~imgType, value.var = 'corrected_resp', function(x)length(na.omit(unique(x))))

clarityBins <- merge(clarity_persplc_rwd,clarity_rwd)
clarityBins <- merge(clarityBins,clarity_persplc)


binCounts <- clarityBins
bins <- names(binCounts)[-1] #drop subject
criterion <- 2

for(b in bins){
  counts <- "no problems"
  indexLowTrials <- binCounts[ , b] <= criterion  
  if(sum(indexLowTrials) > 0 ){
    counts <- paste0(" ",binCounts[indexLowTrials, 'Subject'],": ",binCounts[indexLowTrials, b])
  }
  cat("\n ",b, ":\t", counts)
}
