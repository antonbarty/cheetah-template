
; File format definitions

;
; Steffen agipd_offset_store
;
;[kakadu:barty]anton-sept-MHzXtal/agipd/steffen-cal1> h5ls -r data/agipd_offset_store_r0176_r0177_r0178.h5 | head -n 20
;/                        Group
;/Q1M1                    Group
;/Q1M1/Noise              Group
;/Q1M1/Noise/0            Group
;/Q1M1/Noise/0/data       Dataset {128, 512, 32, 3}
;/Q1M1/Offset             Group
;/Q1M1/Offset/0           Group
;/Q1M1/Offset/0/data      Dataset {128, 512, 32, 3}
;/Q1M1/Threshold          Group
;/Q1M1/Threshold/0        Group
;/Q1M1/Threshold/0/data   Dataset {128, 512, 32, 2}

;
; Steffen agipd_base_store
;
;[kakadu:barty]anton-sept-MHzXtal/agipd/steffen-cal1> h5ls -r data/agipd_base_store_r0176_r0177_r0178.h5 | head -n 20
;/                        Group
;/Q1M1                    Group
;/Q1M1/BaseOffset         Group
;/Q1M1/BaseOffset/0       Group
;/Q1M1/BaseOffset/0/data  Dataset {128, 512, 32, 3}
;/Q1M1/BaseOffset/0/mask  Dataset {128, 512, 32, 2}
;/Q1M1/RelativeGain       Group
;/Q1M1/RelativeGain/0     Group
;/Q1M1/RelativeGain/0/data Dataset {128, 512, 32, 3}
;/Q1M1/RelativeGain/0/mask Dataset {128, 512, 32, 3}
;/Q1M1/Threshold          Group
;/Q1M1/Threshold/0        Group
;/Q1M1/Threshold/0/data   Dataset {128, 512, 32, 2}
;/Q1M1/Threshold/0/mask   Dataset {128, 512, 32, 3}

;
; Manuela dark
;
;;[max-cfel009:barty]kuhnm/dark/r0091-r0092-r0093> h5ls -r dark_AGIPD00_xfel_2017-09-17.h5 
;;/                        Group
;;/gainlevel_mean          Dataset {3, 30, 512, 128}
;;/offset                  Dataset {3, 30, 512, 128}
;;/run_number              Dataset {3}
;;/stddev                  Dataset {3, 30, 512, 128}
;;/threshold               Dataset {2, 30, 512, 128}

; 
; Manuela pcdrs
;
;;[max-exfl001:barty]scratch/anton/calib> h5ls -r kuhnm-pcdrs/r0488-r0489-r0490-r0491-r0492-r0493-r0494-r0495/pcdrs_joined_constants_xfel.h5
;;/                        Group
;;/channel00               Group
;;/channel00/collection    Group
;;/channel00/collection/creation_date Dataset {SCALAR}
;;/channel00/collection/run_number Dataset {1}
;;/channel00/gainlevel_mean Dataset {2, 32, 512, 128}
;;/channel00/offset        Dataset {2, 32, 512, 128}
;;/channel00/slope         Dataset {2, 32, 512, 128}
;;/channel00/threshold     Dataset {1, 32, 512, 128}




;; 
;;	process offsets
;;	From Steffen:
;; 		offset from darks (O_d) and base offset (O_b) are rescaled using:
;;			offset = O_d
;;			do = np.median(O_b-O_d, axis=(0,1))
;;			offset[...,1:] -= do[...,1:]
;;		so for high gain the dark derived offset is directly used, for the other a module median of the difference between
;;		base offset and dark derived offset is created on a per-memory cell basis.
;;
function process_offset, manuela_dark
	print,'Processing offsets:'
	s = size(manuela_dark, /dim)

	out = fltarr(s)
	
	nfs = s[0]
	nss = s[1]
	ncell = s[2]
	ngain = s[3]
	
	for c = 0, ncell-1 do begin
		
		;; Use normal dark data, except for medium gain where we use PCDRS offsets
		out[*,*,c,0] = manuela_dark[*,*,c,0]
		out[*,*,c,1] = manuela_dark[*,*,c,1]		
		out[*,*,c,2] = manuela_dark[*,*,c,2]

		;; Display it
		display, histogram_clip(out[*,*,c,0],0.01)
		
		;; Histograms
		h0 = histogram(out[*,*,c,0], binsize=10, loc=x0)
		h1 = histogram(out[*,*,c,1], binsize=10, loc=x1)
		h2 = histogram(out[*,*,c,2], binsize=10, loc=x2)
					
		plot, x0, h0, xrange=[0,10000], title=string('Offset ',c)
		oplot, x1, h1
		oplot, x2, h2
		
		print, c, ' : ', median(out[*,*,c,0]), median(out[*,*,c,1]), median(out[*,*,c,2])
	endfor

	return, out
