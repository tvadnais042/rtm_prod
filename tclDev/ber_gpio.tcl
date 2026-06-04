#Open and program board
open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
set_property PROGRAM.FILE {../project_1/project_1.runs/impl_1/main.bit} [get_hw_devices xck26_0]
set_property PROBES.FILE {../project_1/project_1.runs/impl_1/main.ltx} [get_hw_devices xck26_0] 
set_property FULL_PROBES.FILE {../project_1/project_1.runs/impl_1/main.ltx} [get_hw_devices xck26_0] 
#program_hw_devices [get_hw_devices xck26_0]
refresh_hw_device [get_hw_devices xck26_0]

refresh_hw_vio [lindex [get_hw_vio] 0]

set t [clock milliseconds]
set tstart "[clock format [expr {$t / 1000}] -format {%Y-%m-%d %H:%M:%S.} ][expr {$t % 1000}]"

startgroup
set_property OUTPUT_VALUE 1 [get_hw_probes prbs_reset] 
commit_hw_vio [get_hw_probes {prbs_reset}] 
endgroup
startgroup
set_property OUTPUT_VALUE 0 [get_hw_probes prbs_reset]
commit_hw_vio [get_hw_probes {prbs_reset}]
endgroup

after [expr {round(1/([lindex $argv 0]*160000))}]

refresh_hw_vio [lindex [get_hw_vio] 0]
set output [get_property INPUT_VALUE [get_hw_probes {count*}]]
set probeName [get_hw_probes {count*}]
set fp [open "vio_out.csv" w]
for {set i 0} {$i < [llength [get_hw_probes {count*}]]} {incr i} {
    puts $fp "[lindex $probeName $i],[lindex $output $i]"
}
puts $fp "time_start,$tstart"
puts $fp "BER_expected,[lindex $argv 0]"
puts $fp "time_wait_ms,[expr {round(1/([lindex $argv 0]*160000))}]"
close $fp

