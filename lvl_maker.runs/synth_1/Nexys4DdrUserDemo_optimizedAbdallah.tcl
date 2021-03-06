# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.cache/wt [current_project]
set_property parent.project_path C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo c:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/imports/VhdlSources/ADXL362Ctrl.vhd
  C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/imports/VhdlSources/AccelArithmetics.vhd
  C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/imports/VhdlSources/AccelerometerCtl.vhd
  C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/imports/mouseDisplay/MouseCtl.vhd
  C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/imports/mouseDisplay/MouseDisplay.vhd
  C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/imports/VhdlSources/SPI_If.vhd
  {C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/imports/Final Project/VgaForMouseOnly.vhd}
  D:/collision.vhd
  C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/imports/mouseDisplay/count_display.vhd
  {C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/imports/mouseDisplay/level .vhd}
  C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/imports/mouseDisplay/Nexys4DdrUserDemo_OptimizedAbdallah.vhd
}
read_ip -quiet C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/ip/Square_Root/Square_Root.xci
set_property is_locked true [get_files C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/ip/Square_Root/Square_Root.xci]

read_ip -quiet C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/ip/ClkGen/ClkGen.xci
set_property used_in_implementation false [get_files -all c:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/ip/ClkGen/ClkGen_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/ip/ClkGen/ClkGen.xdc]
set_property used_in_implementation false [get_files -all c:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/ip/ClkGen/ClkGen_ooc.xdc]
set_property is_locked true [get_files C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/ip/ClkGen/ClkGen.xci]

read_ip -quiet C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/ip/PxlClkGen/PxlClkGen.xci
set_property used_in_implementation false [get_files -all c:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/ip/PxlClkGen/PxlClkGen_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/ip/PxlClkGen/PxlClkGen.xdc]
set_property used_in_implementation false [get_files -all c:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/ip/PxlClkGen/PxlClkGen_late.xdc]
set_property used_in_implementation false [get_files -all c:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/ip/PxlClkGen/PxlClkGen_ooc.xdc]
set_property is_locked true [get_files C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/sources_1/ip/PxlClkGen/PxlClkGen.xci]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/constrs_1/imports/mouseDisplay/Nexys4DDR_C.xdc
set_property used_in_implementation false [get_files C:/Users/foxbo/Documents/CMPEN371/lvl_maker/lvl_maker.srcs/constrs_1/imports/mouseDisplay/Nexys4DDR_C.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top Nexys4DdrUserDemo_optimizedAbdallah -part xc7a100tcsg324-1 -flatten_hierarchy none -directive RuntimeOptimized -fsm_extraction off


write_checkpoint -force -noxdef Nexys4DdrUserDemo_optimizedAbdallah.dcp

catch { report_utilization -file Nexys4DdrUserDemo_optimizedAbdallah_utilization_synth.rpt -pb Nexys4DdrUserDemo_optimizedAbdallah_utilization_synth.pb }
