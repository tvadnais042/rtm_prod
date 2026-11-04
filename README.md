# RTM Production Code

v0.1.1

- **project_1** Vivado project Firmware
- **rtmMC** rp2040 microcontroller tools and binary
- **acq_software** DDMTD Data Acquisition software
- **payload_transfer_scripts** Builds vivado project snapshops and loads them onto the Kria for testing.
- **srcs/** Vivado source files for project_1

### Init rtmMC
Dependencies for the RTM microcontroller code are provided as github submodules.

Inside **rtmMC/** initialize the project before editing.  
`git submodule update --init --recursive1`  
`mkdir build`  

Build the project after edits. Inside **build/**  
`cmake ..`  
`make`


### Packaging / Flashing FPGA
**payload_transfer_scripts/build_dt.sh** builds the current vivado project into a payload. Before running, make sure you export the project hardware in vivado as main.xsa. 

**payload_transfer_scripts/transfer_payload.sh** transfers and flashes a named payload to a connected FPGA. 




