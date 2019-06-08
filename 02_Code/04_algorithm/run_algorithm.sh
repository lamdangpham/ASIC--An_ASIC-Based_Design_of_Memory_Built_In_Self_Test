#!/bin/bash

marchc=$1;
apnpsf=$2;
marcha=$3;
marchb=$4;
memnum=$5;


rm ../02_design/*

## copy marchc if we request
if [ $marchc = 1 ] ; then
    echo "copy marchc"
    cd 05_marchc/
    cp ./* ./../../02_design/
    cd ..
fi

## copy apnpsf if we request
if [ $apnpsf = 1 ] ; then
    echo "copy apnpsf"
    cd 06_apnpsf/
    cp ./* ./../../02_design/
    cd ..
fi

# copy marcha if we request
if [ $marcha = 1 ] ; then
    echo "copy marcha"
    cd 07_marcha/
    cp ./* ./../../02_design/
    cd ..
fi

## copy marchb if we request
#if [ $marchb = 1 ] ; then
#    echo "copy marchb"
#    cd 0x_marchb/
#    cp ./* ./../../02_design/
#    cd ..
#fi

## create controller block
cd 01_controller/
echo "copy controller"
/usr/bin/perl gen_controller.pl $marchc $apnpsf $marcha $marchb
cp controller.v ../../02_design
cd ..

## create mbist_decoder
cd 02_decoder/
echo "copy decoder"
/usr/bin/perl gen_mbist_decoder.pl $marchc $apnpsf $marcha $marchb
cp mbist_decoder.v ../../02_design
cd ..


## create mbist_demux
cd 03_demux/
echo "copy mbist_demux"
/usr/bin/perl gen_mbist_demux.pl $memnum
cp mbist_mux_demux.v ../../02_design
cd ..

## create mbist block
cd 04_mbist/
echo "copy mbist"
/usr/bin/perl gen_mbist.pl $marchc $apnpsf $marcha $marchb $memnum
cp mbist.v ../../02_design
cd ..
