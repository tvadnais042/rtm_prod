#!/bin/bash



HOST="kria"
STEP=$1

ssh -T $HOST << EOF
    cd data_acq
    mkdir -p data_files
    # echo "Skipping compilation"
    # sudo chmod +x compile.sh
    # sudo  ./compile.sh
    echo "Running get_data_bram"
    # sudo xmutil unloadapp
    # sudo xmutil loadapp bram
    sudo nice --20 ./get_data_bram 50
EOF
echo $PWD
mkdir -p data_files/$STEP
rsync $HOST:data_acq/data_files/* data_files/$STEP






