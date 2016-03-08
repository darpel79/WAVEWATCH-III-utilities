#!/bin/bash
# ww3_del_time.sh version 1.01

  #********************************************************************#
  #                                                                    #
  # Program to delete the last time of the monthly ounf.nc             #
  #                                                                    #
  # Use:                                                               #
  # - define the directories                                           #
  #                                                                    #
  #                                              Author: Dario Pelli   #
  # Last update: 19-Feb-2016                                           #
  #                                                                    #
  #********************************************************************#

  echo -n "Write the initial date (yyyy mm): "
  # The option -n kill the option newline 

  # Read the input from screen
  read syear smonth

  echo -n "Write the end date (yyyy mm): "
  read eyear emonth

  # Define variables and direcories
  main_dir="/mnt/STORAGE/WEA_WW3/work/"     # work directory
  input_dir="/mnt/STORAGE/WEA_WW3/NetCDF_files/"
  
  cd ${main_dir}

 ## LOOP

  for ((year=syear; year <= eyear; year++))  # year counter
   do
     for month in $(seq -f "%02g" 01 12)    # month counter
     do
       
       # Define the file name of each simulation
       yyyymm=$year$month
       file=ww3.${yyyymm}.nc
       
       # start if the date is equal to the initial date
       if [ $year -eq $syear ] && [ $month -ge $smonth ] || [ $year -gt $syear ]   
       then 

         # delete the last time
         ncks -d time,,-1,1 ${input_dir}${file} ${file} 
         
         echo -n "file ${file} processed"    
    
       fi

       # break the loop if the ending year and month are reached
       if [ "$year" -eq "$eyear" ] && [ "$month" -eq "$emonth" ]
       then
         break
       fi
     
     done
  done

  exit
