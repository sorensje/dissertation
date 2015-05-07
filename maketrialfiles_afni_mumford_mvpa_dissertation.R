#### make timing vectors for analysis
#important shit happens at line 90
# unlike other timing  files... these get written to scan data for analysis.  fucking christ.

# function(TRstodrop,TRlength,Subject,conditions)


#get necessary files
source("/Users/Jim/PARC_study/Jim_scripts/binarytimingvector.R")
source("/Users/Jim/PARC_study/Jim_scripts/nearestTR.R")
source("~/Dropbox/R/helperfunctions/zeropad.R")
setwd("~/PARC_study/scandata_for_analysis/")


####  read in files (from)old version ##  
# studyfilename <- '~/Dropbox/PARC_Scan_behavioralfiles/all_sub_study_9_5_14.csv'
# testfilename <- '~/Dropbox/PARC_Scan_behavioralfiles/all_sub_test_9_5_14.csv'
# readPARCBehaviorfiles(studyfilename,testfilename,"~/Dropbox/PARC_Scan_behavioralfiles/PARC_subData.csv") #this is broken, should be more functions than it is... but whatever.
# source("~/PARC_study/Jim_scripts/pipeline/read_behavioral_files.R") #read in behavioral files
# sub _iter = 1


#### read in new files dissertation version. ####

### I did this after I added 3010 and 2987
# studyfilename <- 'all_sub_study_4_27_15.csv'
# testfilename <- 'all_sub_test__4_27_15.csv'
# source("/Users/Jim/PARC_study/Jim_scripts/dissertation/read_behavioral_files_dissertation.R")
# saveRDS(bothtest, "~/Dropbox/Dissertation/data_files/bothTest_toMakeRegressors.rds")
# saveRDS(study_finalcorrect, "~/Dropbox/Dissertation/data_files/study_finalcorrect_toMakeRegressors.rds")

bothtest <- readRDS("~/Dropbox/Dissertation/data_files/bothTest_toMakeRegressors.rds")
study_finalcorrect <- readRDS("~/Dropbox/Dissertation/data_files/study_finalcorrect_toMakeRegressors.rds")

####  make study files #######

# variables specific to 

TRstodrop<-3
TRlength<-2
rewardtime <- 1.6 #seconds
stim_time <- 6 # seconds
condition <- "finaltest_correct"
# overfolder <-"~/PARC_study/batch_afni/"
overfolder <-"~/PARC_study/scandata_for_analysis/"


### change later

subs <- unique(study_finalcorrect$Subject)
# subs <- c(2736, 2834, 2841, 2844, 2848, 2853, 2865, 2874, 2879, 2885) #hack: all I need for now no overwrites pls
# subs <- c(2903, 2908, 2917, 2938, 2945, 2956, 2955, 2958, 2927, 2967, 2939, 2993) # dissertation batch
# subs <- c(2987,3010)
sub_prefixes <- paste("PARC_sub_",subs,sep="")
#sub_iter = 1
# setwd("~/PARC_study/mvpa2/setup_data/testsub/mumfordfiles/")


## create afni file folders
for(sub_iter in 1:length(subs)){  
  # create afni folders if necessary
  subject <- subs[sub_iter]
  sub_prefix<-paste("PARC_sub_",subs[sub_iter],sep="")
  sub_overfolder <- paste(overfolder,"PARC_sub_",subject,sep="")
  setwd(sub_overfolder)
  folders <- dir()
  if (!'afni_files' %in% folders){
    cat("\n no file for", as.character(subject))
    dir.create('afni_files')
  }
}


