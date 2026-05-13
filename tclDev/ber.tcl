#Open and program board
open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
#set_property PROGRAM.FILE {main.bit} [get_hw_devices xck26_0]
set_property PROBES.FILE {main.ltx} [get_hw_devices xck26_0] 
set_property FULL_PROBES.FILE {main.ltx} [get_hw_devices xck26_0] 
#program_hw_devices [get_hw_devices xck26_0]
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
puts [get_hw_sio_linkgroups]


set links "[get_hw_sio_links -of_objects [get_hw_sio_linkgroups {Link_Group_0}]]"

#Initialize Links
set_property TX_PATTERN {PRBS 31-bit} $links 
set_property RX_PATTERN {PRBS 31-bit} $links
set_property RXTERM {800 mV} $links
set_property TXDIFFSWING {873 mV (11000)} $links
set_property TXPOST {4.08 dB (01111)} $links
set_property TXPRE {0.00 dB (00000)} $links
commit_hw_sio -non_blocking $links

#Reset And Count
set_property LOGIC.TX_RESET_DATAPATH 1 $links
commit_hw_sio -non_blocking $links
set_property LOGIC.TX_RESET_DATAPATH 0 $links 
commit_hw_sio -non_blocking $links
set_property LOGIC.RX_RESET_DATAPATH 1 $links
commit_hw_sio -non_blocking $links
set_property LOGIC.RX_RESET_DATAPATH 0 $links 
commit_hw_sio -non_blocking $links

set t [clock milliseconds]
set tstart "[clock format [expr {$t / 1000}] -format {%Y-%m-%d %H:%M:%S.} ][expr {$t % 1000}]"

set_property LOGIC.MGT_ERRCNT_RESET_CTRL 1 $links
commit_hw_sio -non_blocking $links
set_property LOGIC.MGT_ERRCNT_RESET_CTRL 0 $links
commit_hw_sio -non_blocking $links

after 1000

refresh_hw_sio $links
foreach i {0 1 2 3} {
set fp [open "BER_results_1_$i.csv" w]
puts $fp "link,$i"
puts $fp "mezzanine,1"
puts $fp "time_start,$tstart"
puts $fp "LINE_RATE,10.000"
puts $fp "RX_RECEIVED_BIT_COUNT,[get_property RX_RECEIVED_BIT_COUNT [lindex [get_hw_sio_links] $i]]"
puts $fp "LOGIC.ERRBIT_COUNT,[get_property LOGIC.ERRBIT_COUNT [lindex [get_hw_sio_links] $i]]"
set txpatt [get_property TX_PATTERN [lindex [get_hw_sio_links] $i]]
set rxpatt [get_property RX_PATTERN [lindex [get_hw_sio_links] $i]]
if {$txpatt == $rxpatt} {
    puts $fp "PATTERN,$txpatt"
} else {
    error "TX-RX pattern mismatch!"
}
puts $fp "TXPRE,[get_property TXPRE [lindex [get_hw_sio_links] $i]]"
puts $fp "TXPOST,[get_property TXPOST [lindex [get_hw_sio_links] $i]]"
puts $fp "TXDIFFSWING,[get_property TXDIFFSWING [lindex [get_hw_sio_links] $i]]"
puts $fp "RXTERM,[get_property RXTERM [lindex [get_hw_sio_links] $i]]"
puts $fp "RX_BER,[get_property RX_BER [lindex [get_hw_sio_links] $i]]"
close $fp
}

