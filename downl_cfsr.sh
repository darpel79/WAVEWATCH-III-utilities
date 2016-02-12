#!/bin/bash
# downl_cfsr.sh  version 1.01

  #********************************************************************#
  #                                                                    #
  # Program to download cfsr or cfsv2 data (grib2) from NOAA website,  #
  # extract a subgrid and convert to netcdf.                           #
  #                                                                    #
  # USE:                                                               #
  # - select variable par and check the subregion info                 #
  # - select data source, cfsr (1979-2009) or cfsv2 (from April 2011   #
  #   to July 2014                                                     #
  #                                                                    #
  #                                              Author: Dario Pelli   #
  # Last update: 02-Feb-2016                                            #
  #                                                                    #
  #********************************************************************#


  # uncomment the follow line for cfsr
  # dir_cfsr=wget "ftp://nomads.ncdc.noaa.gov/CFSR/HP_time_series"

  # uncomment the follow line for cfsv2
  dir_cfsr="http://nomads.ncdc.noaa.gov/thredds/fileServer/modeldata/\
cfsv2_analysis_timeseries"

  par="wnd10m"  # parameter name

  echo -n "Write the initial date (yyyy): "
  # The option -n kill the option newline 

  # Read the input from screen
  read syear 

  echo -n "Write the end date (yyyy mm): "
  read eyear emonth

  # download directory 
  dir_dwl="$HOME/WEA_WW3/CFSR"

  #####################################################################
  # Set a subregion                                                   #
  #####################################################################

  # select the name for the subregion
  reg="med"

  # the dimension of the subgrid is chosen by the follow variables
  lon_min=-9
  lon_max=40
  lat_min=28
  lat_max=48

  ## start LOOP

  for ((year=syear; year <= eyear; year++))  # year counter
  do

     for month in 01 02 03 04 05 06 07 08 09 10 11 12  # month counter
     do

  # defining variables and files
     ym=$year$month                  # directory name
     file_grib2="${par}.gdas.${ym}"
     file_reg="${par}.${reg}.${ym}"

     # download the file
     wget "${dir_cfsr}/${year}/${ym}/${file_grib2}.grib2"

     ## transform file.grib2 to file.nc

     if [ -e ${file_grib2}.grib2 ]
     then
         mv -f ${file_grib2}.grib2 ${file_grib2}.grb2

         wgrib2 ${file_grib2}.grb2 -small_grib ${lon_min}:${lon_max} \
                ${lat_min}:${lat_max} ${file_reg}.grb2
         # command to cut a subregion

         # conversion from *.grb2 to *.nc 
         wgrib2 ${file_reg}.grb2 -netcdf ${file_reg}.nc
         ncks -O -a -h -4 -L9 ${file_reg}.nc ${file_reg}.nc
     fi

     # remove useless files if they exist
     if [ -e ${file_grib2}.grb2 ]
     then
       rm ${file_grib2}.grb2
     fi

     if [ -e ${file_reg}.grb2 ]
     then
       rm ${file_reg}.grb2
     fi

     # break the loop if the ending year and month are reached
     if [ "$year" -eq "$eyear" ] && [ "$month" -eq "$emonth" ]
     then
             break
     fi

     done
  done

  ## end LOOP

  exit
