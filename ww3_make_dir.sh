#!/bin/bash
# ww3_make_dir.sh  version 1.01

  #********************************************************************#
  #                                                                    #
  # Program to make diretories with year and month (e.g., 201104)      #
  # and link the wind.nc files in the CFSR directory to the new        #
  # directories.                                                       #
  #                                                                    #
  #                                              Author: Dario Pelli   #
  # Last update: 12-Feb-2016                                           #
  #                                                                    #
  #********************************************************************#

  echo -n "Write the initial date (yyyy): "
  # The option -n kill the option newline 

  # Read the input from screen
  read syear

  echo -n "Write the end date (yyyy mm): "
  read eyear emonth

  # define files and directories
  dir_WEA="$HOME/WEA_WW3/"             # work directory
  dir_CFSR="$HOME/WEA_WW3/CFSR/"       # wind input directory
  file_prnc="wind_cfsr.nc"             # monthly wind input file

  ## start LOOP

  for ((year=syear; year <= eyear; year++))  # year counter
  do

     for month in 01 02 03 04 05 06 07 08 09 10 11 12  # month counter
     do

     # define variables and files
     ym=$year$month                 # directory name
     file_nc="wnd10m.med.${ym}.nc"  # original wind input file

     if [ -e ${dir_CFSR}${file_nc} ]
     then
       mkdir ${dir_WEA}${ym}
       ln -s ${dir_CFSR}${file_nc} ${dir_WEA}${ym}/${file_prnc}
     fi

     # start if the date is equal to the initial date
     if [ "$year" -eq "$eyear" ] && [ "$month" -eq "$emonth" ]
     then
       break
     fi

     done
  done

  ## end LOOP

  exit
