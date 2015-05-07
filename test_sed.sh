#!/bin/tcsh -xef




set sub = 'PARC_sub_2989'
set output = `echo $sub| sed 's/_sub_/_/g'`

echo $output
