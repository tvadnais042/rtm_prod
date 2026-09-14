#!/bin/bash
cd ../rtmMC/
python3 host.py SFP 
mv SFP_readout.csv ../sqlite/live_tests/
