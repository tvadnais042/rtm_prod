# RTM Production Code

v0.1

- 'project\_1/' - Vivado project (160MHz PL fabric -> 160.3071MHz)
- 'rtmMC/' - rp2040 microcontroller tools
- 'acq\_software/' Data Acquisition software
- 'payload\_transfer\_scripts/' - Build .bin and load them onto the Kria for testing.
- 'srcs/' Isolated source files from project 1

### Init rtmMC
cd rtmMC
git submodule update --init --recursive
mkdir build
cd build
cmake ..
make

### Dependencies
- Pico SDK (Git submodule)
- Picotool (Git submodule)
- Vivado 2022.04
