#!/bin/bash
target=$1
num=$2

cd ../rtmMC/
python host.py eeprom $target $num
mv eeprom_* ../sqlite/live_tests/