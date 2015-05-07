#!/bin/tcsh -xef

#  ============
#	this Jim's pre-proc script for  It's a (heavily) edited version of the
# 	script automatically created by uber_subject_proc.py
# 
# 	it has been rebuilt to work for study or test.
#
#  it assumes that when it is called, the tcsh shell is currently in the master working directory for the analysis (eg scaleup_study)
#	arg1 subj eg PARC_sub_2699 # subject to use
#	arg2 anat_suffix # suffix to use for anatomical 
#	arg3 func_type # type of functional to use (Study or Test) 
# 
# 
#  This script is just for 2956, the one with the lack of Rx for runs 1-3
# in speial 2 I'm doing runs 4-6.  many steps have been done already so they are commented out. 
# ============

# =========================== setup ============================

# the user may specify a single subject to run with
# if ( $#argv > 0 ) then
#     set subj = $argv[1]
# endif
# 
# ## user may also specify the anat suffix to use (but don't)
# if ( $#argv > 1 ) then
#     set anat_suffix = $argv[2]
# else
# 	set anat_suffix = 'none_specified'
# endif
# 
# ## type of functional to use (Study or Test)
# if ( $#argv > 2 ) then
#     set func_type = $argv[3]
# endif


### setting Params
set subj = PARC_sub_2956
set func_type = Test
set anat_suffix = fs_brain
# set list of runs
set runs = (`count -digits 2 4 6`)


# assign output directory name
set output_dir = $subj.results

# verify that the results directory does not yet exist
# if ( -d $output_dir ) then
#     echo output dir "$subj.results" already exists
#     exit
# endif
# 
# 
# 
# create results and stimuli directories
# mkdir $output_dir
# mkdir $output_dir/stimuli
# 
# 

# ============================ fetch files ============================
# 
# # copy raw anatomy to results dir
# 3dcopy                                                                                          \
# 	/Users/Jim/PARC_study/scandata_for_analysis/${subj}/anat/${subj}_FSPGR_1.nii.gz \
# 	$output_dir/${subj}_FSPGR_1
# 
# # FS directory
# set fs_dir = '/Volumes/group/iang/biac3/gotlib7/data/PARC/finishedRecons_Marissa'
# 
# # freesurfer sub is slightly different of form PARC_1234
# set fs_sub = `echo $subj| sed 's/_sub_/_/g'`
# 
# # copy brain over
# cp -v ${fs_dir}/${fs_sub}/mri/brain.mgz $output_dir/fs_brain.mgz
# 
# #convert via freesurfer command
# mri_convert --out_orientation RAI $output_dir/fs_brain.mgz $output_dir/fs_brain.{subj}.nii.gz
# 
# #3d copy to get in afni format. 
# 3dcopy $output_dir/fs_brain.{subj}.nii.gz	$output_dir/${subj}_${anat_suffix}
# 




# ============================  block: tcat ============================
# apply 3dTcat to copy input dsets to results dir, while
# removing the first 3 TRs
# 3dTcat -prefix $output_dir/pb00.$subj.r01.tcat                              \
#     /Users/Jim/PARC_study/scandata_for_analysis/${subj}/func/${subj}_${func_type}_run_1.nii.gz'[3..$]'
# 3dTcat -prefix $output_dir/pb00.$subj.r02.tcat                              \
#     /Users/Jim/PARC_study/scandata_for_analysis/${subj}/func/${subj}_${func_type}_run_2.nii.gz'[3..$]'
# 3dTcat -prefix $output_dir/pb00.$subj.r03.tcat                              \
#     /Users/Jim/PARC_study/scandata_for_analysis/${subj}/func/${subj}_${func_type}_run_3.nii.gz'[3..$]'
# 3dTcat -prefix $output_dir/pb00.$subj.r04.tcat                              \
#     /Users/Jim/PARC_study/scandata_for_analysis/${subj}/func/${subj}_${func_type}_run_4.nii.gz'[3..$]'
# 3dTcat -prefix $output_dir/pb00.$subj.r05.tcat                              \
#     /Users/Jim/PARC_study/scandata_for_analysis/${subj}/func/${subj}_${func_type}_run_5.nii.gz'[3..$]'
# 3dTcat -prefix $output_dir/pb00.$subj.r06.tcat                              \
#     /Users/Jim/PARC_study/scandata_for_analysis/${subj}/func/${subj}_${func_type}_run_6.nii.gz'[3..$]'

