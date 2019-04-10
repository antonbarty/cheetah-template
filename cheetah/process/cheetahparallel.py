#!/usr/bin/env python3

import argparse
import os
import fnmatch
import subprocess
import re
import time
import h5py
import numpy as np
import tempfile

parser=argparse.ArgumentParser(description="Launch cheetah jobs for each AGIPD01-S?????? file. Merge output. Exits when all launched jobs have status.txt == Finished.")
parser.add_argument("-r",help="Run, rXXXX format.")
parser.add_argument("--ini","-i",help="inifile")
parser.add_argument("--calib","-c",help="calibfile")
parser.add_argument("-j",help="number of threads")
args=parser.parse_args()

start=time.time()

launchedxtcs={}
cximap={}
cxisub=0
finished=False

filesnochange=[]
fileschange=[]

# init frames.txt
frames=open("frames.txt","w")
frames.write("# eventData->eventName, eventData->filename, eventData->stackSlice, eventData->xtcFrameNumber, eventData->hit, eventData->powderClass, eventData->hitScore, eventData->photonEnergyeV, eventData->wavelengthA, eventData->gmd1, eventData->gmd2, eventData->detector[0].detectorZ, eventData->energySpectrumExist,  eventData->nPeaks, eventData->peakNpix, eventData->peakTotal, eventData->peakResolution, eventData->peakDensity, eventData->pumpLaserCode, eventData->pumpLaserDelay, eventData->pumpLaserOn\n")

fileschange.append(('frames.txt',frames,{},'#'))

# init peaks.txt
peaks=open("peaks.txt","w")
peaks.write("# frameNumber, eventName, photonEnergyEv, wavelengthA, GMD, peak_index, peak_x_raw, peak_y_raw, peak_r_assembled, peak_q, peak_resA, nPixels, totalIntensity, maxIntensity, sigmaBG, SNR\n")

filesnochange.append(('peaks.txt',peaks,{},'#'))

# Init cleaned.txt
cleaned=open("cleaned.txt",'w')
cleaned.write("# Filename, frameNumber, nPeaks, nPixels, totalIntensity, peakResolution, peakResolutionA, peakDensity\n")

filesnochange.append(('cleaned.txt',cleaned,{},'#'))


streamre=re.compile('(S\d+)')
filenamere=re.compile('(.*)-%s-c(\d\d).cxi'%(args.r,))
# Fix relative file paths in ini file
subprocess.call("sed -e 's|=../|=../../|g' %s > %s2" %(args.ini,args.ini),shell=True)
subprocess.call("sed -e 's|=../|=../../|g' %s > %s2" %(args.calib,args.calib),shell=True)
#
# First, launch on job per stream. Launching one per xtc file doesn't work for
# chunks other than c00, so run should be finished.
#
print (args.r,"Launching one per stream")
for root,dirnames,filenames in os.walk(os.environ["XTCDIR"]+"/"+args.r):
    for filename in fnmatch.filter(sorted(filenames),"*AGIPD01*.h5"):
        dirname=streamre.search(filename).group(0)
        if dirname not in launchedxtcs:
            launchedxtcs[dirname]=dirname
            if not os.path.exists(dirname):
                os.mkdir(dirname)
            os.chdir(dirname)
            stat=open("status.txt",'w')
            stat.write('# Cheetah status\nStatus: Submitted')
            stat.close()
            subprocess.call('ln -s ../%s .' %(args.ini+"2",),shell=True)
            if args.calib != "None":
                subprocess.call('ln -s ../%s2 .' %(args.calib,),shell=True)
            cmd="%s -i %s -c %s %s %s" %(os.environ["CHEETAH"],args.ini+"2",args.calib+"2",os.environ["CHEETAH_OPTS"],os.path.join(root,filename))
            sbatchcmd="sbatch <<EOF\n#!/bin/bash\n\n#SBATCH -p upex\n#SBATCH -t 10:00:00\n#SBATCH -n %s\n#SBATCH -N 1\n#SBATCH --job-name %s\n\n%s\nEOF" %(args.j,args.r+"-"+dirname,cmd)
            subprocess.call(sbatchcmd,shell=True)
            
            for f in fileschange:
                f[2][dirname]=0
            for f in filesnochange:
                f[2][dirname]=0
            cximap[dirname]={}
            os.chdir('..')
            print (args.r,"Launching ", dirname)

