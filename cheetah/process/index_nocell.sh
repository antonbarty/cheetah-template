#
# Run without subshell  
#

#!/bin/sh
#. /reg/g/cfel/crystfel/crystfel-dev/setup-sh


# 
# indexamajig no cell
#
TAG=$1
CELL=$2
GEOMFILE=$3

TAG="$TAG-nocell"

echo "No lattice indexing for unit cell determination"
echo "Using: " $GEOMFILE
echo ">------------------------------------<"

ln -fs ../streams/$TAG.stream ./$TAG.stream

indexamajig -i files.lst -g $GEOMFILE \
	-o ../streams/$TAG.stream \
	--indexing=mosflm-raw-nolatt-nocell \
	--peaks=cxi  \
	-j 32 

