#!/bin/bash
ssh -T lab <<-'EOF'
    cd Documents/rtm_prod/tclDev/
    source /home/nishant/tools/settings.sh
    source /home/nishant/tools/Xilinx/Vivado/2022.1/settings64.sh
    source /home/nishant/tools/Xilinx/Vitis/2022.1/settings64.sh
    ./run_eyes.sh
EOF

scp lab:~/Documents/rtm_prod/tclDev/Scan_* live_tests/

ssh -T lab <<-'EOF'
    cd Documents/rtm_prod/tclDev/
    rm Scan_*
EOF