while not finished:
    # Status.txt vars
    running=False
    finished=len(launchedxtcs) > 0 # Don't finish if all xtcs were still in progress
    terminated=False
    hits=0
    processed=0

    # For each directory
    for d in launchedxtcs.values():
        # Stat file
        stat=open(d+"/status.txt",'r')
        for l in stat.readlines():
            parts=l.split()
            if parts[0] == "Status:":
                running |= (parts[1]=="Not" and parts[2] == "finished") or (parts[1] == "Finished")
                finished &= (parts[1]=="Finished" or parts[1] =="Terminated")
                terminated |= parts[1]=="Terminated"
            elif parts[0] == "Frames":
                processed += int(parts[2])
            elif parts[0] == "Number":
                hits += int(parts[3])
        stat.close()

        # Link cxi files
        for root,dirnames,filenames in os.walk(d):
            for filename in fnmatch.filter(sorted(filenames),"*.cxi"):
                filenameh5=filename[:-3]+"h5"
                if filenameh5 not in cximap[d]:
                    mtch=filenamere.search(filename)
                    nm="%s-%s-%s-c%s.h5"%(mtch.group(1),d,args.r,mtch.group(2))
                    cximap[d][filenameh5]=nm
                    subprocess.call("ln -s %s/%s %s"%(d,filename,nm[:-2]+"cxi"),shell=True)
                    subprocess.call("ln -s %s/%s %s"%(d,filenameh5,nm),shell=True)
            break

        # Update files needing substitution
        for f in fileschange:
            fpath=d+"/"+f[0]
            if os.path.exists(fpath):
                frmfile=open(fpath,'r')
                frmfile.seek(f[2][d])
                for line in frmfile:
                    if line.startswith(f[3]):
                        continue
                    for old,new in cximap[d].items():
                        line=line.replace(old,new)
                    f[1].write(line)
                f[2][d]=frmfile.tell()
                frmfile.close()
                f[1].flush()

        # Update files not needing substitution
        for f in filesnochange:
            fpath=d+"/"+f[0]
            if os.path.exists(fpath):
                frmfile=open(fpath,'r')
                frmfile.seek(f[2][d])
                for line in frmfile:
                    if line.startswith(f[3]):
                        continue
                    f[1].write(line)
                f[2][d]=frmfile.tell()
                frmfile.close()
                f[1].flush()


    stat=open("status.txt","w")
    statstr="Submitted"
    if running:
        statstr="Not finished"
    if finished:
        if terminated:
            statstr="Terminated"
        else:
            statstr="Finished"
    hours, rem = divmod(time.time()-start, 3600)
    minutes, seconds = divmod(rem, 60)
    stat.write("# Cheetah status\nUpdate Time: %s\nElapsed Time: %ihr %imin %isec\nStatus: %s\nFrames processed: %i\nNumber of hits: %i\n"%(time.strftime('%a %b %d %H:%M:%S %Y',time.gmtime()),hours,minutes,seconds,statstr,processed,hits))
    stat.close()
    print (args.r,"Status.txt updated")

    time.sleep(60)

for f in fileschange:
    f[1].close()
for f in filesnochange:
    f[1].close()

# Now that run is complete, worry about simulating powders.
# Assume that all powders output have the same set of fields
avglst= [ '/data/non_assembled_detector_and_photon_corrected' , '/data/non_assembled_detector_corrected' , '/data/radial_average_detector_and_photon_corrected' , '/data/radial_average_detector_corrected' ]
siglst= [ '/data/non_assembled_detector_and_photon_corrected_sigma' , '/data/non_assembled_detector_corrected_sigma' , '/data/radial_average_detector_and_photon_corrected_sigma' , '/data/radial_average_detector_corrected_sigma' ]
npath='/data/nframes'
sums=[npath,'/data/peakpowder']
tocalc=[(args.r+"-detector0-class0-sum.h5",{}),(args.r+"-detector0-class1-sum.h5",{})]

for d in launchedxtcs.values():
    for c in tocalc:
        if os.path.exists(d+"/"+c[0]):
            f=h5py.File(d+"/"+c[0])
            n=f[npath][0]
            for i in range(len(avglst)):
                avg=np.array(f[avglst[i]])
                s=avg*n # Get back to summation from average by multipyling by n
                sig=np.array(f[siglst[i]])
                sqrsum=n*sig*sig+avg*s # Get back to squared sum by reverse of sqrt(sum(squares)/n-avg^2)
                if avglst[i] in c[1]:
                    c[1][avglst[i]]+=s
                else:
                    c[1][avglst[i]]=s
                if siglst[i] in c[1]:
                    c[1][siglst[i]]+=sqrsum
                else:
                    c[1][siglst[i]]=sqrsum
            for s in sums:
                if s in c[1]:
                    c[1][s]+=np.array(f[s])
                else:
                    c[1][s]=np.array(f[s])
            f.close()

for c in tocalc:
    fout=h5py.File(c[0],'w')
    n=c[1][npath][0]
    if n > 0:
        for i in range(len(avglst)):
            c[1][avglst[i]]/=n # Redo average with new n
            tmp=np.sqrt(c[1][siglst[i]]/n-(c[1][avglst[i]]*c[1][avglst[i]])) # redo sigma without overwriting it
            c[1][siglst[i]]=tmp # now set it
    for key,val in c[1].items():
        fout[key]=val
    fout['/data/data']=h5py.SoftLink("/data/non_assembled_detector_corrected")
    fout['/data/correcteddata']=h5py.SoftLink("/data/non_assembled_detector_corrected")
    fout.close()

print (args.r,"Clean finish")
    


    




