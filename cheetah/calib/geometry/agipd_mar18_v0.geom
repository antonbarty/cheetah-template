; Manually optimized with hdfsee
; Optimized panel offsets can be found at the end of the file
; Optimized panel offsets can be found at the end of the file
; Optimized panel offsets can be found at the end of the file
; Optimized panel offsets can be found at the end of the file
; Optimized panel offsets can be found at the end of the file
; Optimized panel offsets can be found at the end of the file
; Optimized panel offsets can be found at the end of the file
; Optimized panel offsets can be found at the end of the file
; Optimized panel offsets can be found at the end of the file
; Optimized panel offsets can be found at the end of the file
; Optimized panel offsets can be found at the end of the file
; Optimized panel offsets can be found at the end of the file
; Optimized panel offsets can be found at the end of the file
; Manually optimized with hdfsee
; Optimized panel offsets can be found at the end of the file
; Manually optimized with hdfsee
; Optimized panel offsets can be found at the end of the file
; Manually optimized with hdfsee
; Camera length from LiTiO calibration
; Manually optimized with hdfsee
; Now all distances between panels is 5.8mm (29 pixels)
; OY: ACHTUNG! Orientation of the 2 halves of the detector might be wrong!
; A bit changed by OY: now 128 panels, rigid groups, bad lines to mask double pixels.
; Fixed errors noticed by Oleksandr
; Beginning of an AGIPD geometry construction by Helen Ginn on Thursday before beam time.
; Global panel positions not guesses
; Local positioning largely - but not entirely - guesses
; fast and slow scan directions have the potential to be accurate.

adu_per_eV = 0.0075  ; no idea
clen = 0.125
;clen = 0.164 ;for ADDU=-800
;19.57mm per 100ADDU
photon_energy = 9300
res = 5000 ; 200 um pixels

dim0 = %
dim1 = ss
dim2 = fs
data = /entry_1/instrument_1/detector_1/data
;data = /data/data

mask = /entry_1/instrument_1/detector_1/mask
mask_good = 0x0000
mask_bad = 0xffff

;bad_p7/min_fs = 0
;bad_p7/min_ss = 3584
;bad_p7/max_fs = 127
;bad_p7/max_ss = 4095

rigid_group_q0 = p0a0,p0a1,p0a2,p0a3,p0a4,p0a5,p0a6,p0a7,p1a0,p1a1,p1a2,p1a3,p1a4,p1a5,p1a6,p1a7,p2a0,p2a1,p2a2,p2a3,p2a4,p2a5,p2a6,p2a7,p3a0,p3a1,p3a2,p3a3,p3a4,p3a5,p3a6,p3a7
rigid_group_q1 = p4a0,p4a1,p4a2,p4a3,p4a4,p4a5,p4a6,p4a7,p5a0,p5a1,p5a2,p5a3,p5a4,p5a5,p5a6,p5a7,p6a0,p6a1,p6a2,p6a3,p6a4,p6a5,p6a6,p6a7,p7a0,p7a1,p7a2,p7a3,p7a4,p7a5,p7a6,p7a7
rigid_group_q2 = p8a0,p8a1,p8a2,p8a3,p8a4,p8a5,p8a6,p8a7,p9a0,p9a1,p9a2,p9a3,p9a4,p9a5,p9a6,p9a7,p10a0,p10a1,p10a2,p10a3,p10a4,p10a5,p10a6,p10a7,p11a0,p11a1,p11a2,p11a3,p11a4,p11a5,p11a6,p11a7
rigid_group_q3 = p12a0,p12a1,p12a2,p12a3,p12a4,p12a5,p12a6,p12a7,p13a0,p13a1,p13a2,p13a3,p13a4,p13a5,p13a6,p13a7,p14a0,p14a1,p14a2,p14a3,p14a4,p14a5,p14a6,p14a7,p15a0,p15a1,p15a2,p15a3,p15a4,p15a5,p15a6,p15a7

rigid_group_p0 = p0a0,p0a1,p0a2,p0a3,p0a4,p0a5,p0a6,p0a7
rigid_group_p1 = p1a0,p1a1,p1a2,p1a3,p1a4,p1a5,p1a6,p1a7
rigid_group_p2 = p2a0,p2a1,p2a2,p2a3,p2a4,p2a5,p2a6,p2a7
rigid_group_p3 = p3a0,p3a1,p3a2,p3a3,p3a4,p3a5,p3a6,p3a7
rigid_group_p4 = p4a0,p4a1,p4a2,p4a3,p4a4,p4a5,p4a6,p4a7
rigid_group_p5 = p5a0,p5a1,p5a2,p5a3,p5a4,p5a5,p5a6,p5a7
rigid_group_p6 = p6a0,p6a1,p6a2,p6a3,p6a4,p6a5,p6a6,p6a7
rigid_group_p7 = p7a0,p7a1,p7a2,p7a3,p7a4,p7a5,p7a6,p7a7
rigid_group_p8 = p8a0,p8a1,p8a2,p8a3,p8a4,p8a5,p8a6,p8a7
rigid_group_p9 = p9a0,p9a1,p9a2,p9a3,p9a4,p9a5,p9a6,p9a7
rigid_group_p10 = p10a0,p10a1,p10a2,p10a3,p10a4,p10a5,p10a6,p10a7
rigid_group_p11 = p11a0,p11a1,p11a2,p11a3,p11a4,p11a5,p11a6,p11a7
rigid_group_p12 = p12a0,p12a1,p12a2,p12a3,p12a4,p12a5,p12a6,p12a7
rigid_group_p13 = p13a0,p13a1,p13a2,p13a3,p13a4,p13a5,p13a6,p13a7
rigid_group_p14 = p14a0,p14a1,p14a2,p14a3,p14a4,p14a5,p14a6,p14a7
rigid_group_p15 = p15a0,p15a1,p15a2,p15a3,p15a4,p15a5,p15a6,p15a7

rigid_group_collection_quadrants = q0,q1,q2,q3
rigid_group_collection_asics = p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15

p0a0/min_fs = 0
p0a0/min_ss = 0
p0a0/max_fs = 127
p0a0/max_ss = 63
p0a0/fs = +0.001945x -0.999996y
p0a0/ss = +0.999996x +0.001945y
p0a0/corner_x  = -524.72
p0a0/corner_y  = 626.051

