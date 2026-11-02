#!/bin/bash
cd ../tclDev/
ber=${1:-1e-10}
path=$2
echo Running GTH BER test...
vivado -nojou -nolog -mode batch -source ber.tcl -quiet -tclargs $ber $path
mv BER_results_* ../sqlite/live_tests/ 