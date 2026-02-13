#!/bin/bash


# echo Payload name?
# read varname

varname="rtm_prod2"
mkdir -p bram_dts
mkdir -p payloads
mkdir -p ./device-tree-xlnx
 # PWD here requires script be run from directory
echo $PWD
cp ../project_1/project_1.runs/impl_1/main.bin ./bram.bit.bin
cp ../project_1/main.xsa .
xsct get_dtbo.tcl
cd bram_dts/
dtc -@ -O dtb -o pl.dtbo pl.dtsi
cd ../
cp bram_dts/pl.dtbo bram.dtbo

mkdir -p payloads/$varname
cp bram.bit.bin bram.dtbo shell.json payloads/$varname/
# cp ${PWD##*/}.runs/impl_1/debug_nets.ltx payloads/$varname/



