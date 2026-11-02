#!/bin/bash
cd ../tclDev/
path=$1
echo Fetching ILA data
vivado -nojou -nolog -mode batch -source ila.tcl -quiet -tclargs $path