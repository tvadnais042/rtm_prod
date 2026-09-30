#!/bin/bash
cd ../tclDev/
ber=${1:-1e-8}
vivado -nojou -nolog -mode batch -source eye.tcl -tclargs $ber
mv Scan_* ../sqlite/live_tests/

cd ../rtmMC/
python3 host.py SFP 
mv SFP_readout.csv ../sqlite/live_tests/