p0a1/min_fs = 0
p0a1/min_ss = 64
p0a1/max_fs = 127
p0a1/max_ss = 127
p0a1/fs = +0.001945x -0.999996y
p0a1/ss = +0.999996x +0.001945y
p0a1/corner_x  = -458.72
p0a1/corner_y  = 626.18

p0a2/min_fs = 0
p0a2/min_ss = 128
p0a2/max_fs = 127
p0a2/max_ss = 191
p0a2/fs = +0.001945x -0.999996y
p0a2/ss = +0.999996x +0.001945y
p0a2/corner_x  = -392.727
p0a2/corner_y  = 626.308

p0a3/min_fs = 0
p0a3/min_ss = 192
p0a3/max_fs = 127
p0a3/max_ss = 255
p0a3/fs = +0.001945x -0.999996y
p0a3/ss = +0.999996x +0.001945y
p0a3/corner_x  = -326.721
p0a3/corner_y  = 626.437

p0a4/min_fs = 0
p0a4/min_ss = 256
p0a4/max_fs = 127
p0a4/max_ss = 319
p0a4/fs = +0.001945x -0.999996y
p0a4/ss = +0.999996x +0.001945y
p0a4/corner_x  = -260.721
p0a4/corner_y  = 626.565

p0a5/min_fs = 0
p0a5/min_ss = 320
p0a5/max_fs = 127
p0a5/max_ss = 383
p0a5/fs = +0.001945x -0.999996y
p0a5/ss = +0.999996x +0.001945y
p0a5/corner_x  = -194.721
p0a5/corner_y  = 626.693

p0a6/min_fs = 0
p0a6/min_ss = 384
p0a6/max_fs = 127
p0a6/max_ss = 447
p0a6/fs = +0.001945x -0.999996y
p0a6/ss = +0.999996x +0.001945y
p0a6/corner_x  = -128.722
p0a6/corner_y  = 626.822

p0a7/min_fs = 0
p0a7/min_ss = 448
p0a7/max_fs = 127
p0a7/max_ss = 511
p0a7/fs = +0.001945x -0.999996y
p0a7/ss = +0.999996x +0.001945y
p0a7/corner_x  = -62.7221
p0a7/corner_y  = 626.95

p1a0/min_fs = 0
p1a0/min_ss = 512
p1a0/max_fs = 127
p1a0/max_ss = 575
p1a0/fs = +0.001022x -0.999999y
p1a0/ss = +0.999999x +0.001022y
p1a0/corner_x  = -524.7
p1a0/corner_y  = 469.25

p1a1/min_fs = 0
p1a1/min_ss = 576
p1a1/max_fs = 127
p1a1/max_ss = 639
p1a1/fs = +0.001022x -0.999999y
p1a1/ss = +0.999999x +0.001022y
p1a1/corner_x  = -458.703
p1a1/corner_y  = 469.317

p1a2/min_fs = 0
p1a2/min_ss = 640
p1a2/max_fs = 127
p1a2/max_ss = 703
p1a2/fs = +0.001022x -0.999999y
p1a2/ss = +0.999999x +0.001022y
p1a2/corner_x  = -392.706
p1a2/corner_y  = 469.384

p1a3/min_fs = 0
p1a3/min_ss = 704
p1a3/max_fs = 127
p1a3/max_ss = 767
p1a3/fs = +0.001022x -0.999999y
p1a3/ss = +0.999999x +0.001022y
p1a3/corner_x  = -326.71
p1a3/corner_y  = 469.452

p1a4/min_fs = 0
p1a4/min_ss = 768
p1a4/max_fs = 127
p1a4/max_ss = 831
p1a4/fs = +0.001022x -0.999999y
p1a4/ss = +0.999999x +0.001022y
p1a4/corner_x  = -260.713
p1a4/corner_y  = 469.519

p1a5/min_fs = 0
p1a5/min_ss = 832
p1a5/max_fs = 127
p1a5/max_ss = 895
p1a5/fs = +0.001022x -0.999999y
p1a5/ss = +0.999999x +0.001022y
p1a5/corner_x  = -194.717
p1a5/corner_y  = 469.587

p1a6/min_fs = 0
p1a6/min_ss = 896
p1a6/max_fs = 127
p1a6/max_ss = 959
p1a6/fs = +0.001022x -0.999999y
p1a6/ss = +0.999999x +0.001022y
p1a6/corner_x  = -128.72
p1a6/corner_y  = 469.654

p1a7/min_fs = 0
p1a7/min_ss = 960
p1a7/max_fs = 127
p1a7/max_ss = 1023
p1a7/fs = +0.001022x -0.999999y
p1a7/ss = +0.999999x +0.001022y
p1a7/corner_x  = -62.7232
p1a7/corner_y  = 469.721

p2a0/min_fs = 0
p2a0/min_ss = 1024
p2a0/max_fs = 127
p2a0/max_ss = 1087
p2a0/fs = +0.001059x -1.000000y
p2a0/ss = +1.000000x +0.001059y
p2a0/corner_x  = -524.361
p2a0/corner_y  = 312.56

p2a1/min_fs = 0
p2a1/min_ss = 1088
p2a1/max_fs = 127
p2a1/max_ss = 1151
p2a1/fs = +0.001059x -1.000000y
p2a1/ss = +1.000000x +0.001059y
p2a1/corner_x  = -458.364
p2a1/corner_y  = 312.63

p2a2/min_fs = 0
p2a2/min_ss = 1152
p2a2/max_fs = 127
p2a2/max_ss = 1215
p2a2/fs = +0.001059x -1.000000y
p2a2/ss = +1.000000x +0.001059y
p2a2/corner_x  = -392.367
p2a2/corner_y  = 312.7

p2a3/min_fs = 0
p2a3/min_ss = 1216
p2a3/max_fs = 127
p2a3/max_ss = 1279
p2a3/fs = +0.001059x -1.000000y
p2a3/ss = +1.000000x +0.001059y
p2a3/corner_x  = -326.37
p2a3/corner_y  = 312.769

p2a4/min_fs = 0
p2a4/min_ss = 1280
p2a4/max_fs = 127
p2a4/max_ss = 1343
p2a4/fs = +0.001059x -1.000000y
p2a4/ss = +1.000000x +0.001059y
p2a4/corner_x  = -260.372
p2a4/corner_y  = 312.839

p2a5/min_fs = 0
p2a5/min_ss = 1344
p2a5/max_fs = 127
p2a5/max_ss = 1407
p2a5/fs = +0.001059x -1.000000y
p2a5/ss = +1.000000x +0.001059y
p2a5/corner_x  = -194.375
p2a5/corner_y  = 312.909

