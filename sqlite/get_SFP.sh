#!/bin/bash
ssh -t lab <<-'EOF'
    cd Documents/rtm_prod/rtmMC/
    source /home/nishant/tools/settings.sh
    source /home/nishant/tools/Xilinx/Vivado/2022.1/settings64.sh
    source /home/nishant/tools/Xilinx/Vitis/2022.1/settings64.sh
    sudo ./flash.sh
    sleep 1
    python3 host.py
EOF

scp lab:~/Documents/rtm_prod/rtmMC/EEPROM_* live_tests/

ssh -T lab <<-'EOF'
    cd Documents/rtm_prod/rtmMC/
    rm EEPROM_*
EOF
