#!/bin/bin          

## make mask for certain set of FS labels for a given subject.

# the user may specify a single subject to run with
if ( $#argv > 0 ) then
    set subj = $argv[1]
else
    set subj = PARC_sub_3010
endif


if ( $#argv > 2 ) then
    set maskSuffix = $argv[2]
else
    set maskSuffix = parafusi
endif

set labelSuffix = labelVolume
3dcalc -a ${subj}.${labelSuffix}.nii.gz -expr 'amongst(a,\
1007,\
2007,\
1016,\
2016\
)'  -prefix temp.unsampled.${subj}.$maskSuffix


3dresample -master pb02.$subj.r02.volreg+orig -rmode NN -input temp.unsampled.${subj}.$maskSuffix+orig -prefix temp.resampled.$subj.$maskSuffix


# convert to binary anat mask; fill gaps and holes
3dmask_tool -dilate_input 5 -5 -fill_holes -input temp.resampled.$subj.$maskSuffix+orig         \
            -prefix $subj.$maskSuffix.nii

rm temp.*            