p2a6/min_fs = 0
p2a6/min_ss = 1408
p2a6/max_fs = 127
p2a6/max_ss = 1471
p2a6/fs = +0.001059x -1.000000y
p2a6/ss = +1.000000x +0.001059y
p2a6/corner_x  = -128.361
p2a6/corner_y  = 312.979

p2a7/min_fs = 0
p2a7/min_ss = 1472
p2a7/max_fs = 127
p2a7/max_ss = 1535
p2a7/fs = +0.001059x -1.000000y
p2a7/ss = +1.000000x +0.001059y
p2a7/corner_x  = -62.361
p2a7/corner_y  = 313.049

p3a0/min_fs = 0
p3a0/min_ss = 1536
p3a0/max_fs = 127
p3a0/max_ss = 1599
p3a0/fs = +0.002817x -0.999996y
p3a0/ss = +0.999996x +0.002817y
p3a0/corner_x  = -524.467
p3a0/corner_y  = 155.266

p3a1/min_fs = 0
p3a1/min_ss = 1600
p3a1/max_fs = 127
p3a1/max_ss = 1663
p3a1/fs = +0.002817x -0.999996y
p3a1/ss = +0.999996x +0.002817y
p3a1/corner_x  = -458.47
p3a1/corner_y  = 155.452

p3a2/min_fs = 0
p3a2/min_ss = 1664
p3a2/max_fs = 127
p3a2/max_ss = 1727
p3a2/fs = +0.002817x -0.999996y
p3a2/ss = +0.999996x +0.002817y
p3a2/corner_x  = -392.473
p3a2/corner_y  = 155.638

p3a3/min_fs = 0
p3a3/min_ss = 1728
p3a3/max_fs = 127
p3a3/max_ss = 1791
p3a3/fs = +0.002817x -0.999996y
p3a3/ss = +0.999996x +0.002817y
p3a3/corner_x  = -326.478
p3a3/corner_y  = 155.824

p3a4/min_fs = 0
p3a4/min_ss = 1792
p3a4/max_fs = 127
p3a4/max_ss = 1855
p3a4/fs = +0.002817x -0.999996y
p3a4/ss = +0.999996x +0.002817y
p3a4/corner_x  = -260.481
p3a4/corner_y  = 156.009

p3a5/min_fs = 0
p3a5/min_ss = 1856
p3a5/max_fs = 127
p3a5/max_ss = 1919
p3a5/fs = +0.002817x -0.999996y
p3a5/ss = +0.999996x +0.002817y
p3a5/corner_x  = -194.468
p3a5/corner_y  = 156.195

p3a6/min_fs = 0
p3a6/min_ss = 1920
p3a6/max_fs = 127
p3a6/max_ss = 1983
p3a6/fs = +0.002817x -0.999996y
p3a6/ss = +0.999996x +0.002817y
p3a6/corner_x  = -128.468
p3a6/corner_y  = 156.381

p3a7/min_fs = 0
p3a7/min_ss = 1984
p3a7/max_fs = 127
p3a7/max_ss = 2047
p3a7/fs = +0.002817x -0.999996y
p3a7/ss = +0.999996x +0.002817y
p3a7/corner_x  = -62.4688
p3a7/corner_y  = 156.567

p4a0/min_fs = 0
p4a0/min_ss = 2048
p4a0/max_fs = 127
p4a0/max_ss = 2111
p4a0/fs = -0.001948x -0.999998y
p4a0/ss = +0.999998x -0.001948y
p4a0/corner_x  = -546.282
p4a0/corner_y  = -2.3105

p4a1/min_fs = 0
p4a1/min_ss = 2112
p4a1/max_fs = 127
p4a1/max_ss = 2175
p4a1/fs = -0.001948x -0.999998y
p4a1/ss = +0.999998x -0.001948y
p4a1/corner_x  = -480.287
p4a1/corner_y  = -2.4391

p4a2/min_fs = 0
p4a2/min_ss = 2176
p4a2/max_fs = 127
p4a2/max_ss = 2239
p4a2/fs = -0.001948x -0.999998y
p4a2/ss = +0.999998x -0.001948y
p4a2/corner_x  = -414.29
p4a2/corner_y  = -2.5676

p4a3/min_fs = 0
p4a3/min_ss = 2240
p4a3/max_fs = 127
p4a3/max_ss = 2303
p4a3/fs = -0.001948x -0.999998y
p4a3/ss = +0.999998x -0.001948y
p4a3/corner_x  = -348.294
p4a3/corner_y  = -2.6962

p4a4/min_fs = 0
p4a4/min_ss = 2304
p4a4/max_fs = 127
p4a4/max_ss = 2367
p4a4/fs = -0.001948x -0.999998y
p4a4/ss = +0.999998x -0.001948y
p4a4/corner_x  = -282.297
p4a4/corner_y  = -2.8248

p4a5/min_fs = 0
p4a5/min_ss = 2368
p4a5/max_fs = 127
p4a5/max_ss = 2431
p4a5/fs = -0.001948x -0.999998y
p4a5/ss = +0.999998x -0.001948y
p4a5/corner_x  = -216.3
p4a5/corner_y  = -2.9533

p4a6/min_fs = 0
p4a6/min_ss = 2432
p4a6/max_fs = 127
p4a6/max_ss = 2495
p4a6/fs = -0.001948x -0.999998y
p4a6/ss = +0.999998x -0.001948y
p4a6/corner_x  = -150.304
p4a6/corner_y  = -3.0819

p4a7/min_fs = 0
p4a7/min_ss = 2496
p4a7/max_fs = 127
p4a7/max_ss = 2559
p4a7/fs = -0.001948x -0.999998y
p4a7/ss = +0.999998x -0.001948y
p4a7/corner_x  = -84.3081
p4a7/corner_y  = -3.2104

p5a0/min_fs = 0
p5a0/min_ss = 2560
p5a0/max_fs = 127
p5a0/max_ss = 2623
p5a0/fs = -0.001226x -0.999999y
p5a0/ss = +0.999999x -0.001226y
p5a0/corner_x  = -546.61
p5a0/corner_y  = -160.654

p5a1/min_fs = 0
p5a1/min_ss = 2624
p5a1/max_fs = 127
p5a1/max_ss = 2687
p5a1/fs = -0.001226x -0.999999y
p5a1/ss = +0.999999x -0.001226y
p5a1/corner_x  = -480.614
p5a1/corner_y  = -160.734

