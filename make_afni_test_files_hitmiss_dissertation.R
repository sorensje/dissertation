#### make timing vectors for analysis
# important shit happens at line 90
# timing vectors are written out as local times (so each number is n seconds from start of run, 1 run per line of txt file)


#get necessary files
source("/Users/Jim/PARC_study/Jim_scripts/binarytimingvector.R")
source("/Users/Jim/PARC_study/Jim_scripts/nearestTR.R")
source("/Users/Jim/PARC_study/Jim_scripts/dissertation/write_Afni_Parametric_Files.R")
source("/Users/Jim/PARC_study/Jim_scripts/dissertation/write_Afni_Files.R")

### read in data files
bothtest <- readRDS("~/Dropbox/Dissertation/data_files/bothTest_toMakeRegressors.rds")
study_finalcorrect <- readRDS("~/Dropbox/Dissertation/data_files/study_finalcorrect_toMakeRegressors.rds")

setwd("~/PARC_study/scandata_for_analysis/")


# variables specific to 
# sub <- 
TRstodrop<-3
TRlength<-2
rewardtime <- 1.6 #seconds
stim_time <- 6 # seconds
condition <- "finaltest_correct"
# overfolder <-'/Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_test/'
overfolder <-'/Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_test/'
response_time <- 4

### change later

subs <- unique(study_finalcorrect$Subject)
sub_prefixes <- paste("PARC_sub_",subs,sep="")

# for(sub_iter in 1:length(subs)){
#   subfolder <- paste(overfolder,"PARC_sub_",subs[sub_iter],sep="")
#   setwd(subfolder)
#   dir.create("afni_files")
# }
# subs<-2699
# sub_iter = 1