end




;; 
;;	
;;	Smooth out gain fluctuations by eliminating the cases of bad fitting 
;;	These give huge negatives in the data
;;
function process_steffen_gain, data
	print,'Processing gains:'
	s = size(data, /dim)
	;;print, 'In: ', s	

	out = fltarr(s)

	nfs = s[0]
	nss = s[1]
	ncell = s[2]
	ngain = s[3]

	gain = 1/data
	
	for c = 0, ncell-1 do begin
		display, histogram_clip(gain[*,*,c,1],0.05)

		h0 = histogram(gain[*,*,c,0], min=0, max=300, loc=x0)
		h1 = histogram(gain[*,*,c,1], min=0, max=300, loc=x1)
		h2 = histogram(gain[*,*,c,2], min=0, max=300, loc=x2)
				
		plot, x0, h0, xrange=[-50,300], title=string('Gain ',c)
		oplot, x1, h1
		oplot, x2, h2

		;; Ignore cell-to-cell variation for now - gain calibration seems noisy
		;; Gain is median value across whole module 
		for g=0, ngain-1 do begin
			gmed = median(data[*,*,c,g])
			gainval = 1.0/gmed
		
			out[*,*,c,g] = gainval	
		endfor

		;; Reference g[0] = 1
		g0 = median(out[*,*,c,0])
		for g=0, ngain-1 do begin
			gmed = median(out[*,*,c,g])
			gainval = gmed / g0
		
			out[*,*,c,g] = gainval	
		endfor
		
		
		print, c, ' : ', out[0,0,c,0], out[0,0,c,1], out[0,0,c,2]
	endfor
	

	;;s = size(out, /dim)
	;;print, 'Out: ', s	
	return, out

end



;; Nominal values:
;;		HG: Cf = 60fF		(1x)
;;		MG: Cf = 2 pF		(33x)
;;		LG: Cf = 10pF		(160x)
function set_nominal_gain, data

	print,'Setting nominal gains:'

	s = size(data, /dim)

	out = fltarr(s)

	nfs = s[0]
	nss = s[1]
	ncell = s[2]
	ngain = s[3]

	for c = 0, ncell-1 do begin
		out[*,*,c,0] = 1
		out[*,*,c,1] = 38
		out[*,*,c,2] = 180


		;; Overkill, but easy
		m0 = median(out[*,*,c,0])
		m1 = median(out[*,*,c,1])
		m2 = median(out[*,*,c,2])
		print, c, ' : ', m0, m1, m2

	endfor
	
	return, out
end


