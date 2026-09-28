#!/bin/bash
cd ../tclDev/
./run_eyes.sh $1
mv Scan_* ../sqlite/live_tests/

cd ../rtmMC/
python3 host.py SFP 
mv SFP_readout.csv ../sqlite/live_tests/