p5a2/min_fs = 0
p5a2/min_ss = 2688
p5a2/max_fs = 127
p5a2/max_ss = 2751
p5a2/fs = -0.001226x -0.999999y
p5a2/ss = +0.999999x -0.001226y
p5a2/corner_x  = -414.617
p5a2/corner_y  = -160.815

p5a3/min_fs = 0
p5a3/min_ss = 2752
p5a3/max_fs = 127
p5a3/max_ss = 2815
p5a3/fs = -0.001226x -0.999999y
p5a3/ss = +0.999999x -0.001226y
p5a3/corner_x  = -348.621
p5a3/corner_y  = -160.896

p5a4/min_fs = 0
p5a4/min_ss = 2816
p5a4/max_fs = 127
p5a4/max_ss = 2879
p5a4/fs = -0.001226x -0.999999y
p5a4/ss = +0.999999x -0.001226y
p5a4/corner_x  = -282.624
p5a4/corner_y  = -160.977

p5a5/min_fs = 0
p5a5/min_ss = 2880
p5a5/max_fs = 127
p5a5/max_ss = 2943
p5a5/fs = -0.001226x -0.999999y
p5a5/ss = +0.999999x -0.001226y
p5a5/corner_x  = -216.61
p5a5/corner_y  = -161.058

p5a6/min_fs = 0
p5a6/min_ss = 2944
p5a6/max_fs = 127
p5a6/max_ss = 3007
p5a6/fs = -0.001226x -0.999999y
p5a6/ss = +0.999999x -0.001226y
p5a6/corner_x  = -150.61
p5a6/corner_y  = -161.139

p5a7/min_fs = 0
p5a7/min_ss = 3008
p5a7/max_fs = 127
p5a7/max_ss = 3071
p5a7/fs = -0.001226x -0.999999y
p5a7/ss = +0.999999x -0.001226y
p5a7/corner_x  = -84.6105
p5a7/corner_y  = -161.22

p6a0/min_fs = 0
p6a0/min_ss = 3072
p6a0/max_fs = 127
p6a0/max_ss = 3135
p6a0/fs = -0.005348x -0.999986y
p6a0/ss = +0.999986x -0.005348y
p6a0/corner_x  = -546.663
p6a0/corner_y  = -316.174

p6a1/min_fs = 0
p6a1/min_ss = 3136
p6a1/max_fs = 127
p6a1/max_ss = 3199
p6a1/fs = -0.005348x -0.999986y
p6a1/ss = +0.999986x -0.005348y
p6a1/corner_x  = -480.667
p6a1/corner_y  = -316.527

p6a2/min_fs = 0
p6a2/min_ss = 3200
p6a2/max_fs = 127
p6a2/max_ss = 3263
p6a2/fs = -0.005348x -0.999986y
p6a2/ss = +0.999986x -0.005348y
p6a2/corner_x  = -414.672
p6a2/corner_y  = -316.88

p6a3/min_fs = 0
p6a3/min_ss = 3264
p6a3/max_fs = 127
p6a3/max_ss = 3327
p6a3/fs = -0.005348x -0.999986y
p6a3/ss = +0.999986x -0.005348y
p6a3/corner_x  = -348.676
p6a3/corner_y  = -317.232

p6a4/min_fs = 0
p6a4/min_ss = 3328
p6a4/max_fs = 127
p6a4/max_ss = 3391
p6a4/fs = -0.005348x -0.999986y
p6a4/ss = +0.999986x -0.005348y
p6a4/corner_x  = -282.681
p6a4/corner_y  = -317.585

p6a5/min_fs = 0
p6a5/min_ss = 3392
p6a5/max_fs = 127
p6a5/max_ss = 3455
p6a5/fs = -0.005348x -0.999986y
p6a5/ss = +0.999986x -0.005348y
p6a5/corner_x  = -216.683
p6a5/corner_y  = -317.938

p6a6/min_fs = 0
p6a6/min_ss = 3456
p6a6/max_fs = 127
p6a6/max_ss = 3519
p6a6/fs = -0.005348x -0.999986y
p6a6/ss = +0.999986x -0.005348y
p6a6/corner_x  = -150.689
p6a6/corner_y  = -318.291

p6a7/min_fs = 0
p6a7/min_ss = 3520
p6a7/max_fs = 127
p6a7/max_ss = 3583
p6a7/fs = -0.005348x -0.999986y
p6a7/ss = +0.999986x -0.005348y
p6a7/corner_x  = -84.6914
p6a7/corner_y  = -318.644

p7a0/min_fs = 0
p7a0/min_ss = 3584
p7a0/max_fs = 127
p7a0/max_ss = 3647
p7a0/fs = -0.005589x -0.999984y
p7a0/ss = +0.999984x -0.005589y
p7a0/corner_x  = -547.218
p7a0/corner_y  = -472.64

p7a1/min_fs = 0
p7a1/min_ss = 3648
p7a1/max_fs = 127
p7a1/max_ss = 3711
p7a1/fs = -0.005589x -0.999984y
p7a1/ss = +0.999984x -0.005589y
p7a1/corner_x  = -481.225
p7a1/corner_y  = -473.009

p7a2/min_fs = 0
p7a2/min_ss = 3712
p7a2/max_fs = 127
p7a2/max_ss = 3775
p7a2/fs = -0.005589x -0.999984y
p7a2/ss = +0.999984x -0.005589y
p7a2/corner_x  = -415.229
p7a2/corner_y  = -473.377

p7a3/min_fs = 0
p7a3/min_ss = 3776
p7a3/max_fs = 127
p7a3/max_ss = 3839
p7a3/fs = -0.005589x -0.999984y
p7a3/ss = +0.999984x -0.005589y
p7a3/corner_x  = -349.234
p7a3/corner_y  = -473.746

p7a4/min_fs = 0
p7a4/min_ss = 3840
p7a4/max_fs = 127
p7a4/max_ss = 3903
p7a4/fs = -0.005589x -0.999984y
p7a4/ss = +0.999984x -0.005589y
p7a4/corner_x  = -283.239
p7a4/corner_y  = -474.115

p7a5/min_fs = 0
p7a5/min_ss = 3904
p7a5/max_fs = 127
p7a5/max_ss = 3967
p7a5/fs = -0.005589x -0.999984y
p7a5/ss = +0.999984x -0.005589y
p7a5/corner_x  = -217.243
p7a5/corner_y  = -474.484