;; Nominal values:
;;		HG: Cf = 60fF		(1x)
;;		MG: Cf = 2 pF		(33x)
;;		LG: Cf = 10pF		(160x)
function process_pcdrs_gain, steffen_data, pcdrs_slope
	print,'Processing gains:'
	s = size(steffen_data, /dim)

	out = fltarr(s)

	nfs = s[0]
	nss = s[1]
	ncell = s[2]
	ngain = s[3]

	steffen_gain = 1/steffen_data
	steffen_gain /= median(steffen_gain[*,*,*,0])
	pcdrs_gain = 1/pcdrs_slope
	pcdrs_gain /= median(pcdrs_gain[*,*,*,0])
	

	for c = 0, ncell-1 do begin

		;; Pretty picture
		display, histogram_clip(pcdrs_gain[*,*,c,0],0.05)

	
		;; PCDRS slope is lower in higher gain modes --> it's the inverse
		pcdrs0_slope = pcdrs_slope[*,*,c,0]
		pcdrs1_slope = pcdrs_slope[*,*,c,1]
		
		sg0 = steffen_gain[*,*,c,0]
		sg1 = steffen_gain[*,*,c,1]
		sg2 = steffen_gain[*,*,c,2]
		
		
		;; Allow fluctuations in gain0
		;; Gain0 == 1 (on average)
		;g0 = median(pcdrs0_slope) / pcdrs0_slope
		g0 = pcdrs_gain[*,*,c,0]
		
		
		;; Gain0 is from pcdrs measurements; make it relative to gain0
		;g1 = median(pcdrs1_slope) / pcdrs1_slope
		;g1 /= median(pcdrs0_slope)		
		g1 = pcdrs_gain[*,*,c,1]
		
		
		;; We have to take Gain2 from Steffen's data
		g2 = steffen_gain[*,*,c,2]
		
		

		;; Copy results into output arrays
		out[*,*,c,0] = g0
		out[*,*,c,1] = g1
		out[*,*,c,2] = g2
		

	
		;; Display the results
		h0 = histogram(g0, min=0, max=300, loc=x0)
		h1 = histogram(g1, min=0, max=300, loc=x1)
		h2 = histogram(g2, min=0, max=300, loc=x2)

		plot, x0, h0, xrange=[0.01,300], title=string('Gain ',c)
		oplot, x1, h1
		oplot, x2, h2
		;oplot, xm, hm

		
		;; Ignore cell-to-cell variation for now - gain calibration seems noisy
		;; Gain is median value across whole module 
		;for g=0, ngain-1 do begin
		;	gmed = median(steffen_data[*,*,c,g])
		;	gainval = 1.0/gmed
		
		;	out[*,*,c,g] = gainval	
		;endfor

		
		m0 = median(out[*,*,c,0])
		m1 = median(out[*,*,c,1])
		m2 = median(out[*,*,c,2])
				
		
		print, c, ' : ', m0, m1, m2
		

	endfor
	

	return, out

end



;; 
;;	Gain switch threshold 
;;	Either take native value and reject outliers, or consider the width 'noise' and average it
;;	Need to take the low-side of the curve, not the median.
;;	Midpoint of two distributions probably the best for G1/G2 threshold
;;
function process_thresh, dark_thresh, g3=g3
	print,'Processing gain threshold:'
	s = size(dark_thresh, /dim)

	s_out = s
	s_out[3] = 3
	out = fltarr(s_out)
	
	nfs = s[0]
	nss = s[1]
	ncell = s[2]
	ngain = s[3]

	gain_mean = fltarr(ngain)
	gain_stddev = fltarr(ngain)

	for c = 0, ncell-1 do begin
		
		display, histogram_clip(dark_thresh[*,*,c,0],0.05)

		;; 	We use a 3-level output array
		;;	Just in case we later want to do +/- some value for gain1 stage
		t0 = 0
		
		;; First and second gain threshold comes from dark scans
		t1 = dark_thresh[*,*,c,0]
		t2 = dark_thresh[*,*,c,1]
		
		
		;; Copy into the arrays
		out[*,*,c,0] = t0
		out[*,*,c,1] = t1
		out[*,*,c,2] = t2


		;; Plot histograms
		h0 = histogram(out[*,*,c,0], binsize=10, loc=x0)
		h1 = histogram(out[*,*,c,1], binsize=10, loc=x1)
		h2 = histogram(out[*,*,c,2], binsize=10, loc=x2)

		plot, x0, h0, xrange=[0,10000], yrange=[0,max(h1)], title=string('Threshold ',c) 
		oplot, x1, h1
		oplot, x2, h2
	

		print, c, ' : ', median(out[*,*,c,0]), median(out[*,*,c,1]), median(out[*,*,c,2])
		
		
	endfor
	
	;; Set 3rd gain stage to off?
	if keyword_set(g3) then begin
		out[*,*,*,2] = 32000
	endif
	
	return, out
end



;; Obsolete - would need to be updated!!
pro plot_thresh_creep, data, title
	print,'Plotting threshold creep:'
	s = size(data, /dim)
	
	nfs = s[0]
	nss = s[1]
	ncell = s[2]
	ngain = s[3]


	img = fltarr(ncell, 1500)

	;; Plot skeleton
	p = plot(findgen(10000), /nodata)
	p.xrange=[0,15000]
	p.yrange=[0,20000]
	p.title=title
	p.xtitle='Threshold'

	offs = fltarr(ngain)

	for c = 0, ncell-1 do begin
		
		display, histogram_clip(data[*,*,c,0],0.05)
		
		for g=0, ngain-1 do begin
		
			h = histogram(data[*,*,c,g], min=0, max=15000, binsize=10, loc=x)
		
			;; Get rid of that spike
			if g eq 0 and ngain eq 2 then $
				h[where(x gt 8000)] = 0

			if g eq 1 and ngain eq 3 then $
				h[where(x gt 8000)] = 0
	
			;; Add to the image
			img[c,*] += h


			;; Plot it		
			yoffs = 600*(c)
			p0 = plot(x, h+yoffs, /over)

			;; Remember offset
			offs[g] = median(data[*,*,c,g])

		
		endfor
		
		print, c, ' : ', offs
		
	endfor


	x = indgen(ncell)
	y = 10*findgen(1500)
	i = image(img, x,y, aspect_ratio = ncell/15000./2, axis_style=1)
	i.rgb_table=54
	i.title=title
	i.xtitle = 'Cell number'
	i.ytitle = 'Threshold'
	
	
	
	p.save,title+'1.png'
	i.save,title+'2.png'
	;p.save,title+'1.pdf'
	;i.save,title+'2.pdf'


