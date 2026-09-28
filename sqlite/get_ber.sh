#!/bin/bash
cd ../tclDev/
./run_ber.sh $1
mv BER_results_* ../sqlite/live_tests/ 