#!/bin/bash
cd ../tclDev/
./run_gpio.sh $1
mv vio_out* ../sqlite/live_tests/