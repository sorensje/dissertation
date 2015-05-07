aggregate_studyfiles_PARC_diss<-function(sub,nblocks){
#   Function to aggregate matlab reulsts files (so can get timings)
  
  ### get subject specific file names. 
  
  ### get all of subject data in one place. 
  behavscanner <- list()
  behavscanner$loc <- "/Users/Jim/Dropbox/PARC_Scan_behavioralfiles/"
  behavscanner$files <- dir(behavscanner$loc)
  behavscanner$files <- grep(sub,behavscanner$files,value=TRUE)
  behavscanner$sub_test_files <- sort(grep('*_test_block\\d_scrubbed.mat',behavscanner$files,value=TRUE))
  behavscanner$sub_study_files <- sort(grep('*_study_block\\d_study.mat',behavscanner$files,value=TRUE))
  
  setwd(behavscanner$loc)
  
  ### read in study data
  uber_study <- matreaderPARC(behavscanner$sub_study_files[1]) #works cause sorted above
  for(block in 1:nblocks){
    print(block)
    matlab_file <- matreaderPARC(behavscanner$sub_study_files[block])
    uber_study[uber_study$block==block,] <- matlab_file[matlab_file$block==block,] 
    
  }
  uber_study$Subject <- sub
  return(uber_study)
}