for(sub_iter in 1:length(subs)){  
  # set subject specific files
  subject <- subs[sub_iter]
  sub_prefix<-paste("PARC_sub_",subject,sep="")
  subfolder <- paste(overfolder,sub_prefix,".results/stimuli/",sep="")
  setwd(subfolder)
  
  
  sub_data <- bothtest[bothtest$Subject==subject,]
  sub_data <- sub_data[sort(sub_data$index),]
  
  # correct resonses 5/6 issue
  sub_data$corrected_resp[sub_data$corrected_resp == 6] <- 5
  
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
  
  
  
  ## global onsets 
  sub_data$global_onset <- sub_data$trial_onset_trim #just to initialize
  n_trials <- max(sub_data$test_trial)
  for( trial_iter in 2:n_trials){
    sub_data$global_onset[trial_iter] <- sub_data$global_onset[trial_iter-1]+ sub_data$trial_duration[trial_iter-1]
  }
  
  ## get duration of blocks (not necessary anymore?)
  n_blocks <- length(unique(sub_data$block))
  max_time_run <- rep(0,n_blocks)
  block_onset_global <- rep(0,n_blocks)
  for (iter_block in 1: n_blocks){
    runtrials <- sub_data[sub_data$block==iter_block,'test_trial']
    last_trial <- max(runtrials)
    first_trial<- min(runtrials)
    max_time_run[iter_block] <- sub_data[sub_data$test_trial==last_trial,'trial_onset_trim']+ sub_data[sub_data$test_trial==last_trial,'trial_duration']
    block_onset_global[iter_block] <- sub_data[sub_data$test_trial==first_trial,'global_onset']
  }
  
  # create vectors for later getting total time/TR info
  max_time_run_TR <- nearestTR(max_time_run,TRlength) #round to 2 sec
  total_time <- sum(max_time_run)
  total_time_TR <- nearestTR(total_time,TRlength)
  
  # block_onset_global <- round(block_onset_global/1000,0)
  block_onset_global_TR <- nearestTR(block_onset_global,TRlength)
  
  ####
  # STIM ONSETS ####
  ####
  n_blocks <- 6
  
  fileName <- paste(sub_prefix,"_test_recStim_person_MISS_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='person' & sub_data$finaltest_correct=='0',], fileName, 'recall_onset_trim',n_blocks)
  # person hit
  fileName <- paste(sub_prefix,"_test_recStim_person_HIT_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='person' & sub_data$finaltest_correct=='1',], fileName, 'recall_onset_trim',n_blocks)
  # person miss
  fileName <- paste(sub_prefix,"_test_recStim_place_MISS_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='place' & sub_data$finaltest_correct=='0',], fileName, 'recall_onset_trim',n_blocks)
  # person miss
  fileName <- paste(sub_prefix,"_test_recStim_place_HIT_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='place' & sub_data$finaltest_correct=='1',], fileName, 'recall_onset_trim',n_blocks)
  
  
  
  ### all combined. 
  # person hit high
  fileName <- paste(sub_prefix,"_test_recStim_person_hiRwd_MISS_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='person' & sub_data$reward =='R' & sub_data$finaltest_correct=='0',], fileName, 'recall_onset_trim',n_blocks)
  fileName <- paste(sub_prefix,"_test_recStim_person_loRwd_MISS_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='person' & sub_data$reward =='N' & sub_data$finaltest_correct=='0',], fileName, 'recall_onset_trim',n_blocks)
  
  #person miss
  fileName <- paste(sub_prefix,"_test_recStim_person_hiRwd_HIT_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='person' & sub_data$reward =='R' & sub_data$finaltest_correct=='1',], fileName, 'recall_onset_trim',n_blocks)
  fileName <- paste(sub_prefix,"_test_recStim_person_loRwd_HIT_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='person' & sub_data$reward =='N' & sub_data$finaltest_correct=='1',], fileName, 'recall_onset_trim',n_blocks)
  
  # place hit high
  fileName <- paste(sub_prefix,"_test_recStim_place_hiRwd_MISS_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='place' & sub_data$reward =='R' & sub_data$finaltest_correct=='0',], fileName, 'recall_onset_trim',n_blocks)
  fileName <- paste(sub_prefix,"_test_recStim_place_loRwd_MISS_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='place' & sub_data$reward =='N' & sub_data$finaltest_correct=='0',], fileName, 'recall_onset_trim',n_blocks)
  
  #person miss
  fileName <- paste(sub_prefix,"_test_recStim_place_hiRwd_HIT_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='place' & sub_data$reward =='R' & sub_data$finaltest_correct=='1',], fileName, 'recall_onset_trim',n_blocks)
  fileName <- paste(sub_prefix,"_test_recStim_place_loRwd_HIT_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='place' & sub_data$reward =='N' & sub_data$finaltest_correct=='1',], fileName, 'recall_onset_trim',n_blocks)
  
  
  ####
  # RESPONSE ONSETS #### 
  ####
  # person miss
  fileName <- paste(sub_prefix,"_test_MemJudge_person_MISS_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='person' & sub_data$finaltest_correct=='0',], fileName, 'mem_judge_onset',n_blocks)
  # person hit
  fileName <- paste(sub_prefix,"_test_MemJudge_person_HIT_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='person' & sub_data$finaltest_correct=='1',], fileName, 'mem_judge_onset',n_blocks)
  # person miss
  fileName <- paste(sub_prefix,"_test_MemJudge_place_MISS_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='place' & sub_data$finaltest_correct=='0',], fileName, 'mem_judge_onset',n_blocks)
  # person miss
  fileName <- paste(sub_prefix,"_test_MemJudge_place_HIT_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='place' & sub_data$finaltest_correct=='1',], fileName, 'mem_judge_onset',n_blocks)
  # all
  fileName <- paste(sub_prefix,"_test_MemJudge_all_allblocks.txt",sep="")
  write_Afni_Files(sub_data[ , ], fileName, 'mem_judge_onset',n_blocks)
  
  
  #### PRAMETRIC STIM  ####
  paraVarName <- 'corrected_resp'
  onsetVarName <- 'recall_onset_trim'
  possibleParaValues <- 1:5
  n_blocks <- 6
  
  if( any(is.na(sub_data[ ,paraVarName]))){
    n_NAs <- sum(is.na(sub_data[ ,paraVarName]))
    cat("\n Warning! ",n_NAs," NAs detected for ", sub_prefix)
    if(n_NAs < 10){
      cat("\n\tresetting NAs to 3 for trials...")
      cat(as.character(sub_data[is.na(sub_data[ ,paraVarName]),'imgName']))
      sub_data[ ,paraVarName][is.na(sub_data[ ,paraVarName])] <- 3
    }else{
      cat("\n\ too many NAs to fill in for ", sub_prefix,"check files and/or remove from analysis")
    }
  }
  
  # ALL
  fileName <- paste(sub_prefix,"_recall_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data, fileName, onsetVarName, paraVarName, possibleParaValues,n_blocks)
  
  #### Faces 
    fileName <- paste(sub_prefix,"_recall_place_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$imgType=='place', ], fileName, onsetVarName, paraVarName, possibleParaValues,n_blocks)
  
  # Faces
  fileName <- paste(sub_prefix,"_recall_face_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$imgType=='person', ], fileName, onsetVarName, paraVarName, possibleParaValues,n_blocks)
  
  # Hi_Rwd
  fileName <- paste(sub_prefix,"_recall_hiRwd_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$reward =='R', ], fileName, onsetVarName, paraVarName, possibleParaValues,n_blocks)

  # Lo_Rwd
  fileName <- paste(sub_prefix,"_recall_loRwd_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$reward =='N', ], fileName, onsetVarName, paraVarName, possibleParaValues,n_blocks)
  
  
  #### crossing Reward and Stimulus Type.
  # participants 2829, 2784, 2792, 2787 won't work.
  # low face
  fileName <- paste(sub_prefix,"_recall_loRwd_person_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$reward =='N' & sub_data$imgType=='person', ], fileName, onsetVarName, paraVarName, possibleParaValues,n_blocks)
  # low place
  fileName <- paste(sub_prefix,"_recall_loRwd_place_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$reward =='N' & sub_data$imgType=='place', ], fileName, onsetVarName, paraVarName, possibleParaValues,n_blocks)
  #hi person
  fileName <- paste(sub_prefix,"_recall_hiRwd_person_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$reward =='R' & sub_data$imgType=='person', ], fileName, onsetVarName, paraVarName, possibleParaValues,n_blocks)
  
  fileName <- paste(sub_prefix,"_recall_hiRwd_place_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$reward =='R' & sub_data$imgType=='place', ], fileName, onsetVarName, paraVarName, possibleParaValues,n_blocks)
  
  
}