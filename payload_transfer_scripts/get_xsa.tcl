# Generate the XSA for a project tcl script
open_project ../project_1/project_1.xpr
update_compile_order -fileset sources_1
write_hw_platform -fixed -include_bit -force -file ../project_1/main.xsa