end


;; 
;;	Find bad pixels based on offset outliers
;;
function process_badpix_offs, data
	print,'Processing bad pixels (offset):'
	s = size(data, /dim)

	out = bytarr(s)
	
	nfs = s[0]
	nss = s[1]
	ncell = s[2]
	ngain = s[3]

	;; Loop over cells
	for c = 0, ncell-1 do begin
		nbad = intarr(ngain)
		
		;; Plot histograms
		h0 = histogram(data[*,*,c,0], binsize=10, loc=x0)
		h1 = histogram(data[*,*,c,1], binsize=10, loc=x1)
		h2 = histogram(data[*,*,c,2], binsize=10, loc=x2)
		plot, x0, h0, xrange=[0,10000]
		oplot, x1, h1
		oplot, x2, h2

		;; Loop over gains
		for g=0, ngain-1 do begin
			temp = data[*,*,c,g]
			m = median(temp)
			
			;; This is because large number of outliers can otherwise make sigma huge
			w = where(temp gt m-1000 AND temp lt m+1000)
			sigma = stddev(temp[w])
			m = median(temp[w])
			
			w = where(abs(temp-m) lt 3*sigma)
	        if w[0] eq -1 then begin
			    out[*,*,c,g] = 1
			    continue
			endif
			sigma = stddev(temp[w])
			m = median(temp[w])
			
			;; Change number here to alter sensitivity to bad pixels
			bad = abs(temp-m) gt 4*sigma
			
			;; Add to masks from lower gain stages
			if g ge 1 then begin
				bad = bad OR out[*,*,c,g-1]
			endif
			
			out[*,*,c,g] = bad
			nbad[g] = n_elements(where(bad ne 0))
		endfor
						
		display, out[*,*,c,0]
		perc = 100.*nbad[2]/n_elements(bad)
		print, c, ' : ', nbad[0], nbad[1], nbad[2],'    (', perc, ' %)'	
	endfor
	
	return, out
end



;; 
;;	Find bad pixels based on gain threshold outliers
;;
function process_badpix_gthresh, gmean, gthresh
	print,'Processing bad pixels (gainthresh):'
	s = size(gmean, /dim)

	out = bytarr(s)
	
	nfs = s[0]
	nss = s[1]
	ncell = s[2]
	ngain = s[3]

	for c = 0, ncell-1 do begin	
		nbad = intarr(ngain)
		
		for g=1, ngain-1 do begin
		
			badpix = bytarr(nfs, nss)
			
			temp_mean = gmean[*,*,c,g-1]
			temp_thresh = gthresh[*,*,c,g-1]
			
			
			;; bad pixels are where threshold is less than the mean
			w = where(temp_thresh lt temp_mean)
			if w[0] ne -1 then $
				badpix[w] = 1
			
			out[*,*,c,g] = badpix
			nbad[g] = n_elements(where(badpix ne 0))
		endfor
						
		display, out[*,*,c,1]
		perc = 100.*nbad[1]/n_elements(badpix)
		print, c, ' : ', nbad[0], nbad[1], nbad[2],'    (', perc, ' %)'	
	endfor
	
	return, out
end