p7a6/min_fs = 0
p7a6/min_ss = 3968
p7a6/max_fs = 127
p7a6/max_ss = 4031
p7a6/fs = -0.005589x -0.999984y
p7a6/ss = +0.999984x -0.005589y
p7a6/corner_x  = -151.247
p7a6/corner_y  = -474.853

p7a7/min_fs = 0
p7a7/min_ss = 4032
p7a7/max_fs = 127
p7a7/max_ss = 4095
p7a7/fs = -0.005589x -0.999984y
p7a7/ss = +0.999984x -0.005589y
p7a7/corner_x  = -85.2515
p7a7/corner_y  = -475.221

p8a0/min_fs = 0
p8a0/min_ss = 4096
p8a0/max_fs = 127
p8a0/max_ss = 4159
p8a0/fs = +0.002999x +0.999996y
p8a0/ss = -0.999996x +0.002999y
p8a0/corner_x  = 520.168
p8a0/corner_y  = -156.855

p8a1/min_fs = 0
p8a1/min_ss = 4160
p8a1/max_fs = 127
p8a1/max_ss = 4223
p8a1/fs = +0.002999x +0.999996y
p8a1/ss = -0.999996x +0.002999y
p8a1/corner_x  = 454.171
p8a1/corner_y  = -156.657

p8a2/min_fs = 0
p8a2/min_ss = 4224
p8a2/max_fs = 127
p8a2/max_ss = 4287
p8a2/fs = +0.002999x +0.999996y
p8a2/ss = -0.999996x +0.002999y
p8a2/corner_x  = 388.174
p8a2/corner_y  = -156.459

p8a3/min_fs = 0
p8a3/min_ss = 4288
p8a3/max_fs = 127
p8a3/max_ss = 4351
p8a3/fs = +0.002999x +0.999996y
p8a3/ss = -0.999996x +0.002999y
p8a3/corner_x  = 322.179
p8a3/corner_y  = -156.262

p8a4/min_fs = 0
p8a4/min_ss = 4352
p8a4/max_fs = 127
p8a4/max_ss = 4415
p8a4/fs = +0.002999x +0.999996y
p8a4/ss = -0.999996x +0.002999y
p8a4/corner_x  = 256.182
p8a4/corner_y  = -156.064

p8a5/min_fs = 0
p8a5/min_ss = 4416
p8a5/max_fs = 127
p8a5/max_ss = 4479
p8a5/fs = +0.002999x +0.999996y
p8a5/ss = -0.999996x +0.002999y
p8a5/corner_x  = 190.184
p8a5/corner_y  = -155.866

p8a6/min_fs = 0
p8a6/min_ss = 4480
p8a6/max_fs = 127
p8a6/max_ss = 4543
p8a6/fs = +0.002999x +0.999996y
p8a6/ss = -0.999996x +0.002999y
p8a6/corner_x  = 124.188
p8a6/corner_y  = -155.668

p8a7/min_fs = 0
p8a7/min_ss = 4544
p8a7/max_fs = 127
p8a7/max_ss = 4607
p8a7/fs = +0.002999x +0.999996y
p8a7/ss = -0.999996x +0.002999y
p8a7/corner_x  = 58.1918
p8a7/corner_y  = -155.47

p9a0/min_fs = 0
p9a0/min_ss = 4608
p9a0/max_fs = 127
p9a0/max_ss = 4671
p9a0/fs = +0.001236x +0.999999y
p9a0/ss = -0.999999x +0.001236y
p9a0/corner_x  = 520.945
p9a0/corner_y  = -311.364

p9a1/min_fs = 0
p9a1/min_ss = 4672
p9a1/max_fs = 127
p9a1/max_ss = 4735
p9a1/fs = +0.001236x +0.999999y
p9a1/ss = -0.999999x +0.001236y
p9a1/corner_x  = 454.95
p9a1/corner_y  = -311.282

p9a2/min_fs = 0
p9a2/min_ss = 4736
p9a2/max_fs = 127
p9a2/max_ss = 4799
p9a2/fs = +0.001236x +0.999999y
p9a2/ss = -0.999999x +0.001236y
p9a2/corner_x  = 388.953
p9a2/corner_y  = -311.201

p9a3/min_fs = 0
p9a3/min_ss = 4800
p9a3/max_fs = 127
p9a3/max_ss = 4863
p9a3/fs = +0.001236x +0.999999y
p9a3/ss = -0.999999x +0.001236y
p9a3/corner_x  = 322.957
p9a3/corner_y  = -311.119

p9a4/min_fs = 0
p9a4/min_ss = 4864
p9a4/max_fs = 127
p9a4/max_ss = 4927
p9a4/fs = +0.001236x +0.999999y
p9a4/ss = -0.999999x +0.001236y
p9a4/corner_x  = 256.96
p9a4/corner_y  = -311.037

p9a5/min_fs = 0
p9a5/min_ss = 4928
p9a5/max_fs = 127
p9a5/max_ss = 4991
p9a5/fs = +0.001236x +0.999999y
p9a5/ss = -0.999999x +0.001236y
p9a5/corner_x  = 190.963
p9a5/corner_y  = -310.956

p9a6/min_fs = 0
p9a6/min_ss = 4992
p9a6/max_fs = 127
p9a6/max_ss = 5055
p9a6/fs = +0.001236x +0.999999y
p9a6/ss = -0.999999x +0.001236y
p9a6/corner_x  = 124.945
p9a6/corner_y  = -310.874

p9a7/min_fs = 0
p9a7/min_ss = 5056
p9a7/max_fs = 127
p9a7/max_ss = 5119
p9a7/fs = +0.001236x +0.999999y
p9a7/ss = -0.999999x +0.001236y
p9a7/corner_x  = 58.9452
p9a7/corner_y  = -310.793

p10a0/min_fs = 0
p10a0/min_ss = 5120
p10a0/max_fs = 127
p10a0/max_ss = 5183
p10a0/fs = +0.004981x +0.999987y
p10a0/ss = -0.999987x +0.004981y
p10a0/corner_x  = 520.203
p10a0/corner_y  = -469.985

p10a1/min_fs = 0
p10a1/min_ss = 5184
p10a1/max_fs = 127
p10a1/max_ss = 5247
p10a1/fs = +0.004981x +0.999987y
p10a1/ss = -0.999987x +0.004981y
p10a1/corner_x  = 454.208
p10a1/corner_y  = -469.656

