#!/bin/bash
#
# Parameters:
# 	$1 = Job tag
# 	$2 = Working directory for execution
# 	rest = command to execute

#
# Submit job to SLAC batch queue (psanaq, etc)
#

# Static parameters (change as needed)
QUEUE='psanaq'


# Parameters passed from Cheetah GUI (use shift to extract final command) 
LABEL=$1
WORKINGDIR=$2
shift
shift
COMMAND=$@


# For debugging
#echo "Queue: " $QUEUE
#echo "Workingdir: " $WORKINGDIR
#echo "Label: " $LABEL
#echo "Command: " $COMMAND


# Dependencies that may not be imported by default
source /reg/g/cfel/crystfel/crystfel-dev/setup-sh


# Batch queue commands
FULLCOMMAND="bsub -q $QUEUE -o bsub.log -x -J $LABEL -cwd $WORKINGDIR $COMMAND"
echo $FULLCOMMAND
$FULLCOMMAND