function process_badpix_gain, gain
	print,'Processing bad pixels (bad gain values):'
	s = size(gain, /dim)

	out = bytarr(s)
	
	nfs = s[0]
	nss = s[1]
	ncell = s[2]
	ngain = s[3]

	for c = 0, ncell-1 do begin	
		nbad = intarr(ngain)
		
		for g=0, ngain-1 do begin
		
			temp_gain = gain[*,*,c,g]
			temp_badpix = bytarr(nfs, nss)

			mg = median(temp_gain)			
			sg = stddev(temp_gain)

			;; First filter really bad outliers: a few bad modules can make stddev large
			w_bad = where(abs(temp_gain-mg) gt 3*sg OR temp_gain lt 0 OR temp_gain gt 1000, complement=w_in)
			
			mg = median(temp_gain[w_in])
			sg = stddev(temp_gain[w_in])
			
			;; bad pixels are where the gain is out of sensible bounds
			w = where(abs(temp_gain-mg) gt 5*sg)
			if w[0] ne -1 then $
				temp_badpix[w] = 1
			
			;; Accumulate bad pixels from previous gain stages
			if g ge 1 then begin
				temp_badpix = temp_badpix OR out[*,*,c,g-1]
			endif

			
			out[*,*,c,g] = temp_badpix
			nbad[g] = n_elements(where(temp_badpix ne 0))
		endfor
						
		display, out[*,*,c,1]
		perc = 100.*nbad[1]/n_elements(temp_badpix)
		print, c, ' : ', nbad[0], nbad[1], nbad[2],'    (', perc, ' %)'	
	endfor
	
	return, out
end

;;
;;	Kill entire ASICs that have many dodgy pixels 
;;	The rest are probably bad too
;;
function suppress_dodgy_asics, badpix_in
	print,'Suppressing dodgy ASICS in module:'
	s = size(badpix_in, /dim)

	badpix_out = badpix_in
	
	nfs = s[0]
	nss = s[1]
	ncell = s[2]
	ngain = s[3]
	
	asicsfs = 8
	asicsss = 8
	asic_step_fs = nfs / asicsfs
	asic_step_ss = nss / asicsss

	;; Step 1
	;; Look for ASICs with a high number of bad pixels
	;; If more than 50% of pixels in an ASIC are bad the others are probably dodgy too
	;; Label the whole ASIC as dead
	
	;; Memory cell loop
	for c = 0, ncell-1 do begin	
		nbad_count = intarr(ngain)

		;; Gain stage loop
		for g=0, ngain-1 do begin

			;; Loop over sub-module ASICs
			for a1 = 0, asicsss - 1 do begin
				for a0 = 0, asicsfs - 1 do begin
					sslo = a1*asic_step_ss
					sshi = sslo + asic_step_ss - 1
					fslo = a0*asic_step_fs
					fshi = a0*asic_step_fs + asic_step_fs -1
					
					temp = badpix_in[fslo:fshi, sslo:sshi, c, g]
					
					nbad = n_elements(where(temp ne 0))
					
					if nbad gt 0.5*n_elements(temp) then begin
						badpix_out[fslo:fshi, sslo:sshi, c, g] = 1
					endif
					
				endfor
			endfor
			;; End ASIC loop			

			nbad_count[g] = n_elements(where(badpix_out[*,*,c,g]) ne 0)
		endfor

		;img = total(badpix_out[*,*,c,*], 4)
		img = max(badpix_out[*,*,c,*], dim=4)
		display, reform(img)
		perc = 100.*n_elements(where(img ne 0))/n_elements(img)
		print, c, ' : ', nbad_count[0], nbad_count[1], nbad_count[2],'    (', perc, ' %)'	

	endfor
	

	;; Step #2
	;; If the ASIC is bad for most of the memory cells, declare the whole thing bad
	
	;; Loop over sub-module ASICs
	for a1 = 0, asicsss - 1 do begin
		for a0 = 0, asicsfs - 1 do begin
			sslo = a1*asic_step_ss
			sshi = sslo + asic_step_ss - 1
			fslo = a0*asic_step_fs
			fshi = a0*asic_step_fs + asic_step_fs -1
			
			
			temp1 = badpix_in[fslo:fshi, sslo:sshi, *, *]
			
			;; Call it bad if any of the gain stages are dodgy
			temp2 = max(temp1, dim=4)
			
			;; Number of pixels with bad pixels
			nbad = total(temp2)
			
			;; Call it bad all the time if it is bad more than 50% of the time
			if nbad ge 0.5*n_elements(temp2) then begin
				badpix_out[fslo:fshi, sslo:sshi, *, *] = 1
			endif
			
		endfor
	endfor


	
	img = max(badpix_out, dim=4)
	img = max(img, dim=3)
	display, reform(img)
	perc = 100.*n_elements(where(img ne 0))/n_elements(img)
	print, c, ' : ', nbad_count[0], nbad_count[1], nbad_count[2],'    (', perc, ' %)'	



	return, badpix_out
