#!/bin/bash



HOST="kria"
STEP=$1
CYCLES=$2
if [[ -z "${CYCLES}" ]]; then
    CYCLES=50
fi

ssh -T $HOST << EOF
    cd data_acq
    mkdir -p data_files
    sudo nice --20 ./get_data_bram $CYCLES
EOF
mkdir -p data_files/$STEP
rsync $HOST:data_acq/data_files/* data_files/$STEP






