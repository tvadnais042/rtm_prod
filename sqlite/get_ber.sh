#!/bin/bash
cd ../tclDev/
ber=${1:-1e-10}
path=$2
vivado -nojou -nolog -mode batch -source ber.tcl -tclargs $ber $path
mv BER_results_* ../sqlite/live_tests/ 