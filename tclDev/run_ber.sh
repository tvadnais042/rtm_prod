#!/bin/bash
ber=${1:-1e-10}
vivado -nojou -nolog -mode batch -source ber.tcl -tclargs $ber
