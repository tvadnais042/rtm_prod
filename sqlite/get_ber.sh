#!/bin/bash
cd ../tclDev/
./run_ber.sh
mv BER_results_* ../sqlite/live_tests/ 