p10a2/min_fs = 0
p10a2/min_ss = 5248
p10a2/max_fs = 127
p10a2/max_ss = 5311
p10a2/fs = +0.004981x +0.999987y
p10a2/ss = -0.999987x +0.004981y
p10a2/corner_x  = 388.212
p10a2/corner_y  = -469.327

p10a3/min_fs = 0
p10a3/min_ss = 5312
p10a3/max_fs = 127
p10a3/max_ss = 5375
p10a3/fs = +0.004981x +0.999987y
p10a3/ss = -0.999987x +0.004981y
p10a3/corner_x  = 322.217
p10a3/corner_y  = -468.999

p10a4/min_fs = 0
p10a4/min_ss = 5376
p10a4/max_fs = 127
p10a4/max_ss = 5439
p10a4/fs = +0.004981x +0.999987y
p10a4/ss = -0.999987x +0.004981y
p10a4/corner_x  = 256.221
p10a4/corner_y  = -468.67

p10a5/min_fs = 0
p10a5/min_ss = 5440
p10a5/max_fs = 127
p10a5/max_ss = 5503
p10a5/fs = +0.004981x +0.999987y
p10a5/ss = -0.999987x +0.004981y
p10a5/corner_x  = 190.226
p10a5/corner_y  = -468.341

p10a6/min_fs = 0
p10a6/min_ss = 5504
p10a6/max_fs = 127
p10a6/max_ss = 5567
p10a6/fs = +0.004981x +0.999987y
p10a6/ss = -0.999987x +0.004981y
p10a6/corner_x  = 124.231
p10a6/corner_y  = -468.012

p10a7/min_fs = 0
p10a7/min_ss = 5568
p10a7/max_fs = 127
p10a7/max_ss = 5631
p10a7/fs = +0.004981x +0.999987y
p10a7/ss = -0.999987x +0.004981y
p10a7/corner_x  = 58.2361
p10a7/corner_y  = -467.684

p11a0/min_fs = 0
p11a0/min_ss = 5632
p11a0/max_fs = 127
p11a0/max_ss = 5695
p11a0/fs = +0.002778x +0.999996y
p11a0/ss = -0.999996x +0.002778y
p11a0/corner_x  = 519.354
p11a0/corner_y  = -626.174

p11a1/min_fs = 0
p11a1/min_ss = 5696
p11a1/max_fs = 127
p11a1/max_ss = 5759
p11a1/fs = +0.002778x +0.999996y
p11a1/ss = -0.999996x +0.002778y
p11a1/corner_x  = 453.356
p11a1/corner_y  = -625.991

p11a2/min_fs = 0
p11a2/min_ss = 5760
p11a2/max_fs = 127
p11a2/max_ss = 5823
p11a2/fs = +0.002778x +0.999996y
p11a2/ss = -0.999996x +0.002778y
p11a2/corner_x  = 387.359
p11a2/corner_y  = -625.808

p11a3/min_fs = 0
p11a3/min_ss = 5824
p11a3/max_fs = 127
p11a3/max_ss = 5887
p11a3/fs = +0.002778x +0.999996y
p11a3/ss = -0.999996x +0.002778y
p11a3/corner_x  = 321.364
p11a3/corner_y  = -625.624

p11a4/min_fs = 0
p11a4/min_ss = 5888
p11a4/max_fs = 127
p11a4/max_ss = 5951
p11a4/fs = +0.002778x +0.999996y
p11a4/ss = -0.999996x +0.002778y
p11a4/corner_x  = 255.368
p11a4/corner_y  = -625.441

p11a5/min_fs = 0
p11a5/min_ss = 5952
p11a5/max_fs = 127
p11a5/max_ss = 6015
p11a5/fs = +0.002778x +0.999996y
p11a5/ss = -0.999996x +0.002778y
p11a5/corner_x  = 189.371
p11a5/corner_y  = -625.258

p11a6/min_fs = 0
p11a6/min_ss = 6016
p11a6/max_fs = 127
p11a6/max_ss = 6079
p11a6/fs = +0.002778x +0.999996y
p11a6/ss = -0.999996x +0.002778y
p11a6/corner_x  = 123.376
p11a6/corner_y  = -625.074

p11a7/min_fs = 0
p11a7/min_ss = 6080
p11a7/max_fs = 127
p11a7/max_ss = 6143
p11a7/fs = +0.002778x +0.999996y
p11a7/ss = -0.999996x +0.002778y
p11a7/corner_x  = 57.3775
p11a7/corner_y  = -624.891

p12a0/min_fs = 0
p12a0/min_ss = 6144
p12a0/max_fs = 127
p12a0/max_ss = 6207
p12a0/fs = -0.000363x +1.000000y
p12a0/ss = -1.000000x -0.000363y
p12a0/corner_x  = 539.946
p12a0/corner_y  = 475.389

p12a1/min_fs = 0
p12a1/min_ss = 6208
p12a1/max_fs = 127
p12a1/max_ss = 6271
p12a1/fs = -0.000363x +1.000000y
p12a1/ss = -1.000000x -0.000363y
p12a1/corner_x  = 473.949
p12a1/corner_y  = 475.365

p12a2/min_fs = 0
p12a2/min_ss = 6272
p12a2/max_fs = 127
p12a2/max_ss = 6335
p12a2/fs = -0.000363x +1.000000y
p12a2/ss = -1.000000x -0.000363y
p12a2/corner_x  = 407.953
p12a2/corner_y  = 475.341

p12a3/min_fs = 0
p12a3/min_ss = 6336
p12a3/max_fs = 127
p12a3/max_ss = 6399
p12a3/fs = -0.000363x +1.000000y
p12a3/ss = -1.000000x -0.000363y
p12a3/corner_x  = 341.956
p12a3/corner_y  = 475.317

p12a4/min_fs = 0
p12a4/min_ss = 6400
p12a4/max_fs = 127
p12a4/max_ss = 6463
p12a4/fs = -0.000363x +1.000000y
p12a4/ss = -1.000000x -0.000363y
p12a4/corner_x  = 275.959
p12a4/corner_y  = 475.293

p12a5/min_fs = 0
p12a5/min_ss = 6464
p12a5/max_fs = 127
p12a5/max_ss = 6527
p12a5/fs = -0.000363x +1.000000y
p12a5/ss = -1.000000x -0.000363y
p12a5/corner_x  = 209.963
p12a5/corner_y  = 475.269

p12a6/min_fs = 0
p12a6/min_ss = 6528
p12a6/max_fs = 127
p12a6/max_ss = 6591
p12a6/fs = -0.000363x +1.000000y
p12a6/ss = -1.000000x -0.000363y
p12a6/corner_x  = 143.966
p12a6/corner_y  = 475.245

