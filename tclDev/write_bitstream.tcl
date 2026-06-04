open_project /home/tom/Documents/rtm_prod/project_1/project_1.xpr
update_compile_order -fileset sources_1
reset_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 32
wait_on_run impl_1