end




;;
;; Plot a summary of the results for quality checks
;;
function plot_cell_summary, win, title, data, layout=layout


	s = size(data, /dim)
	
	nfs = s[0]
	nss = s[1]
	ncell = s[2]
	ngain = s[3]

	img = fltarr(ncell, 1500)

	for c = 0, ncell-1 do begin
		
		;display, histogram_clip(data[*,*,c,0],0.05)
		
		for g=0, ngain-1 do begin
		
			if n_elements(where(data[*,*,c,g] eq 0)) eq nfs*nss then continue
		
			h = histogram(data[*,*,c,g], min=0, max=15000, binsize=10, loc=x)
		
			img[c,*] += h
		
		endfor
		
	endfor

	;;; Display it
	x = indgen(ncell)
	y = 10*findgen(1500)
	win.window.setCurrent
	i = image(img, x,y, aspect_ratio = ncell/15000./2, axis_style=1, /current, layout=layout)
	i.rgb_table=54
	i.title=title
	i.xtitle = 'Cell number'
	i.ytitle = 'Value'
	i.ytickunits="Numeric"
	
	return, i
	
end


function plot_badpix, win, title, data, layout=layout
	

	s = size(data, /dim)
	
	nfs = s[0]
	nss = s[1]
	ncell = s[2]
	ngain = s[3]

	;; Try to ignore completely dead modules or gain stages
	temp = data 
	for c = 0, ncell-1 do begin
		for g=0, ngain-1 do begin
			if n_elements(where(temp[*,*,c,g] eq 1)) eq nfs*nss then begin
				temp[*,*,c,g] = 0
			endif
		endfor
	endfor
			


	;; Squash the badpix array
	img = max(temp, dim=4)
	img = max(img, dim=3)
	
	;; Rotate it
	img = rotate(img, 3)
	
	
	;; Display it
	win.window.setCurrent
	i = image(img, axis_style=1, /current, layout=layout)
	i.max_value=1
	i.min_value=0
	i.rgb_table=54
	i.title = title
	
	return, i

end
	



