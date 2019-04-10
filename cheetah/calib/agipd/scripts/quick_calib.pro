;;
;; Quick version of the AGIPD calibration script
;; Works only off dark run data
;; Might not be as accurate, but probably good enough to get things going
;;

;;
;;	User interaction
;;
selected_dark = dialog_pickfile()


;; Failing to exit otherwise results in deletion of the whole directory 
if selected_dark eq '' then return


;; Directory for output data
outdir = file_basename(file_dirname(selected_dark))+'/'


;;
;; Files containing calibration data
;;
fsds_dark_file = selected_dark


;;
;; Output directory
;;
if not file_test(outdir) then $
	spawn, 'mkdir '+outdir $
else begin
    spawn, 'rm -rf '+outdir+'/*'
endelse
    


;; Bit that does the processing
quick_agipd_calib, fsds_dark_file, outdir=outdir



end
