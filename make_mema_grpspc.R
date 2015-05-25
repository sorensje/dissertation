library('reshape2')

#### SET UP ####

## def printing function
afni_printMemaSet_preSuf <- function(subs,rbuckPrefix, rbuckSuffix,coefIndex, tStatIndex){
  # function to print sets for MEMA. Sould pass it a subsetted dataframe (and do twice) for Groups
  for(sub in subs){
    coef <- paste0(rbuckPrefix,sub,rbuckSuffix, "'[",coefIndex,"]'")
    stat <- paste0(rbuckPrefix,sub,rbuckSuffix, "'[",tStatIndex,"]'")
    cat(paste('\t\t',sub,coef, stat,"\\",sep="\t"), sep='\n')
  }  
}

# get data
bothTest <- readRDS("/Users/Jim/Dropbox/Dissertation/data_files/bothTest_toMakeRegressors.rds")
subDat <- read.csv("/Users/Jim/Dropbox/Dissertation/analysis tracking/subInfo.csv")
bothTest <- merge(bothTest, subDat, by.x = 'Subject', by.y = 'Subject')

bothTestLonger <- readRDS("/Users/Jim/Dropbox/Dissertation/data_files/bothTest_beavioralDataRMD.rds") #need to get subs that show rwd effect


excludeSubs <- c('2908','2967', '2844', '2834', '2872') # these subjects will not be included in any analyses.
noParaMetric <- c(2955, 2829,2784) # no responses, can't be in parametric (well, 2784 had 95/1)

forMema <- unique(bothTest[!bothTest$Subject %in% excludeSubs, c('Subject','Group')])
xtabs(~Group, forMema)

# make subject lists
subs <- as.character(unique(forMema$Subject))
MDDs <- as.character(unique(forMema[forMema$Group == 'MDD', 'Subject']))
CTLs <- as.character(unique(forMema[forMema$Group == 'CTL', 'Subject']))

# make subject lists, parametric
forPara <- unique(forMema[!forMema$Subject %in% noParaMetric,c('Subject','Group') ])
subs_para <- forPara$Subject
MDDs_para <- as.character(forPara[forPara$Group == 'MDD', 'Subject'])
CTLs_para <- as.character(forPara[forPara$Group == 'CTL', 'Subject'])
xtabs(~Group, forPara)


noPara_rwdstim <- c(2829, 2784, 2792, 2787, 2955)
forPara_stimRwd <- unique(forMema[!forMema$Subject %in% noPara_rwdstim,c('Subject','Group') ])
xtabs(~Group, forPara_stimRwd)
subs_para_stimRwd <- forPara_stimRwd$Subject
MDDs_para_stimRwd <- forPara_stimRwd[forPara_stimRwd$Group == 'MDD', 'Subject']
CTLs_para_stimRwd <- forPara_stimRwd[forPara_stimRwd$Group == 'CTL', 'Subject']


##############################
### parametric group space ####
#test parametric all stim together. 
afni_printMemaSet_preSuf(paste0("PARC_sub_",subs_para),'stats.paraTestgrp.','_REML+tlrc',3,4)

# group
afni_printMemaSet_preSuf(paste0("PARC_sub_",CTLs_para),'stats.paraTestgrp.','_REML+tlrc',3,4)
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs_para),'stats.paraTestgrp.','_REML+tlrc',3,4)


#### group space study ####

# stim hit - miss #3dmem_study_hit-miss_paraStimB6grpspcsh
afni_printMemaSet_preSuf(paste0("PARC_sub_",subs),'stats.paraStimB6grpspc.','_REML+tlrc',55,56)

# stim hit - miss #3dmem_study_hit-miss_paraStimB6grpspcsh
afni_printMemaSet_preSuf(paste0("PARC_sub_",CTLs),'stats.paraStimB6grpspc.','_REML+tlrc',55,56)
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs),'stats.paraStimB6grpspc.','_REML+tlrc',55,56)

## high - low rwd (hits)
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs),'stats.paraStimB6grpspc.','_REML+tlrc',28,29)


afni_printMemaSet_preSuf(paste0("PARC_sub_",CTLs),'stats.paraStimB6grpspc.','_REML+tlrc',28,29)
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs),'stats.paraStimB6grpspc.','_REML+tlrc',28,29)

## high - low rwd 
afni_printMemaSet_preSuf(paste0("PARC_sub_",subs),'stats.paraStimB6grpspc.','_REML+tlrc',25,26)

