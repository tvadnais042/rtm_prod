#varname="rtm_prod"
varname=$1
target=$2
if [[ -z "${varname}" ]]; then
  echo Payload?: 
  read varname
fi
if [[ -z "${target}" ]]; then
  target="kria"
fi

ssh -T $target << EOF
  mkdir -p payload
  sudo mkdir -p /lib/firmware/xilinx/bram/
EOF
scp -r -p payloads/$varname/* $target:~/payload/
ssh -T kria << EOF
  pwd
  sudo xmutil unloadapp
  sudo cp -r  /home/ubuntu/payload/* /lib/firmware/xilinx/bram/
  # sudo xmutil unloadapp
  sudo xmutil loadapp bram
EOF
