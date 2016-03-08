#!/bin/bash
# monthly_mean.sh version 1.01

  #********************************************************************#
  #                                                                    #
  # Program to calculate montlhy mean of a chosen parameter            #
  #                                                                    #
  #                                                                    #
  #                                              Author: Dario Pelli   #
  # Last update: 22-Feb-2016                                           #
  #                                                                    #
  #********************************************************************#

  echo -n "Write the initial date (yyyy mm): "
  # The option -n kill the option newline 

  # Read the input from screen
  read syear smonth

  echo -n "Write the end date (yyyy mm): "
  read eyear emonth

  # Define variables and direcories
  var1="cge"
  main_dir="/mnt/STORAGE/WEA_WW3/work"     # work directory
  #input_dir="${main_dir}input_files/"     # input files directory
  
  cd ${main_dir}

 ## LOOP

  for ((year=syear; year <= eyear; year++))  # year counter
   do
     for month in $(seq -f "%02g" 01 12)    # month counter
     do
       
       # Define the file name of each simulation
       yyyymm=$year$month
       fileIn=ww3.${yyyymm}.nc
       fileOut=ww3.${yyyymm}_${var1}.nc
       
       # start if the date is equal to the initial date
       if [ $year -eq $syear ] && [ $month -ge $smonth ] || [ $year -gt $syear ]   
       then 
    
         # calculate the mean of the selected variable with NCO
         ncra -d time,0,,1 -v ${var1} ${fileIn} ${fileOut}

         echo -n "file ${fileIn} processed"    
    
       fi

       # break the loop if the ending year and month are reached
       if [ "$year" -eq "$eyear" ] && [ "$month" -eq "$emonth" ]
       then
         break
       fi
     
     done
  done
  
  exit