p12a7/min_fs = 0
p12a7/min_ss = 6592
p12a7/max_fs = 127
p12a7/max_ss = 6655
p12a7/fs = -0.000363x +1.000000y
p12a7/ss = -1.000000x -0.000363y
p12a7/corner_x  = 77.97
p12a7/corner_y  = 475.221

p13a0/min_fs = 0
p13a0/min_ss = 6656
p13a0/max_fs = 127
p13a0/max_ss = 6719
p13a0/fs = -0.001695x +0.999998y
p13a0/ss = -0.999998x -0.001695y
p13a0/corner_x  = 541.194
p13a0/corner_y  = 319.27

p13a1/min_fs = 0
p13a1/min_ss = 6720
p13a1/max_fs = 127
p13a1/max_ss = 6783
p13a1/fs = -0.001695x +0.999998y
p13a1/ss = -0.999998x -0.001695y
p13a1/corner_x  = 475.197
p13a1/corner_y  = 319.158

p13a2/min_fs = 0
p13a2/min_ss = 6784
p13a2/max_fs = 127
p13a2/max_ss = 6847
p13a2/fs = -0.001695x +0.999998y
p13a2/ss = -0.999998x -0.001695y
p13a2/corner_x  = 409.203
p13a2/corner_y  = 319.046

p13a3/min_fs = 0
p13a3/min_ss = 6848
p13a3/max_fs = 127
p13a3/max_ss = 6911
p13a3/fs = -0.001695x +0.999998y
p13a3/ss = -0.999998x -0.001695y
p13a3/corner_x  = 343.206
p13a3/corner_y  = 318.934

p13a4/min_fs = 0
p13a4/min_ss = 6912
p13a4/max_fs = 127
p13a4/max_ss = 6975
p13a4/fs = -0.001695x +0.999998y
p13a4/ss = -0.999998x -0.001695y
p13a4/corner_x  = 277.209
p13a4/corner_y  = 318.822

p13a5/min_fs = 0
p13a5/min_ss = 6976
p13a5/max_fs = 127
p13a5/max_ss = 7039
p13a5/fs = -0.001695x +0.999998y
p13a5/ss = -0.999998x -0.001695y
p13a5/corner_x  = 211.214
p13a5/corner_y  = 318.711

p13a6/min_fs = 0
p13a6/min_ss = 7040
p13a6/max_fs = 127
p13a6/max_ss = 7103
p13a6/fs = -0.001695x +0.999998y
p13a6/ss = -0.999998x -0.001695y
p13a6/corner_x  = 145.219
p13a6/corner_y  = 318.599

p13a7/min_fs = 0
p13a7/min_ss = 7104
p13a7/max_fs = 127
p13a7/max_ss = 7167
p13a7/fs = -0.001695x +0.999998y
p13a7/ss = -0.999998x -0.001695y
p13a7/corner_x  = 79.223
p13a7/corner_y  = 318.487

p14a0/min_fs = 0
p14a0/min_ss = 7168
p14a0/max_fs = 127
p14a0/max_ss = 7231
p14a0/fs = -0.000386x +1.000000y
p14a0/ss = -1.000000x -0.000386y
p14a0/corner_x  = 540.717
p14a0/corner_y  = 161.026

p14a1/min_fs = 0
p14a1/min_ss = 7232
p14a1/max_fs = 127
p14a1/max_ss = 7295
p14a1/fs = -0.000386x +1.000000y
p14a1/ss = -1.000000x -0.000386y
p14a1/corner_x  = 474.72
p14a1/corner_y  = 161

p14a2/min_fs = 0
p14a2/min_ss = 7296
p14a2/max_fs = 127
p14a2/max_ss = 7359
p14a2/fs = -0.000386x +1.000000y
p14a2/ss = -1.000000x -0.000386y
p14a2/corner_x  = 408.724
p14a2/corner_y  = 160.975

p14a3/min_fs = 0
p14a3/min_ss = 7360
p14a3/max_fs = 127
p14a3/max_ss = 7423
p14a3/fs = -0.000386x +1.000000y
p14a3/ss = -1.000000x -0.000386y
p14a3/corner_x  = 342.727
p14a3/corner_y  = 160.949

p14a4/min_fs = 0
p14a4/min_ss = 7424
p14a4/max_fs = 127
p14a4/max_ss = 7487
p14a4/fs = -0.000386x +1.000000y
p14a4/ss = -1.000000x -0.000386y
p14a4/corner_x  = 276.73
p14a4/corner_y  = 160.924

p14a5/min_fs = 0
p14a5/min_ss = 7488
p14a5/max_fs = 127
p14a5/max_ss = 7551
p14a5/fs = -0.000386x +1.000000y
p14a5/ss = -1.000000x -0.000386y
p14a5/corner_x  = 210.734
p14a5/corner_y  = 160.898

p14a6/min_fs = 0
p14a6/min_ss = 7552
p14a6/max_fs = 127
p14a6/max_ss = 7615
p14a6/fs = -0.000386x +1.000000y
p14a6/ss = -1.000000x -0.000386y
p14a6/corner_x  = 144.737
p14a6/corner_y  = 160.873

p14a7/min_fs = 0
p14a7/min_ss = 7616
p14a7/max_fs = 127
p14a7/max_ss = 7679
p14a7/fs = -0.000386x +1.000000y
p14a7/ss = -1.000000x -0.000386y
p14a7/corner_x  = 78.741
p14a7/corner_y  = 160.847

p15a0/min_fs = 0
p15a0/min_ss = 7680
p15a0/max_fs = 127
p15a0/max_ss = 7743
p15a0/fs = +0.001372x +0.999999y
p15a0/ss = -0.999999x +0.001372y
p15a0/corner_x  = 540.365
p15a0/corner_y  = 4.7733

p15a1/min_fs = 0
p15a1/min_ss = 7744
p15a1/max_fs = 127
p15a1/max_ss = 7807
p15a1/fs = +0.001372x +0.999999y
p15a1/ss = -0.999999x +0.001372y
p15a1/corner_x  = 474.368
p15a1/corner_y  = 4.8638

p15a2/min_fs = 0
p15a2/min_ss = 7808
p15a2/max_fs = 127
p15a2/max_ss = 7871
p15a2/fs = +0.001372x +0.999999y
p15a2/ss = -0.999999x +0.001372y
p15a2/corner_x  = 408.373
p15a2/corner_y  = 4.9544

