aggregate_testfiles_PARC_disser<-function(sub,nblocks){
  # must run Rfilewriter_PARC_Scan__combine_tests3 first 

  
  ### get subject specific file names. 
  behavscanner <- list()
  behavscanner$loc <- "/Users/Jim/Dropbox/PARC_Scan_behavioralfiles/"
  behavscanner$files <- dir(behavscanner$loc)
  behavscanner$files <- grep(sub,behavscanner$files,value=TRUE)
  behavscanner$sub_test_files <- sort(grep('*_test_block\\d_scrubbed.mat',behavscanner$files,value=TRUE))
  behavscanner$sub_study_files <- sort(grep('*_study_block\\d_study.mat',behavscanner$files,value=TRUE))
  
  setwd(behavscanner$loc)
  
  uber_test <- matreaderPARC_debugged(behavscanner$sub_test_files[1]) #works cause sorted above
  for(block in 1:nblocks){
    #   matlab_file <- matreaderPARC2(behavscanner$sub_test_files[block])
    matlab_file <- matreaderPARC_debugged(behavscanner$sub_test_files[block])
    uber_test[uber_test$block==block,] <- matlab_file[matlab_file$block==block,]
    print(block)
  }
  uber_test$Subject <- sub
  return(uber_test)
}

