#!/bin/tcsh -xef


# the user may specify a single subject to run with
if ( $#argv > 0 ) then
    set subj = $argv[1]
endif

# create an all_runs dataset to match the fitts, errts, etc.
3dTcat -prefix all_runs.$subj pb04.$subj.r*.scale+orig.HEAD

# create a temporal signal to noise ratio dataset 
#    signal: if 'scale' block, mean should be 100
#    noise : compute standard deviation of errts
3dTstat -mean -prefix rm.signal.all all_runs.$subj+orig
3dTstat -stdev -prefix rm.noise.all errts.${subj}+orig
3dcalc -a rm.signal.all+tlrc                                                  \
       -b rm.noise.all+tlrc                                                   \
       -c full_mask.$subj+tlrc                                                \
       -expr 'c*a/b' -prefix TSNR.$subj
