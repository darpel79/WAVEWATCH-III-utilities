#!/bin/bash
# ww3_create_mrun.sh  Version 1.04

  #********************************************************************#
  #                                                                    #
  # Program to prepare the existent directory for the execution of WW3:#
  # - link file.ww3                                                    #
  # - copy and set up with the right start/end date ww3_shel.inp       #
  # Use:                                                               #
  # - set the variable "main_dir" and "input_dir" in the code          #
  # - run the program and write the selected start/end date            #
  #                                                                    #
  #                                              Author: Dario Pelli   #
  # Last update: 26-Jan-2016                                           #
  #                                                                    #
  #********************************************************************#

  echo -n "Write the initial date (yyyy mm): "
  # The option -n kill the option newline 

  # Read the input from screen
  read syear smonth

  echo -n "Write the end date (yyyy mm): "
  read eyear emonth

  # Define variables and direcories
  main_dir="$HOME/WEA_WW3/"            # work directory
  input_dir="${main_dir}input_files/"  # input files directory
  
 ## LOOP

 for ((year=syear; year <= eyear; year++))  # year counter
  do
     for month in $(seq -f "%02g" 01 12)    # month counter
     do
       
       # Define the directory name of each simulation
       yyyymm=$year$month
       let "endmm = $((10#$month + 1))"  # A number in the format [00-09] 
                                         # is interprered in octal base
       if [ $endmm -eq 13 ]
       then
         endmm=1
       fi       

       endmm=$(printf "%02g" $endmm)

       # start if the date is equal to the initial date
       if [ $year -eq $syear ] && [ $month -ge $smonth ] || [ $year -gt $syear ]   
       then 

         cd ${main_dir}${yyyymm}

         # Link or copy input files
         ln -s ${input_dir}ST4TABUHF2.bin    ST4TABUHF2.bin
         ln -s ${input_dir}mapsta.ww3        mapsta.ww3
         ln -s ${input_dir}mask.ww3          mask.ww3
         ln -s ${input_dir}mod_def.ww3       mod_def.ww3
         ln -s ${input_dir}ww3_prnc_cfsr.inp ww3_prnc.inp

         cp ${input_dir}ww3_shel_short.inp   ww3_shel.inp

         # Write the right start/end date (yyyymmdd) in ww3_shel.inp
         sed s/startyyyymmdd/${yyyymm}01/g ww3_shel.inp > tmp && mv tmp ww3_shel.inp
         if [ $endmm -eq 01 ]
         then 
           let "newyear = $year + 1"
           sed s/endyyyymmdd/${newyear}${endmm}01/g ww3_shel.inp > tmp && mv tmp ww3_shel.inp
         else
           sed s/endyyyymmdd/${year}${endmm}01/g ww3_shel.inp > tmp && mv tmp ww3_shel.inp
         fi

       fi

       # break the loop if the ending year and month are reached
       if [ "$year" -eq "$eyear" ] && [ "$month" -eq "$emonth" ]
       then
         break
       fi

    done
  done

## END LOOP

  exit
