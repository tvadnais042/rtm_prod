hsi open_hw_design main.xsa
hsi set_repo_path  ./device-tree-xlnx
hsi create_sw_design device-tree -os device_tree -proc psu_cortexa53_0
hsi set_property CONFIG.dt_overlay true [hsi::get_os]
hsi generate_target -dir bram_dts
hsi close_hw_design main
exit
