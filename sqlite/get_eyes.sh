#!/bin/bash
cd ../tclDev/
ber=${1:-1e-8}
path=$2
vivado -nojou -nolog -mode batch -source eye.tcl -tclargs $ber $path
mv Scan_* ../sqlite/live_tests/

cd ../rtmMC/
python3 host.py SFP 
mv SFP_readout.csv ../sqlite/live_tests/