;;
;; Code to process one module
;;
pro process_module, manuela_dark_file, file_format, module_name, g3=g3, outdir=outdir
			

	;;
	;;	File name and HDF5 field manipulation
	;;
	
	;; Output directory
	if n_elements(outdir) eq 0 then begin
		outdir = 'calib'
	endif

	;; Cheetah output file name
	;; AGIPD00 --> Cheetah-AGIPD00-calib.h5
	outfile = 'Cheetah-'+module_name+'-calib.h5'
	outfile = outdir + outfile


	;; Manuelas HDF5 field names
	;; AGIPD00 --> /channel00
	manuela_h5_field = module_name.replace('AGIPD', '/channel')


		
	;; Version specific stuff		
	if file_format eq 'XFEL2012' then begin
		manuela_dark_file = ['dark_AGIPD00_xfel', 'dark_AGIPD01_xfel', 'dark_AGIPD02_xfel', 'dark_AGIPD03_xfel', $
							'dark_AGIPD04_xfel', 'dark_AGIPD05_xfel', 'dark_AGIPD06_xfel', 'dark_AGIPD07_xfel', $
							'dark_AGIPD08_xfel', 'dark_AGIPD09_xfel', 'dark_AGIPD10_xfel', 'dark_AGIPD11_xfel', $
							'dark_AGIPD12_xfel', 'dark_AGIPD13_xfel', 'dark_AGIPD14_xfel', 'dark_AGIPD15_xfel' ]
	endif
				

	;; Sanity checking
	print, '********************************  ', module_name, '  ********************************'
	print, 'Processing: ', module_name
	print, '    manuela_dark_file:    ', manuela_dark_file

	print, '    manuela_h5_field:     ', manuela_h5_field
	print, '    outfile:              ', outfile
	print, '---'



	if not keyword_set(g3) then $
		g3 = 0



	;;
	;;	File reading section
	;;

	;; Read Manuela's dark calibration data
	print,'Reading: ', manuela_dark_file, '    h5_block=', manuela_h5_field
	m_dark_thresh = h5_getdata(manuela_dark_file, manuela_h5_field+'/threshold')
	m_dark_offset = h5_getdata(manuela_dark_file, manuela_h5_field+'/offset')
	m_dark_gainlevel_mean = h5_getdata(manuela_dark_file, manuela_h5_field+'/gainlevel_mean')
	m_dark_stddev = h5_getdata(manuela_dark_file, manuela_h5_field+'/stddev')
	;;m_dark_thresh = read_h5(manuela_dark_file, field=manuela_h5_field+'/threshold')
	;;m_dark_offset = read_h5(manuela_dark_file, field=manuela_h5_field+'/offset')
	;;m_dark_gainlevel_mean = read_h5(manuela_dark_file, field=manuela_h5_field+'/gainlevel_mean')
	;;m_dark_stddev = read_h5(manuela_dark_file, field=manuela_h5_field+'/stddev')

	
	
	;; Transpose from FSDS layout if we are reading a *_agipd.h5 input file
	;;if 1 then begin
	if manuela_dark_file.endswith('agipd.h5') then begin
		m_dark_thresh = transpose(m_dark_thresh, [1,0,2,3])
		m_dark_offset = transpose(m_dark_offset, [1,0,2,3])
		m_dark_gainlevel_mean = transpose(m_dark_gainlevel_mean, [1,0,2,3])
		m_dark_stddev = transpose(m_dark_stddev, [1,0,2,3])
		
		m_dark_thresh = reverse(m_dark_thresh,2)
		m_dark_offset = reverse(m_dark_offset,2)
		m_dark_gainlevel_mean = reverse(m_dark_gainlevel_mean,2)
		m_dark_stddev = reverse(m_dark_stddev,2)
	endif
	

	
	;;
	;; Do the actual processing
	;; 
	
	;; Offsets read by Cheetah are currently:  3 x 30 x 512 x 128 of type int16_t
	offset_out = process_offset(m_dark_offset)
	offset_out = fix(offset_out)


	;; Gains will be the median of module for that memory cell
	gain_out = set_nominal_gain(m_dark_offset)
	gain_out = float(gain_out)



	;; Gain thresholds from Manuela
	thresh_out = process_thresh(m_dark_thresh, g3=g3)
	thresh_out = fix(thresh_out)


	;; Interesting gain threshold plots
	;plot_thresh_creep, m_dark_thresh, 'GainThreshold'
	;plot_thresh_creep, m_dark_gainlevel_mean, 'GainLevelMean'


	;; Bad pixels !!
	badpix_out1 = process_badpix_offs(offset_out)
	badpix_out3 = process_badpix_gthresh(m_dark_gainlevel_mean, m_dark_thresh)
	badpix_out = badpix_out1 OR badpix_out3
	badpix_out = suppress_dodgy_asics(badpix_out)
	badpix_out = byte(badpix_out)
	
	

	
	;;
	;; Save result in Cheetah format
	;;
	print,'Writing: ', outfile
	h5_putdata, outfile, 'AnalogOffset', offset_out
	spawn, 'chmod u+w '+outfile					;; <-- Needed on the EuXFEL scratch partition which defaults to read only
	h5_putdata, outfile, 'RelativeGain', gain_out
	h5_putdata, outfile, 'DigitalGainLevel', thresh_out
	h5_putdata, outfile, 'Badpixel', badpix_out



	;;
	;;	Create some summary plots
	;;
	if 1 then begin
		win = window(window_title = module_name, name = module_name, dimensions = [600, 1000], /no_toolbar) 
		p1 = plot_cell_summary(win, module_name+' - Offset', offset_out, layout=[1,3,1])
		p2 = plot_cell_summary(win, module_name+' - Thresh', thresh_out[*,*,*,1:*], layout=[1,3,2])
		p3 = plot_badpix(win, module_name+' - Badpix (flattened)', badpix_out, layout=[1,3,3])
		win.save, outdir + module_name + '.png'
	endif
	

	;;
	;; Save for Valerio
	;;
	save_for_Valerio = 0
	if(save_for_Valerio) then begin
		outfile2 = 'calib/Cheetah-calib-combined.h5'
		print,'Writing: ', outfile2
	
		if manuela_pcdrs_field eq '/channel00' then begin 
			fid = H5F_CREATE(outfile2)  
			; spawn, 'chmod u+w '+outfile2		;; <-- Needed on the EuXFEL scratch partition which defaults to read only
		endif $
		else begin
			fid = H5F_OPEN(outfile2, /write) 
		endelse
		group_id = H5G_CREATE(fid, manuela_h5_field)
		dim = size(offset_out,/dimensions)

		;; offset out
		datatype_id = H5T_IDL_CREATE(offset_out) 
		dataspace_id = H5S_CREATE_SIMPLE(dim) 
		dataset_id = H5D_CREATE(fid,manuela_h5_field+'/AnalogOffset',datatype_id,dataspace_id) 
		H5D_WRITE,dataset_id,offset_out 
		H5D_CLOSE,dataset_id   
		H5S_CLOSE,dataspace_id 
		H5T_CLOSE,datatype_id 

		;; gain_out
		datatype_id = H5T_IDL_CREATE(gain_out) 
		dataspace_id = H5S_CREATE_SIMPLE(dim) 
		dataset_id = H5D_CREATE(fid,manuela_h5_field+'/RelativeGain',datatype_id,dataspace_id) 
		H5D_WRITE,dataset_id,gain_out 
		H5D_CLOSE,dataset_id   
		H5S_CLOSE,dataspace_id 
		H5T_CLOSE,datatype_id 

		;; thresh_out
		datatype_id = H5T_IDL_CREATE(thresh_out) 
		dataspace_id = H5S_CREATE_SIMPLE(dim) 
		dataset_id = H5D_CREATE(fid,manuela_h5_field+'/DigitalGainLevel',datatype_id,dataspace_id) 
		H5D_WRITE,dataset_id,thresh_out 
		H5D_CLOSE,dataset_id   
		H5S_CLOSE,dataspace_id 
		H5T_CLOSE,datatype_id 

		;; badpix_out
		datatype_id = H5T_IDL_CREATE(badpix_out) 
		dataspace_id = H5S_CREATE_SIMPLE(dim) 
		dataset_id = H5D_CREATE(fid,manuela_h5_field+'/Badpixel',datatype_id,dataspace_id) 
		H5D_WRITE,dataset_id,badpix_out 
		H5D_CLOSE,dataset_id   
		H5S_CLOSE,dataspace_id 
		H5T_CLOSE,datatype_id 	
	
		H5G_CLOSE,group_id
		H5F_CLOSE,fid 
	endif
	
