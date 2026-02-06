#!/bin/bash



HOST="kria"

echo "Copying Data_acq Folder"
rsync -r data_acq $HOST:

echo "Running & Compiling Section"
ssh -T $HOST << EOF
    cd data_acq
    mkdir -p data_files
    echo "Compiling get_data_bram"
    sudo chmod +x compile.sh
    sudo  ./compile.sh
    echo "Running get_data_bram"
    sudo xmutil unloadapp
    sudo xmutil loadapp bram
    sudo nice --20 ./get_data_bram 250
EOF

rsync -r $HOST:data_acq/data_files .






