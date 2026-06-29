#!/bin/bash
ssh -T lab <<-'EOF'
    cd Documents/rtm_prod/rtmMC/
    python3 host.py eeprom
EOF

scp lab:~/Documents/rtm_prod/rtmMC/EEPROM_readout.csv live_tests/

ssh -T lab <<-'EOF'
    cd Documents/rtm_prod/rtmMC/
    rm EEPROM_readout.csv
EOF