# -------------------------------------------------------
# enter the results directory (can begin processing data)
cd $output_dir


# ========================== auto block: outcount ==========================
# data check: compute outlier fraction for each volume
touch out.pre_ss_warn.txt
foreach run ( $runs )
    3dToutcount -automask -fraction -polort 2 -legendre                     \
                pb00.$subj.r$run.tcat+orig > outcount.r$run.1D

    # outliers at TR 0 might suggest pre-steady state TRs
    if ( `1deval -a outcount.r$run.1D"{0}" -expr "step(a-0.4)"` ) then
        echo "** TR #0 outliers: possible pre-steady state TRs in run $run" \
            >> out.pre_ss_warn.txt
    endif
end

# catenate outlier counts into a single time series
cat outcount.r*.1D > outcount_rall.1D

# ================================= tshift =================================
# time shift data so all slice timing is the same 
foreach run ( $runs )
    3dTshift -tzero 0 -quintic -prefix pb01.$subj.r$run.oblique.tshift \
             pb00.$subj.r$run.tcat+orig
end


# ================================= deoblique ========
foreach run ( $runs )
	3dWarp -oblique2card -prefix pb01.$subj.r$run.tshift \
	pb01.$subj.r$run.oblique.tshift+orig
end
# at end of deobliquing, tshift is aligned. (well, starts off better)

========================= count trs =================================
touch tr_Counts.txt
foreach run ( $runs )
  3dinfo -nv pb01.$subj.r$run.tshift+orig >> tr_Counts.txt
end
set tr_counts = `cat tr_Counts.txt`


# ======= Jim's alignment.  Uses skull stripped brain from freesurfer ==== # 

###### 2956 change - changed base ###### 

align_epi_anat.py -epi2anat -anat ${subj}_${anat_suffix}+orig \
	-anat_has_skull no						\
       -epi pb01.$subj.r04.tshift+orig -epi_base 5           \
       -epi_strip 3dAutomask                                 \
       -cost nmi					\
       -volreg off -tshift off

# create an all-1 dataset to mask the extents of the warp
3dcalc -a pb01.$subj.r04.tshift+orig -expr 1 -prefix rm.epi.all1


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
3dcalc -a rm.epi.mean+orig -expr 'step(a-0.999)' -prefix mask_epi_extents.2

# and apply the extents mask to the EPI data 
# (delete any time series with missing data)
foreach run ( $runs )
    3dcalc -a rm.epi.nomask.r$run+orig -b mask_epi_extents+orig     \
           -expr 'a*b' -prefix pb02.$subj.r$run.volreg
end

# create an anat_final dataset, aligned with stats
3dcopy ${subj}_${anat_suffix}+orig anat_final2.$subj


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
3dcalc -a rm.mean+orig -expr 'ispositive(a-0)' -prefix full_mask2.$subj

# ---- create subject anatomy mask, mask_anat.$subj+orig ----
#      (resampled from aligned anat)
3dresample -master full_mask2.$subj+orig -input ${subj}_${anat_suffix}+orig \
           -prefix rm.resam.anat

# convert to binary anat mask; fill gaps and holes
3dmask_tool -dilate_input 5 -5 -fill_holes -input rm.resam.anat+orig         \
            -prefix mask_anat.$subj

# compute overlaps between anat and EPI masks
3dABoverlap -no_automask full_mask2.$subj+orig mask_anat2.$subj+orig           \
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
  	

# 
# # ================== auto block: generate review scripts ===================
# 
# # generate a review script for the unprocessed EPI data
# gen_epi_review.py -script @epi_review.$subj \
#     -dsets pb00.$subj.r*.tcat+orig.HEAD
# 
# # generate scripts to review single subject results
# # (try with defaults, but do not allow bad exit status)
# gen_ss_review_scripts.py -mot_limit 0.3 -exit0
# 
# # ========================== auto block: finalize ==========================

# remove temporary files
\rm -f rm.*
# \rm -f pb00*
# \rm -f pb02*


if the basic subject review script is here, run it
(want this to be the last text output)
if ( -e @ss_review_basic ) ./@ss_review_basic |& tee out.ss_review.$subj.txt

# return to parent directory
cd ..

echo "execution finished: `date`"