p15a3/min_fs = 0
p15a3/min_ss = 7872
p15a3/max_fs = 127
p15a3/max_ss = 7935
p15a3/fs = +0.001372x +0.999999y
p15a3/ss = -0.999999x +0.001372y
p15a3/corner_x  = 342.376
p15a3/corner_y  = 5.0449

p15a4/min_fs = 0
p15a4/min_ss = 7936
p15a4/max_fs = 127
p15a4/max_ss = 7999
p15a4/fs = +0.001372x +0.999999y
p15a4/ss = -0.999999x +0.001372y
p15a4/corner_x  = 276.379
p15a4/corner_y  = 5.1354

p15a5/min_fs = 0
p15a5/min_ss = 8000
p15a5/max_fs = 127
p15a5/max_ss = 8063
p15a5/fs = +0.001372x +0.999999y
p15a5/ss = -0.999999x +0.001372y
p15a5/corner_x  = 210.383
p15a5/corner_y  = 5.226

p15a6/min_fs = 0
p15a6/min_ss = 8064
p15a6/max_fs = 127
p15a6/max_ss = 8127
p15a6/fs = +0.001372x +0.999999y
p15a6/ss = -0.999999x +0.001372y
p15a6/corner_x  = 144.386
p15a6/corner_y  = 5.3165

p15a7/min_fs = 0
p15a7/min_ss = 8128
p15a7/max_fs = 127
p15a7/max_ss = 8191
p15a7/fs = +0.001372x +0.999999y
p15a7/ss = -0.999999x +0.001372y
p15a7/corner_x  = 78.39
p15a7/corner_y  = 5.4071





p0a0/coffset = 0.000392
p0a1/coffset = 0.000392
p0a2/coffset = 0.000392
p0a3/coffset = 0.000392
p0a4/coffset = 0.000392
p0a5/coffset = 0.000392
p0a6/coffset = 0.000392
p0a7/coffset = 0.000392
p1a0/coffset = 0.000344
p1a1/coffset = 0.000344
p1a2/coffset = 0.000344
p1a3/coffset = 0.000344
p1a4/coffset = 0.000344
p1a5/coffset = 0.000344
p1a6/coffset = 0.000344
p1a7/coffset = 0.000344
p2a0/coffset = 0.000086
p2a1/coffset = 0.000086
p2a2/coffset = 0.000086
p2a3/coffset = 0.000086
p2a4/coffset = 0.000086
p2a5/coffset = 0.000086
p2a6/coffset = 0.000086
p2a7/coffset = 0.000086
p3a0/coffset = 0.000443
p3a1/coffset = 0.000443
p3a2/coffset = 0.000443
p3a3/coffset = 0.000443
p3a4/coffset = 0.000443
p3a5/coffset = 0.000443
p3a6/coffset = 0.000443
p3a7/coffset = 0.000443
p4a0/coffset = 0.000475
p4a1/coffset = 0.000475
p4a2/coffset = 0.000475
p4a3/coffset = 0.000475
p4a4/coffset = 0.000475
p4a5/coffset = 0.000475
p4a6/coffset = 0.000475
p4a7/coffset = 0.000475
p5a0/coffset = 0.000584
p5a1/coffset = 0.000584
p5a2/coffset = 0.000584
p5a3/coffset = 0.000584
p5a4/coffset = 0.000584
p5a5/coffset = 0.000584
p5a6/coffset = 0.000584
p5a7/coffset = 0.000584
p6a0/coffset = 0.000672
p6a1/coffset = 0.000672
p6a2/coffset = 0.000672
p6a3/coffset = 0.000672
p6a4/coffset = 0.000672
p6a5/coffset = 0.000672
p6a6/coffset = 0.000672
p6a7/coffset = 0.000672
p7a0/coffset = 0.001152
p7a1/coffset = 0.001152
p7a2/coffset = 0.001152
p7a3/coffset = 0.001152
p7a4/coffset = 0.001152
p7a5/coffset = 0.001152
p7a6/coffset = 0.001152
p7a7/coffset = 0.001152
p8a0/coffset = 0.000231
p8a1/coffset = 0.000231
p8a2/coffset = 0.000231
p8a3/coffset = 0.000231
p8a4/coffset = 0.000231
p8a5/coffset = 0.000231
p8a6/coffset = 0.000231
p8a7/coffset = 0.000231
p9a0/coffset = 0.000061
p9a1/coffset = 0.000061
p9a2/coffset = 0.000061
p9a3/coffset = 0.000061
p9a4/coffset = 0.000061
p9a5/coffset = 0.000061
p9a6/coffset = 0.000061
p9a7/coffset = 0.000061
p10a0/coffset = 0.000183
p10a1/coffset = 0.000183
p10a2/coffset = 0.000183
p10a3/coffset = 0.000183
p10a4/coffset = 0.000183
p10a5/coffset = 0.000183
p10a6/coffset = 0.000183
p10a7/coffset = 0.000183
p11a0/coffset = 0.000450
p11a1/coffset = 0.000450
p11a2/coffset = 0.000450
p11a3/coffset = 0.000450
p11a4/coffset = 0.000450
p11a5/coffset = 0.000450
p11a6/coffset = 0.000450
p11a7/coffset = 0.000450
p12a0/coffset = -0.000629
p12a1/coffset = -0.000629
p12a2/coffset = -0.000629
p12a3/coffset = -0.000629
p12a4/coffset = -0.000629
p12a5/coffset = -0.000629
p12a6/coffset = -0.000629
p12a7/coffset = -0.000629
p13a0/coffset = -0.000570
p13a1/coffset = -0.000570
p13a2/coffset = -0.000570
p13a3/coffset = -0.000570
p13a4/coffset = -0.000570
p13a5/coffset = -0.000570
p13a6/coffset = -0.000570
p13a7/coffset = -0.000570
p14a0/coffset = -0.000633
p14a1/coffset = -0.000633
p14a2/coffset = -0.000633
p14a3/coffset = -0.000633
p14a4/coffset = -0.000633
p14a5/coffset = -0.000633
p14a6/coffset = -0.000633
p14a7/coffset = -0.000633
p15a0/coffset = -0.000633
p15a1/coffset = -0.000633
p15a2/coffset = -0.000633
p15a3/coffset = -0.000633
p15a4/coffset = -0.000633
p15a5/coffset = -0.000633
p15a6/coffset = -0.000633
p15a7/coffset = -0.000633