end





;;
;;	Process all modules
;;	From here on in changes should only occur with changes in file format
;; 	Changes in file name are all done one up from this layer
;;

pro quick_agipd_calib, manuela_dark_file, $
				test=test, g3=g3, outdir=outdir

	
	;; Names of modules to process
	modules_to_process = [	'AGIPD00', 'AGIPD01', 'AGIPD02', 'AGIPD03', $
							'AGIPD04', 'AGIPD05', 'AGIPD06', 'AGIPD07', $
							'AGIPD08', 'AGIPD09', 'AGIPD10', 'AGIPD11', $
							'AGIPD12', 'AGIPD13', 'AGIPD14', 'AGIPD15' ]

	;; EuXFEL HDF5 file labels things differently, these labels can not be easily derived
	steffen_h5_field = ['/Q1M1', '/Q1M2', '/Q1M3', '/Q1M4', $
						'/Q2M1', '/Q2M2', '/Q2M3', '/Q2M4', $
						'/Q3M1', '/Q3M2', '/Q3M3', '/Q3M4', $
						'/Q4M1', '/Q4M2', '/Q4M3', '/Q4M4' ]

	print, 'Modules to process:'
	print, '    ', modules_to_process

	print, 'Files to process:'
	print, '    manuela_dark_file =    ', manuela_dark_file


	;; Allow for changing file formats
	file_format = 'XFEL2066'
	print, 'file_format = ', file_format

	;; Output directory
	if n_elements(outdir) eq 0 then begin
		outdir = 'calib'
	endif


	;print, 'Continue?'
	;stop

	;;
	;;	Check input files exist
	;;
	if not file_test(manuela_dark_file) then begin
		print,'Error: can not find file'
		print, manuela_dark_file
		return
	endif

	print, '(OK)'
	

	window, 0, xsize=800,ysize=600


	;; Loop through all modules
	for i=0, n_elements(modules_to_process)-1 do begin
	
		process_module, manuela_dark_file, file_format, modules_to_process[i], g3=1, outdir=outdir
		
		if keyword_set(test) then $
			stop
			
	endfor

	; PRINT, FORMAT='(I08)', 300  produces the following output: 00000300
	; str = string(300, format='(I08)') does this into a string


	print,'Done (clean exit)'


end





