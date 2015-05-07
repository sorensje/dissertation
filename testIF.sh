#!/bin/tcsh -xef


## user may also specify the anat suffix to use (but don't)
if ( $#argv > 0 ) then
    set anat_suffix = $argv[1]
else
	set anat_suffix = 'none_specified'
endif

if( $anat_suffix == 'none_specified') then
	echo 'nothing!'
else
	echo $anat_suffix
endif
