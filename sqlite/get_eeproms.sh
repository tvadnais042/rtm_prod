#!/bin/bash
target=$1
num=$2

cd ../rtmMC/
python host.py eeprom $target $num
mv eeprom_$target$num.csv ../sqlite/live_tests/