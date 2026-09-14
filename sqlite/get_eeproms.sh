#!/bin/bash
target=$1
num=$2
if [[ -z "${num}" ]]; then
  num=""
fi

cd ../rtmMC/
python host.py eeprom $target $num
mv eeprom_$target$num.csv ../sqlite/live_tests/