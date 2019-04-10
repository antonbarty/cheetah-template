#
# Run without subshell  
#

#!/bin/sh
#. /reg/g/cfel/crystfel/crystfel-dev/setup-sh


# 
# indexamajig normal 
#
TAG=$1
CELL=$2
GEOMFILE=$3

echo "Indexing with known unit cell"
echo "Using: " $CELL
echo "Using: " $GEOMFILE
echo ">------------------------------------<"

ln -fs ../streams/$TAG.stream ./$TAG.stream

indexamajig -i files.lst -g $GEOMFILE \
	-o ../streams/$TAG.stream \
	--indexing=mosflm,xds,dirax,asdf \
	-p $CELL \
	--int-radius=3,4,5 \
	--peaks=cxi  \
	-j 32 

