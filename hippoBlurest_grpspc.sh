#!/bin/tcsh -xef

# script to run univariate parametric analysis of test data 

# the user may specify a single subject to run with
if ( $#argv > 0 ) then
    set subj = $argv[1]
endif



#### THINK ABOUT OUTPUT DIR
# assign output directory name
set output_dir = $subj.results
echo $output_dir
cd $output_dir

set runs = (`count -digits 2 1 6`)

cp /Volumes/group/iang/biac3/gotlib7/data/PARC/groupSpace/hippoROI_funcRes+tlrc* ./



# ============================ blur estimation =============================
# compute blur estimates
touch blur_est.hipp.$subj.1D   # start with empty file

# -- estimate blur for each run in epits --
touch blur.hipp.epits.1D

# restrict to uncensored TRs, per run
foreach run ( $runs )
    set trs = `1d_tool.py -infile X.xmat.1D -show_trs_uncensored encoded      \
                          -show_trs_run $run`
    if ( $trs == "" ) continue
    3dFWHMx -detrend -mask hippoROI_funcRes+tlrc                               \
        all_runs.$subj+tlrc"[$trs]" >> blur.hipp.epits.1D
end

# compute average blur and append
set blurs = ( `3dTstat -mean -prefix - blur.hipp.epits.1D\'` )
echo average epits blurs: $blurs
echo "$blurs   # epits blur estimates" >> blur_est.hipp.$subj.1D