for(sub_iter in 1:length(subs)){  
  # set subject specific files
  subject <- subs[sub_iter]
  sub_prefix<-paste("PARC_sub_",subs[sub_iter],sep="")
  subfolder <- paste(overfolder,"PARC_sub_",subject,"/afni_files",sep="")
#   subfolder <- paste(overfolder,"PARC_sub_",subject,".results/stimuli/",sep="")
  setwd(subfolder)

  
  trialtype <- "study"
  sub_data <- study_finalcorrect[study_finalcorrect$Subject==subject,]
  sub_data <- sub_data[sort(sub_data$index),]
  
  ##### use scanner start time to calculate onsets/offsets!
  sub_data$onset_fromscannerstart<-sub_data$onsetRaw-sub_data$scannerstart
  sub_data$offset_fromscannerstart<-sub_data$offsetRaw-sub_data$scannerstart
  
  # drop how ever many seconds worth of TRs we're dropping
  sub_data$trial_onset_trim <-sub_data$onset_fromscannerstart-(TRstodrop*TRlength) 
  sub_data$trial_offset_trim <- sub_data$offset_fromscannerstart-(TRstodrop*TRlength)
  
  sub_data$reward_onset <- sub_data$trial_onset_trim 
  sub_data$reward_onset <- round(sub_data$trial_onset_trim,1)
  sub_data$encode_onset_trim <- sub_data$trial_onset_trim + rewardtime + sub_data$RwdIntFix
  sub_data$encode_onset_trim <- round(sub_data$encode_onset_trim,1)
  sub_data$trial_duration <-rewardtime + sub_data$RwdIntFix +stim_time +sub_data$PostFix
  
  # make global onsets 
  
  ## global onsets 
  sub_data$global_onset <- sub_data$trial_onset_trim #just to initialize
  n_trials <- max(sub_data$trial)
  for( trial_iter in 2:n_trials){
    sub_data$global_onset[trial_iter] <- sub_data$global_onset[trial_iter-1]+ sub_data$trial_duration[trial_iter-1]
  }
  
  # local onset 
  sub_data$local_onset <- round(sub_data$trial_onset_trim,1) #just to initialize
  
  ## get duration of blocks (not necessary anymore?)
  n_blocks <- length(unique(sub_data$block))
  max_time_run <- rep(0,n_blocks)
  block_onset_global <- rep(0,n_blocks)
  for (iter_block in 1: n_blocks){
    runtrials <- sub_data[sub_data$block==iter_block,'trial']
    last_trial <- max(runtrials)
    first_trial<- min(runtrials)
    max_time_run[iter_block] <- sub_data[sub_data$trial==last_trial,'trial_onset_trim']+ sub_data[sub_data$trial==last_trial,'trial_duration']
    block_onset_global[iter_block] <- sub_data[sub_data$trial==first_trial,'global_onset']
  }
  
  # create vectors for later getting total time/TR info
  max_time_run_TR <- nearestTR(max_time_run,TRlength) #round to 2 sec
  total_time <- sum(max_time_run)
  total_time_TR <- nearestTR(total_time,TRlength)
  
  # block_onset_global <- round(block_onset_global/1000,0)
  block_onset_global_TR <- nearestTR(block_onset_global,TRlength)
  
  for (iter_block in 1: n_blocks){
#     filename_all<- paste(sub_prefix,"_run_",zeropad(iter_block),"_",trialtype,"_trialonsets.txt",sep="")
#     filename_all<- paste(sub_prefix,"_run_",zeropad(iter_block),"_",trialtype,"_RWDonsets.1D",sep="") 
#     onsets <- sub_data[sub_data$block==iter_block,'trial_onset_trim']
    filename_all<- paste(sub_prefix,"_run_",zeropad(iter_block),"_",trialtype,"_trialonsets.1D",sep="")    
    onsets <- sub_data[sub_data$block==iter_block,'encode_onset_trim']
    sink(file=filename_all)
    cat(onsets,sep=" ")
    sink(file=NULL)
  }
  
  
#   resulstsfolder <- paste('/Users/Jim/PARC_study/mvpa2/scaleup_study/',sub_prefix,'.results/stimuli',sep="")
# #   setwd(resulstsfolder)
#   
#   for (iter_block in 1: n_blocks){
#     #     filename_all<- paste(sub_prefix,"_run_",zeropad(iter_block),"_",trialtype,"_trialonsets.txt",sep="")
#     filename_all<- paste(sub_prefix,"_run_",zeropad(iter_block),"_",trialtype,"_RWDonsets.1D",sep="") 
#     onsets <- sub_data[sub_data$block==iter_block,'trial_onset_trim']
#     #     filename_all<- paste(sub_prefix,"_run_",zeropad(iter_block),"_",trialtype,"_trialonsets.1D",sep="")    
#     #onsets <- sub_data[sub_data$block==iter_block,'encode_onset_trim']
#     sink(file=filename_all)
#     cat(onsets,sep=" ")
#     sink(file=NULL)
#   }
  
  
  dataframename <- paste(sub_prefix,"_",trialtype,"_timingdata.csv",sep="")
  write.csv(sub_data,dataframename,row.names=FALSE)
  
}


##### make test file ####

TRstodrop<-3
TRlength<-2
rewardtime <- 1.6 #seconds
stim_time <- 6 # seconds
response_time <- 4
# condition <- "finaltest_correct"


# subs <- unique(bothtest$Subject)
for(sub_iter in 1:length(subs)){
  
  # set subject specific files
  subject <- subs[sub_iter]
  sub_prefix<-paste("PARC_sub_",subs[sub_iter],sep="")
  subfolder <- paste(overfolder,"PARC_sub_",subject,"/afni_files",sep="")
#   subfolder <- paste(overfolder,"PARC_sub_",subject,".results.test/stimuli/",sep="")
  setwd(subfolder)
  
  trialtype <- "test"
  sub_data <- bothtest[bothtest$Subject==subject,]
  sub_data <- sub_data[sort(sub_data$index),]
  
  ##### use scanner start time to calculate onsets/offsets!
  sub_data$onset_fromscannerstart <- sub_data$onsetRaw-sub_data$blockstart+6 #plus 6 sec for study, b/c data logging
  sub_data$offset_fromscannerstart <- sub_data$offsetRaw-sub_data$blockstart+6 #plus 6 sec for study, b/c data logging
  
  # drop how ever many seconds worth of TRs we're dropping
  sub_data$trial_onset_trim <-sub_data$onset_fromscannerstart-(TRstodrop*TRlength)
  sub_data$trial_offset_trim <- sub_data$offset_fromscannerstart-(TRstodrop*TRlength) 
  
  sub_data$recall_onset_trim <- sub_data$trial_onset_trim 
  sub_data$response_onset <- sub_data$trial_onset_trim + stim_time
  sub_data$recall_onset_trim <- round(sub_data$recall_onset_trim,1)
  sub_data$mem_judge_onset <- sub_data$recall_onset_trim+stim_time
  sub_data$trial_duration <-stim_time + response_time + sub_data$postISI
  
  
  # local onset 
  sub_data$local_onset <- round(sub_data$recall_onset_trim,1) #just to initialize
  
  
  n_blocks <- length(unique(sub_data$block))
  for (iter_block in 1: n_blocks){
#     filename_all<- paste(sub_prefix,"_run_",zeropad(iter_block),"_",trialtype,"_trialonsets.txt",sep="")
    filename_all<- paste(sub_prefix,"_run_",zeropad(iter_block),"_",trialtype,"_trialonsets.1D",sep="")
    onsets <- sub_data[sub_data$block==iter_block,'local_onset']
    sink(file=filename_all)
    cat(onsets,sep=" ")
    sink(file=NULL)
  }
  
  dataframename <- paste(sub_prefix,"_",trialtype,"_timingdata.csv",sep="")
  write.csv(sub_data,dataframename,row.names=FALSE)
  
}
