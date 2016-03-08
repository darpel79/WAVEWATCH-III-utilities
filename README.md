# WAVEWATCH-III-utilities

Some program helping in the use of WW3.
Brief instructions are written within the files.

- downl_cfsr:
    Program to download cfsr or cfsv2 data (grib2) from NOAA website,
    extract a subgrid and convert to netcdf.

- ww3_make_dir:
    Program to make diretories with year and month (e.g., 201104)
    and link the wind.nc files in the CFSR directory to the new
    directories. 

- ww3_create_mrun:
    Program to prepare the existent directory for the execution of WW3:
    - link file.ww3
    - copy and set up with the right start/end date ww3_shel.inp

- ww3_seq_run:
    Program to run sequential simulation with WW3.
    In this version a run should be already in execution.

- ww3_del_time:
    Program to delete the last time of the monthly ounf.nc.

- monthly_mean:
    Program to calculate montlhy mean of a chosen parameter.



    
