### modify my study and final test files.
bothtest <- readRDS("~/Dropbox/Dissertation/data_files/bothTest_toMakeRegressors.rds")
study_finalcorrect <- readRDS("~/Dropbox/Dissertation/data_files/study_finalcorrect_toMakeRegressors.rds")

bothtest$corrected_resp[bothtest$corrected_resp == 6] <- 5


study_subIMG <- paste0(study_finalcorrect$Subject, study_finalcorrect$imgName)
test_subIMG <- paste0(bothtest$Subject, bothtest$imgName)


# no diffrences... so what the flying fuck?
setdiff(study_subIMG,test_subIMG)
setdiff(test_subIMG,study_subIMG)

study_subIMG[duplicated(study_subIMG)]
test_subIMG[duplicated(test_subIMG)]
# oh fucking weird.  well it's an exact duplicate so... screw it.

bothtest <- unique(bothtest)
study_finalcorrect <- unique(study_finalcorrect)

study_finalcorrect_withCor <- merge(study_finalcorrect, bothtest[ ,c('Subject','corrected_resp','imgName','test_trial')], sort = FALSE, all = FALSE)


saveRDS(bothtest,"~/Dropbox/Dissertation/data_files/bothTest_toMakeRegressors.rds")
saveRDS(study_finalcorrect_withCor,"~/Dropbox/Dissertation/data_files/study_finalcorrect_toMakeRegressors.rds")
