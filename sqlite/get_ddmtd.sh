#!/bin/bash

# Flashing code should be fully separate. Handled by the sqlite depending on the step
# activate stage_4

# program PLL
ssh -T lab <<-'EOF'
    cd Documents/rtm_prod/rtmMC/
    sudo ./flash
    python pll_host.py
    
EOF


# Compile on Kria
# Collect from Kria
# process and store output

./run_gpio.sh

scp lab:~/Documents/rtm_prod/tclDev/vio_out* live_tests/

ssh -T lab <<-'EOF'
    cd Documents/rtm_prod/tclDev/
    rm vio_out*
EOF