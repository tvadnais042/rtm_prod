#!/bin/bash

cd ../acq_software
eval $(poetry env activate)
python analysis.py #look at pngs to confirm movement
mv data_files/0 ../sqlite/live_tests
mv data_files/1 ../sqlite/live_tests
