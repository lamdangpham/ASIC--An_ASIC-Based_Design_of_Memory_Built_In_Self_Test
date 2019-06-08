#!/bin/bash

## FOR MEMORY
data_width=$1;
addr_width=$2;
wrong_addr=$3;
issue_code=$4;
capacity=$5; 

## FOR MBIST       
is_waveform=$6;
memtype=$7;
operation=$8;
memory_sel=$9;

## 00. make empty "run" folder
rm  ./run/*

## update 13/08 -- update the design according to the algorithm
cd ../04_algorithm/
/usr/bin/perl run_algorithm.pl
cd ../03_simulate/



### 01. Copy RLT code to "run" folder
cp -rf ./../02_design/* ./run/               #update 13/08

### 02. Generate Faul Memory
/usr/bin/perl ./../01_script/02_Fault_Mem/gen_fault_mem.pl  $data_width $addr_width $wrong_addr $issue_code $capacity

#### 03. Generate Testbench to be compliant fault memory
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n"
echo "is_waveform = $is_waveform | memtype = $memtype | operation = $operation"
echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"
/usr/bin/perl ./../01_script/01_Testbench/gen_testbench.pl $is_waveform $memtype $operation $memory_sel 

##### =================== 03 - Run simulation =================== ###
cd run
    if [ $is_waveform = "true" ] ; then 
        echo "xxxxxxxxxx_is_waveform_xxxxxxxxxx"
        vcs -R +v2k -debug_all *.v  -l vcs_$issue_code.log 
        grep MEMORY IS FAILED AT ADDRESS vcs_$issue_code.log >> ../address.log
        sort address.log | tee address_sort.log
    else
        echo "xxxxxxxxxx_no_waveform_xxxxxxxxxx"
        vcs -R +v2k  *.v  -l vcs_$issue_code.log 
       grep ADDRESS vcs_$issue_code.log >> ../address.log
       sort address.log | tee address_sort.log
    fi
cd ..
##/usr/bin/perl collect_report.pl $run_option $issue_code $address
