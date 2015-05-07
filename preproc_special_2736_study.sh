#!/bin/tcsh -xef

#  ============
#	special pre-proc for 2736. they had crappy alignment.  the problem was that the 
#  t-shifted brain for run one was actually a little worse looking. so the solution will'
#  be to use a different volume as the base to register to.
# 
# 
# #  this Jim's pre-proc script for  It's a (heavily) edited version of the
# 	script automatically created by uber_subject_proc.py
# 
# 	
#
#  it assumes that when it is called, the tcsh shell is currently in the master working directory for the analysis (eg scaleup_study)
#	arg1 subj eg PARC_sub_2699 # subject to use
#	arg2 anat_suffix # suffix to use for anatomical 
#	arg3 func_type # type of functional to use (Study or Test) 
# 
# 
# 
# ============

# =========================== setup ============================

set subj  = PARC_sub_2736 
set func_type = Study
set anat_suffix = fs_brain



# assign output directory name
set output_dir = $subj.results

# set list of runs
set runs = (`count -digits 2 1 6`)



# ============================ fetch files ============================
# no need. 

# enter the results directory (can begin processing data)
cd $output_dir





# ================================= tshift =================================
# time shift data so all slice timing is the same 

# this was OK


# ================================= deoblique ========
# this was also ok

========================= count trs =================================
# touch tr_Counts.txt
# foreach run ( $runs )
#   3dinfo -nv pb01.$subj.r$run.tshift+orig >> tr_Counts.txt
# end

set tr_counts = `cat tr_Counts.txt`


# ======= Jim's alignment.  Uses skull stripped brain from freesurfer ==== # 
align_epi_anat.py -epi2anat -anat ${subj}_${anat_suffix}+orig \
	-anat_has_skull no						\
       -epi pb01.$subj.r04.tshift+orig -epi_base 5           \
       -epi_strip 3dAutomask                                 \
       -cost nmi					\
       -volreg off -tshift off

# create an all-1 dataset to mask the extents of the warp
3dcalc -a pb01.$subj.r01.tshift+orig -expr 1 -prefix rm.epi.all1


# ======= Jim's vol reg.  Uses skull stripped brain from freesurfer ==== # 

foreach run ( $runs )
  # register each volume to the base
	3dvolreg -verbose -zpad 1 -base pb01.$subj.r04.tshift+orig'[5]' \
			 -1Dfile dfile.r$run.1D -prefix rm.epi.volreg.r$run     \
			 -cubic                                                 \
			 -1Dmatrix_save mat.r$run.vr.aff12.1D                   \
			 pb01.$subj.r$run.tshift+orig

	# catenate volreg and epi2anat transformations
	cat_matvec -ONELINE                                             \
			   ${subj}_${anat_suffix}_al_mat.aff12.1D -I        \
			   mat.r$run.vr.aff12.1D > mat.r$run.warp.aff12.1D

	# apply catenated xform : volreg and epi2anat
	3dAllineate -base ${subj}_${anat_suffix}+orig                 \
				-input pb01.$subj.r$run.tshift+orig                 \
				-1Dmatrix_apply mat.r$run.warp.aff12.1D             \
				-mast_dxyz 3                                        \
				-prefix rm.epi.nomask.r$run 

	# warp the all-1 dataset for extents masking 
	3dAllineate -base ${subj}_${anat_suffix}+orig                 \
				-input rm.epi.all1+orig                             \
				-1Dmatrix_apply mat.r$run.warp.aff12.1D             \
				-mast_dxyz 3 -final NN -quiet                       \
				-prefix rm.epi.1.r$run 

	# make an extents intersection mask of this run
	3dTstat -min -prefix rm.epi.min.r$run rm.epi.1.r$run+orig
end


cat dfile.r*.1D > dfile_rall.1D

# ----------------------------------------
# create the extents mask: mask_epi_extents+orig
# (this is a mask of voxels that have valid data at every TR)
3dMean -datum short -prefix rm.epi.mean rm.epi.min.r*.HEAD 
3dcalc -a rm.epi.mean+orig -expr 'step(a-0.999)' -prefix mask_epi_extents

# and apply the extents mask to the EPI data 
# (delete any time series with missing data)
foreach run ( $runs )
    3dcalc -a rm.epi.nomask.r$run+orig -b mask_epi_extents+orig     \
           -expr 'a*b' -prefix pb02.$subj.r$run.volreg
end

# create an anat_final dataset, aligned with stats
3dcopy ${subj}_${anat_suffix}+orig anat_final.$subj


#### end Jim volreg edit #######  

# ================================== blur ==================================
# blur each volume of each run
foreach run ( $runs )
    3dmerge -1blur_fwhm 4.0 -doall -prefix pb03.$subj.r$run.blur \
            pb02.$subj.r$run.volreg+orig
end

# ================================== mask ==================================
# create 'full_mask' dataset (union mask)
foreach run ( $runs )
    3dAutomask -dilate 1 -prefix rm.mask_r$run pb03.$subj.r$run.blur+orig
end

# get mean and compare it to 0 for taking 'union'
3dMean -datum short -prefix rm.mean rm.mask*.HEAD
3dcalc -a rm.mean+orig -expr 'ispositive(a-0)' -prefix full_mask.$subj

# ---- create subject anatomy mask, mask_anat.$subj+orig ----
#      (resampled from aligned anat)
3dresample -master full_mask.$subj+orig -input ${subj}_${anat_suffix}+orig \
           -prefix rm.resam.anat

# convert to binary anat mask; fill gaps and holes
3dmask_tool -dilate_input 5 -5 -fill_holes -input rm.resam.anat+orig         \
            -prefix mask_anat.$subj

# compute overlaps between anat and EPI masks
3dABoverlap -no_automask full_mask.$subj+orig mask_anat.$subj+orig           \
            |& tee out.mask_overlap.txt


# ================================= scale ==================================
# scale each voxel time series to have a mean of 100
# (be sure no negatives creep in)
# (subject to a range of [0,200])
foreach run ( $runs )
    3dTstat -prefix rm.mean_r$run pb03.$subj.r$run.blur+orig
    3dcalc -a pb03.$subj.r$run.blur+orig -b rm.mean_r$run+orig \
           -expr 'min(200, a/b*100)*step(a)*step(b)'           \
           -prefix pb04.$subj.r$run.scale
end

# ================== write 1d files for censor

foreach run ( $runs )
  	echo $run
  	set trs_for_run = `3dinfo -nv pb01.$subj.r$run.tshift+orig`
  	echo $trs_for_run
  		1d_tool.py -infile dfile.r$run.1D  -set_run_lengths ${trs_for_run}  \
        -demean -write motion_demean.r$run.1D
	1d_tool.py -infile dfile.r$run.1D  -set_run_lengths ${trs_for_run}  \
    	-show_censor_count -censor_prev_TR  \
    	-censor_motion 0.3 motion_r${run}_${subj}
    	
end
  	


# ================== auto block: generate review scripts ===================

# generate a review script for the unprocessed EPI data
gen_epi_review.py -script @epi_review.$subj \
    -dsets pb00.$subj.r*.tcat+orig.HEAD

# generate scripts to review single subject results
# (try with defaults, but do not allow bad exit status)
gen_ss_review_scripts.py -mot_limit 0.3 -exit0

# ========================== auto block: finalize ==========================

# remove temporary files
\rm -f rm.*



# if the basic subject review script is here, run it
# (want this to be the last text output)
if ( -e @ss_review_basic ) ./@ss_review_basic |& tee out.ss_review.$subj.txt

# return to parent directory
cd ..

echo "execution finished: `date`"

