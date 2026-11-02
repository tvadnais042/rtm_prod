#Open and program board
open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
set_property PROGRAM.FILE "[lindex $argv 0]main.bit" [get_hw_devices xck26_0]
set_property PROBES.FILE "[lindex $argv 0]main.ltx" [get_hw_devices xck26_0] 
set_property FULL_PROBES.FILE "[lindex $argv 0]main.ltx" [get_hw_devices xck26_0] 
#program_hw_devices [get_hw_devices xck26_0]
refresh_hw_device [get_hw_devices xck26_0]

set hw_ila_1 [get_hw_ilas -of_objects [get_hw_devices xck26_0] -filter {CELL_NAME=~"ila_inst0"}]
run_hw_ila $hw_ila_1
wait_on_hw_ila $hw_ila_1
set captured_data [upload_hw_ila_data $hw_ila_1]

write_hw_ila_data -csv_file -force "[lindex $argv 0]../../../sqlite/live_tests/iladata.csv" $captured_data
close_hw_manager


