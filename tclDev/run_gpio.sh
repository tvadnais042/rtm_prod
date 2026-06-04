#!/bin/bash
ber=${1:-1e-8}
vivado -nojou -nolog -mode batch -source ber_gpio.tcl -tclargs $ber