### reward: just the ones who show potentiation
rewardWide <- dcast(bothTestLonger[bothTestLonger$finalTest_ScoredwithNextTrials == 1, ], 
      Subject + Group  ~ reward, length)
rewardWide$rwdDiff <- rewardWide$R - rewardWide$N
fivenum(rewardWide$rwdDiff)
highRwdSubs <- rewardWide[rewardWide$rwdDiff >= 4, 'Subject']

afni_printMemaSet_preSuf(paste0("PARC_sub_",highRwdSubs),'stats.paraStimB6grpspc.','_REML+tlrc',25,26)


#### group space reward ####
## para reward... reward X modulated by memory?
afni_printMemaSet_preSuf(paste0("PARC_sub_",subs_para),'stats.studyParaRWD_grpspc_stimFP.','_REML+tlrc',26,27) #lo - hi

#para reward... reward X modulated by memory? hi-lo
afni_printMemaSet_preSuf(paste0("PARC_sub_",subs_para),'stats.studyParaRWD_grpspc_stimFP.','_REML+tlrc',23,24)

#para reward... reward X modulated by memory? hi-lo just hi rwd subs
afni_printMemaSet_preSuf(paste0("PARC_sub_",highRwdSubs),'stats.studyParaRWD_grpspc_stimFP.','_REML+tlrc',23,24)

## shit... group comparison?
afni_printMemaSet_preSuf(paste0("PARC_sub_",CTLs_para),'stats.studyParaRWD_grpspc_stimFP.','_REML+tlrc',23,24)
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs_para),'stats.studyParaRWD_grpspc_stimFP.','_REML+tlrc',23,24)

### reward w/ stim para
afni_printMemaSet_preSuf(paste0("PARC_sub_",subs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',20,21) # this is actually just hi + lo reward. so... task positive.

afni_printMemaSet_preSuf(paste0("PARC_sub_",subs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',17,18) # this is actually just hi + lo reward. so... task positive.
afni_printMemaSet_preSuf(paste0("PARC_sub_",CTLs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',17,18) # reward actual.
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',17,18) # reward actual.

## reward subs only
afni_printMemaSet_preSuf(paste0("PARC_sub_",highRwdSubs),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',17,18) # this is actually just hi + lo reward. so... task positive.

# memory all
afni_printMemaSet_preSuf(paste0("PARC_sub_",subs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',35,36)

afni_printMemaSet_preSuf(paste0("PARC_sub_",CTLs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',35,36)
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',35,36)

# memory all no stim split 
stats.studParaAllgrpspc
afni_printMemaSet_preSuf(paste0("PARC_sub_",subs_para),'stats.studParaAllgrpspc.','_REML+tlrc',15,16)


## face vs place memory interaction (plc slope) - (fc slope)
# this one is fucked up!
afni_printMemaSet_preSuf(paste0("PARC_sub_",subs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',26,27)

afni_printMemaSet_preSuf(paste0("PARC_sub_",CTLs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',26,27)
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',26,27)

## can really only use face - place!
afni_printMemaSet_preSuf(paste0("PARC_sub_",subs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',29,30)

afni_printMemaSet_preSuf(paste0("PARC_sub_",CTLs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',29,30)
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',29,30)



### TEST #####
#### para test group space #### 
afni_printMemaSet_preSuf(paste0("PARC_sub_",CTLs_para),'stats.paraTestgrp.','_REML+tlrc',3,4)
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs_para),'stats.paraTestgrp.','_REML+tlrc',3,4)

#### memory slope, para stim, para rwd
afni_printMemaSet_preSuf(paste0("PARC_sub_",subs_para_stimRwd),'stats.test_paraRW_paraFP_grpspc.','_REML+tlrc',27,28)

afni_printMemaSet_preSuf(paste0("PARC_sub_",CTLs_para_stimRwd),'stats.test_paraRW_paraFP_grpspc.','_REML+tlrc',27,28)
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs_para_stimRwd),'stats.test_paraRW_paraFP_grpspc.','_REML+tlrc',27,28)


#### faceslope-placeSlope, para stim, para rwd
afni_printMemaSet_preSuf(paste0("PARC_sub_",subs_para_stimRwd),'stats.test_paraRW_paraFP_grpspc.','_REML+tlrc',33,34)

afni_printMemaSet_preSuf(paste0("PARC_sub_",CTLs_para_stimRwd),'stats.test_paraRW_paraFP_grpspc.','_REML+tlrc',33,34)
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs_para_stimRwd),'stats.test_paraRW_paraFP_grpspc.','_REML+tlrc',33,34)
