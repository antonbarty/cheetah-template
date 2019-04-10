

;;
;;	User interaction
;;
selected_dark = dialog_pickfile()

;; Directory for output data
outdir = file_basename(file_dirname(selected_dark))+'/'

;;
;; Files containing calibration data
;;
fsds_dark_file = selected_dark
;fsds_dark_file = 'fsds/dark/r0092-r0091-r0089/dark_joined_constants_xfel.h5'
fsds_pcdrs_file = 'fsds/pcdrs/r0122-r0123-r0124-r0125-r0126-r0127-r0128-r0129/pcdrs_joined_constants_xfel.h5'
steffen_base_store = 'haufs/base/agipd_base_store_64_r0820.h5'
steffen_offset_store = 'haufs/dark/agipd_offset_store_r0215_r0216_r0217.h5'

;; Output directory
;outdir = 'calib-dk0092/'
if not file_test(outdir) then $
	spawn, 'mkdir '+outdir


;; Bit that does the processing
process_agipd_calib, steffen_base_store, steffen_offset_store, fsds_dark_file, fsds_pcdrs_file, outdir=outdir, g3=1



