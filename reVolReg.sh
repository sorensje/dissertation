#!/bin/tcsh -xef
# making tihs script b/c the alignment just seems shittier after volreg.  I'm getting lots of signal outside the brain >O:

# the user may specify a single subject to run with
if ( $#argv > 0 ) then
    set subj = $argv[1]
endif



# ================================= align ==================================
# for e2a: compute anat alignment transformation to EPI registration base
# (new anat will be intermediate, stripped, ${subj}_FSPGR_1_ns+orig)
# align_epi_anat.py -epi2anat -anat ${subj}_FSPGR_1+orig \
#        -save_skullstrip -suffix _al_junk                     \
#        -epi pb01.$subj.r01.tshift+orig -epi_base 5           \
#        -epi_strip 3dAutomask                                 \
#        -volreg off -tshift off


set anat_suffix = 'brain'
set al_suffix = ''


# ======= Jim's alignment.  Uses skull stripped brain from freesurfer ==== # 
align_epi_anat.py -epi2anat -anat ${subj}_${anat_suffix}+orig \
	-anat_has_skull no						\
       -epi pb01.$subj.r01.tshift+orig -epi_base 5           \
       -epi_strip 3dAutomask                                 \
       -cost nmi					\
       -volreg off -tshift off

# create an all-1 dataset to mask the extents of the warp
3dcalc -a pb01.$subj.r01.tshift+orig -expr 1 -prefix rm.epi.all1


# ======= Jim's vol reg.  Uses skull stripped brain from freesurfer ==== # 

# foreach run ( $runs )
# register each volume to the base
3dvolreg -verbose -zpad 1 -base pb01.$subj.r01.tshift+orig'[2]' \
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
# end


cat dfile.r*.1D > dfile_rall.1D

# ----------------------------------------
# create the extents mask: mask_epi_extents+orig
# (this is a mask of voxels that have valid data at every TR)
3dMean -datum short -prefix rm.epi.mean rm.epi.min.r*.HEAD 
3dcalc -a rm.epi.mean+orig -expr 'step(a-0.999)' -prefix mask_epi_extents

# and apply the extents mask to the EPI data 
# (delete any time series with missing data)
# foreach run ( $runs )
3dcalc -a rm.epi.nomask.r$run+orig -b mask_epi_extents+orig     \
	   -expr 'a*b' -prefix pb02.redux.$subj.r$run.volreg
# end

# create an anat_final dataset, aligned with stats
# 3dcopy ${subj}_${anat_suffix}+orig anat_final.$subj
