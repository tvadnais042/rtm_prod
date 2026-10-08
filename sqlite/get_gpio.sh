#!/bin/bash
cd ../tclDev/
ber=${1:-1e-8}
path=$2
vivado -nojou -nolog -mode batch -source ber_gpio.tcl -tclargs $ber $path
mv vio_out* ../sqlite/live_tests/