#Open and program board
open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
set_property PROGRAM.FILE {main.bit} [get_hw_devices xck26_0]
set_property PROBES.FILE {main.ltx} [get_hw_devices xck26_0] 
set_property FULL_PROBES.FILE {main.ltx} [get_hw_devices xck26_0] 
program_hw_devices [get_hw_devices xck26_0]
refresh_hw_device [get_hw_devices xck26_0]

#Make links
set TX0 [lindex [get_hw_sio_txs] 3]
set TX1 [lindex [get_hw_sio_txs] 2]
set TX2 [lindex [get_hw_sio_txs] 1]
set TX3 [lindex [get_hw_sio_txs] 0]
set RX0 [lindex [get_hw_sio_rxs] 2]
set RX1 [lindex [get_hw_sio_rxs] 1]
set RX2 [lindex [get_hw_sio_rxs] 3]
set RX3 [lindex [get_hw_sio_rxs] 0]
set xil_newLinks [list]
set xil_newLink [create_hw_sio_link -description {Link 0} $TX0 $RX0]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 1} $TX1 $RX1]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 2} $TX2 $RX2]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 3} $TX3 $RX3]
lappend xil_newLinks $xil_newLink
set xil_newLinkGroup [create_hw_sio_linkgroup -description {Link Group 0} [get_hw_sio_links $xil_newLinks]]
unset xil_newLinks

#Initialize Links
set_property TX_PATTERN {PRBS 31-bit} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {Link_Group_0}]]
commit_hw_sio -non_blocking [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {Link_Group_0}]]
set_property RX_PATTERN {PRBS 31-bit} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {Link_Group_0}]]
commit_hw_sio -non_blocking [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {Link_Group_0}]]

# Make all Scans
foreach i_link {0 1 2 3} {
set xil_newScan [create_hw_sio_scan -description "Scan link$i_link" -link_settings {RXTERM {800 mV} TXDIFFSWING {873 mV (11000)} TXPOST {4.08 dB (01111)} TXPRE {0.00 dB (00000)}} 2d_full_eye [lindex [get_hw_sio_links] $i_link]]
set_property HORIZONTAL_INCREMENT {8} [get_hw_sio_scans $xil_newScan]
set_property VERTICAL_INCREMENT {8} [get_hw_sio_scans $xil_newScan]
set_property DWELL_BER 1e-8 [get_hw_sio_scans $xil_newScan]
set_property RESET_RX_AFTER_APPLYING_SETTINGS 1 [get_hw_sio_scans $xil_newScan]
run_hw_sio_scan $xil_newScan
wait_on_hw_sio_scan $xil_newScan
puts "Writing Eye link $i_link $xil_newScan"
write_hw_sio_scan "Scan_$i_link.csv" $xil_newScan
}


