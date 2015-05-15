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
# overfolder <-"~/PARC_study/mvpa2/scaleup_study/"
# overfolder <- "/Volumes/group/iang/biac3/gotlib7/data/PARC/testingGround/PARC_study/"
overfolder <- "/Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_study/"
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
# subs <- 3010

for(sub_iter in 1:length(subs)){
  
  # set subject specific files
  subject <- subs[sub_iter]
  cat("\nmaking files for", as.character(subject))
  sub_prefix<-paste("PARC_sub_",subject,sep="")
  subfolder <- paste(overfolder,sub_prefix,".results/stimuli/",sep="")
  setwd(subfolder)
  
  # correct resonses 5/6 issue
  sub_data$corrected_resp[sub_data$corrected_resp == 6] <- 5
  
  
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
  
    
  
  ### make Rewarded stim file for MISSES ####
  filename_high_rwd <- paste(sub_prefix,"_view_high_rwd_study_MISS_allblocks.txt",sep="")
  high_reward_encode_onsets <- list()
  for (iter_block in 1: n_blocks){
    high_reward_onsets_iter <- sub_data[sub_data$block==iter_block & sub_data$reward=='R' & sub_data$finaltest_correct=='0','reward_onset']
    if(length(high_reward_onsets_iter) >0){
      high_reward_encode_onsets[[iter_block]] <- high_reward_onsets_iter
    }else (high_reward_encode_onsets[[iter_block]] <-"*") #necessary for empty blocks
  } 
  # write seperately
  sink(file=filename_high_rwd)
  for (iter_block in 1: n_blocks){
    cat(high_reward_encode_onsets[[iter_block]],"\n",sep=" ")
  }
  sink(file=NULL)
  
  ### make Rewarded stim file for HITS ####
  filename_high_rwd <- paste(sub_prefix,"_view_high_rwd_study_HIT_allblocks.txt",sep="")
  high_reward_encode_onsets <- list()
  for (iter_block in 1: n_blocks){
    high_reward_onsets_iter <- sub_data[sub_data$block==iter_block & sub_data$reward=='R' & sub_data$finaltest_correct=='1','reward_onset']
    if(length(high_reward_onsets_iter) >0){
      high_reward_encode_onsets[[iter_block]] <- high_reward_onsets_iter
    }else (high_reward_encode_onsets[[iter_block]] <-"*") #necessary for empty blocks
  }    
  # write seperately
  sink(file=filename_high_rwd)
  for (iter_block in 1: n_blocks){
    cat(high_reward_encode_onsets[[iter_block]],"\n",sep=" ")
  }
  sink(file=NULL)
  
  ### make low reward stim file MISS ####
  filename_low_rwd <- paste(sub_prefix,"_view_low_rwd_study_MISS_allblocks.txt",sep="")
  low_reward_encode_onsets <- list()
  for (iter_block in 1: n_blocks){
    low_reward_onsets_iter <- sub_data[sub_data$block==iter_block & sub_data$reward=='N' & sub_data$finaltest_correct=='0','reward_onset']
    if(length(low_reward_onsets_iter) >0){
      low_reward_encode_onsets[[iter_block]] <- low_reward_onsets_iter
    }else (low_reward_encode_onsets[[iter_block]] <-"*") #necessary for empty blocks
  }    
  # write seperately
  sink(file=filename_low_rwd)
  for (iter_block in 1: n_blocks){
    cat(low_reward_encode_onsets[[iter_block]],"\n",sep=" ")
  }
  sink(file=NULL)
  
  ### make low reward stim file HIT ####
  filename_low_rwd <- paste(sub_prefix,"_view_low_rwd_study_HIT_allblocks.txt",sep="")
  low_reward_encode_onsets <- list()
  for (iter_block in 1: n_blocks){
    low_reward_onsets_iter <- sub_data[sub_data$block==iter_block & sub_data$reward=='N' & sub_data$finaltest_correct=='1','reward_onset']
    if(length(low_reward_onsets_iter) >0){
      low_reward_encode_onsets[[iter_block]] <- low_reward_onsets_iter
    }else (low_reward_encode_onsets[[iter_block]] <-"*") #necessary for empty blocks
  }    
  # write seperately
  sink(file=filename_low_rwd)
  for (iter_block in 1: n_blocks){
    cat(low_reward_encode_onsets[[iter_block]],"\n",sep=" ")
  }
  sink(file=NULL)
  
  
  ### make FACE stim file MISS ####
  filename_person_encode <- paste(sub_prefix,"_person_encode_MISS_allblocks.txt",sep="")
  person_encode_onsets <- list()
  for (iter_block in 1: n_blocks){
    encode_onsets_iter <- sub_data[sub_data$block==iter_block & sub_data$imgType=='person' & sub_data$finaltest_correct=='0','encode_onset_trim']
    if(length(encode_onsets_iter) >0){
      person_encode_onsets[[iter_block]] <- encode_onsets_iter
    }else (person_encode_onsets[[iter_block]] <-"*") #necessary for empty blocks
  }    
  
  # write seperately
  sink(file=filename_person_encode)
  for (iter_block in 1: n_blocks){
    cat(person_encode_onsets[[iter_block]],"\n",sep=" ")
  }
  sink(file=NULL)
  
  ### make FACE stim file HIT ####
  filename_person_encode <- paste(sub_prefix,"_person_encode_HIT_allblocks.txt",sep="")
  person_encode_onsets <- list()
  for (iter_block in 1: n_blocks){
    encode_onsets_iter <- sub_data[sub_data$block==iter_block & sub_data$imgType=='person' & sub_data$finaltest_correct=='1','encode_onset_trim']
    if(length(encode_onsets_iter) >0){
      person_encode_onsets[[iter_block]] <- encode_onsets_iter
    }else (person_encode_onsets[[iter_block]] <-"*") #necessary for empty blocks
  }    
  
  # write seperately
  sink(file=filename_person_encode)
  for (iter_block in 1: n_blocks){
    cat(person_encode_onsets[[iter_block]],"\n",sep=" ")
  }
  sink(file=NULL)
  
  ### make place stim file MISS ####
  filename_place_encode <- paste(sub_prefix,"_place_encode_MISS_allblocks.txt",sep="")
  place_encode_onsets <- list()
  for (iter_block in 1: n_blocks){
    encode_onsets_iter <- sub_data[sub_data$block==iter_block & sub_data$imgType=='place' & sub_data$finaltest_correct=='0','encode_onset_trim']
    if(length(encode_onsets_iter) >0){
      place_encode_onsets[[iter_block]] <- encode_onsets_iter
    }else (place_encode_onsets[[iter_block]] <-"*") #necessary for empty blocks
  }    
  
  # write seperately
  sink(file=filename_place_encode)
  for (iter_block in 1: n_blocks){
    cat(place_encode_onsets[[iter_block]],"\n",sep=" ")
  }
  sink(file=NULL)
  
  ### make place stim file HIT ####
    filename_place_encode <- paste(sub_prefix,"_place_encode_HIT_allblocks.txt",sep="")
  place_encode_onsets <- list()
  for (iter_block in 1: n_blocks){
    encode_onsets_iter <- sub_data[sub_data$block==iter_block & sub_data$imgType=='place' & sub_data$finaltest_correct=='1','encode_onset_trim']
    if(length(encode_onsets_iter) >0){
      place_encode_onsets[[iter_block]] <- encode_onsets_iter
    }else (place_encode_onsets[[iter_block]] <-"*") #necessary for empty blocks
  }    
  
  # write seperately
  sink(file=filename_place_encode)
  for (iter_block in 1: n_blocks){
    cat(place_encode_onsets[[iter_block]],"\n",sep=" ")
  }
  sink(file=NULL)
  
  
  #### make hi vs low reward.
  # STIM ONSETS ####
  ####
  n_blocks <- 6
  
  # hi rwd
  fileName <- paste(sub_prefix,"_study_hiRwd_rwdOnset_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$reward=='R', ], fileName, 'reward_onset',n_blocks)

  # low rwd
  fileName <- paste(sub_prefix,"_study_lowRwd_rwdOnset_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$reward=='N', ], fileName, 'reward_onset',n_blocks)
  
  
  # facees
  fileName <- paste(sub_prefix,"_person_encode_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='person', ], fileName, 'encode_onset_trim',n_blocks)
  
  # places
  fileName <- paste(sub_prefix,"_place_encode_allblocks.txt",sep="")
  write_Afni_Files(sub_data[sub_data$imgType=='place', ], fileName, 'encode_onset_trim',n_blocks)
  
  
  #### make parametric #####
  
  #### PRAMETRIC STIM  ####
  paraVarName <- 'corrected_resp'
  encode_onsetVarName <- 'encode_onset_trim'
  rwd_onsetVarName <- 'reward_onset'
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
  fileName <- paste(sub_prefix,"_encode_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data, fileName, encode_onsetVarName, paraVarName, possibleParaValues,n_blocks)
  
  #### places 
  fileName <- paste(sub_prefix,"_encode_place_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$imgType=='place', ], fileName, encode_onsetVarName, paraVarName, possibleParaValues,n_blocks)
  
  # Faces
  fileName <- paste(sub_prefix,"_encode_face_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$imgType=='person', ], fileName, encode_onsetVarName, paraVarName, possibleParaValues,n_blocks)
  
  # Hi_Rwd
  fileName <- paste(sub_prefix,"_encode_hiRwd_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$reward =='R', ], fileName, rwd_onsetVarName, paraVarName, possibleParaValues,n_blocks)
  
  # Lo_Rwd
  fileName <- paste(sub_prefix,"_encode_loRwd_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$reward =='N', ], fileName, rwd_onsetVarName, paraVarName, possibleParaValues,n_blocks)
  
  #### crossing Reward and Stimulus Type.
  # this doesn't make sesne to do though. reward and stimulus will be highly colinear, so bad idea. (says anthony)
  # participants 2829, 2784, 2792, 2787 won't work.
  # low face
  fileName <- paste(sub_prefix,"_encode_loRwd_person_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$reward =='N' & sub_data$imgType=='person', ], fileName, encode_onsetVarName, paraVarName, possibleParaValues,n_blocks)
  # low place
  fileName <- paste(sub_prefix,"_encode_loRwd_place_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$reward =='N' & sub_data$imgType=='place', ], fileName, encode_onsetVarName, paraVarName, possibleParaValues,n_blocks)
  #hi person
  fileName <- paste(sub_prefix,"_encode_hiRwd_person_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$reward =='R' & sub_data$imgType=='person', ], fileName, encode_onsetVarName, paraVarName, possibleParaValues,n_blocks)
  
  fileName <- paste(sub_prefix,"_encode_hiRwd_place_stimOnset_parametric_allblocks.txt",sep="")
  write_Afni_Parametric_Files(sub_data[sub_data$reward =='R' & sub_data$imgType=='place', ], fileName, encode_onsetVarName, paraVarName, possibleParaValues,n_blocks)
  
  
  
}