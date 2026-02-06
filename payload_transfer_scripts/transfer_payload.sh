varname="rtm_prod"

ssh -T kria << EOF
  mkdir -p payload
  sudo mkdir -p /lib/firmware/xilinx/bram/
EOF
scp -r -p payloads/$varname/* kria:payload/
ssh -T kria << EOF
  pwd
  sudo xmutil unloadapp
  sudo cp -r  /home/ubuntu/payload/* /lib/firmware/xilinx/bram/
  # sudo xmutil unloadapp
  sudo xmutil loadapp bram
EOF
