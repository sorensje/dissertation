

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
bothTest <- merge(bothTest, subDat, by.x = 'Subject', by.y = 'ID')


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


forPara_fcplc <- unique(bothTest[!bothTest$Subject %in% noParaMetric_fcplc,c('Subject','Group') ])
xtabs(~Group, forPara_fcplc)
subs_para_fcplc <- forPara_fcplc$Subject
MDDs_para_fcplc <- forPara_fcplc[forPara_fcplc$Group == 'MDD', 'Subject']
CTLs_para_fcplc <- forPara_fcplc[forPara_fcplc$Group == 'CTL', 'Subject']


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

## high - low rwd
afni_printMemaSet_preSuf(paste0("PARC_sub_",CTLs),'stats.paraStimB6grpspc.','_REML+tlrc',28,29)
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs),'stats.paraStimB6grpspc.','_REML+tlrc',28,29)

#### group space parametric ####
## para reward... reward X modulated by memory?
afni_printMemaSet_preSuf(paste0("PARC_sub_",subs_para),'stats.studyParaRWD_grpspc_stimFP.','_REML+tlrc',26,27)

# memory all
afni_printMemaSet_preSuf(paste0("PARC_sub_",subs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',35,36)

afni_printMemaSet_preSuf(paste0("PARC_sub_",CTLs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',35,36)
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',35,36)

## face vs place memory interaction (plc slope) - (fc slope)
afni_printMemaSet_preSuf(paste0("PARC_sub_",subs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',26,27)

afni_printMemaSet_preSuf(paste0("PARC_sub_",CTLs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',26,27)
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs_para),'stats.studyParaStim_grpspc_FP.','_REML+tlrc',26,27)


### TEST #####


#### para test group space #### 
afni_printMemaSet_preSuf(paste0("PARC_sub_",CTLs_para),'stats.paraTestgrp.','_REML+tlrc',3,4)
afni_printMemaSet_preSuf(paste0("PARC_sub_",MDDs_para),'stats.paraTestgrp.','_REML+tlrc',3,4)