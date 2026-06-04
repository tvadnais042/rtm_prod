#!/bin/bash
ber=${1:-1e-8}
vivado -nojou -nolog -mode batch -source eye.tcl -tclargs $ber
