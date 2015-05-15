### means of group ests

# file created by calling tail -qn 1  */blur_est.para*.1D > blurEsts.paraTestgrp.txt
# from top level. 

setwd("/Volumes//group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_test/")

blurEsts.paraTestgrp <- read.table("/Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_test/blurEsts.paraTestgrp.txt", quote="\"")
names(blurEsts.paraTestgrp) <- c("x","y","z")

mean(blurEsts.paraTestgrp[ ,1])
mean(blurEsts.paraTestgrp[ ,2])
mean(blurEsts.paraTestgrp[ ,3])


blurEsts.study <- read.table("/Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/PARC_study/blurEsts.study_grp.txt", quote="\"")
names(blurEsts.study) <- c("x","y","z")

mean(blurEsts.study[ ,1])
mean(blurEsts.study[ ,2])
mean(blurEsts.study[ ,3])