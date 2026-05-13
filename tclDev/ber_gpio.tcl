#Open and program board
open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
set_property PROGRAM.FILE {main.bit} [get_hw_devices xck26_0]
set_property PROBES.FILE {main.ltx} [get_hw_devices xck26_0] 
set_property FULL_PROBES.FILE {main.ltx} [get_hw_devices xck26_0] 
program_hw_devices [get_hw_devices xck26_0]
refresh_hw_device [get_hw_devices xck26_0]


refresh_hw_vio [lindex [get_hw_vio] 0]
set t [clock milliseconds]
set tstart "[clock format [expr {$t / 1000}] -format {%Y-%m-%d %H:%M:%S.} ][expr {$t % 1000}]"
#wait for the specified time
after 5
set fp [open "vio_out.csv" w]
set output [get_property INPUT_VALUE [get_hw_probes {count*}]]
set probeName [get_hw_probes {count*}]
for {set i 0} {$i < [llength [get_hw_probes {count*}]]} {incr i} {
    puts $fp "[lindex $probeName $i],[lindex $output $i]"
}
puts $fp "time_start,$tstart"
close $fp

