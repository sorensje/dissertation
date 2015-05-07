#!/bin/tcsh -xef


# the user may specify a single subject to run with
if ( $#argv > 0 ) then
    set subj = $argv[1]
else
    set subj = PARC_sub_2699
endif

if ( $#argv > 1 ) then
    set anatRef = $argv[2]
endif

if ( $#argv > 2 ) then
    set newName = $argv[3]
endif


set runs = (`count -digits 2 1 6`)

# create 'full_mask' dataset (union mask)
foreach run ( $runs )
    3dAutomask -dilate 1 -prefix rm.mask_r$run pb03.$subj.r$run.blur+orig
end

# get mean and compare it to 0 for taking 'union'
3dMean -datum short -prefix rm.mean rm.mask*.HEAD
3dcalc -a rm.mean+orig -expr 'ispositive(a-0)' -prefix full_mask.$subj.$newName

# ---- create subject anatomy mask, mask_anat.$subj+orig ----
#      (resampled from aligned anat)
3dresample -master full_mask.$subj.$newName+orig -input ${subj}${anatRef} \
           -prefix rm.resam.anat

# convert to binary anat mask; fill gaps and holes
3dmask_tool -dilate_input 5 -5 -fill_holes -input rm.resam.anat+orig         \
            -prefix mask_anat.$subj.$newName

# compute overlaps between anat and EPI masks
3dABoverlap -no_automask full_mask.$subj+orig mask_anat.$subj+orig           \
            |& tee out.mask_overlap.txt

rm rm.*
