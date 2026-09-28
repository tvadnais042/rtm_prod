#!/bin/bash
ber=${1:-1e-8}
echo "PLEASE WORK I AM BEGGING YOU" $ber
vivado -nojou -nolog -mode batch -source eye.tcl -tclargs $ber
