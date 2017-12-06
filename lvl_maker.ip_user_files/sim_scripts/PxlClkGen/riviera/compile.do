vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../lvl_maker.srcs/sources_1/ip/PxlClkGen" "+incdir+../../../../lvl_maker.srcs/sources_1/ip/PxlClkGen" \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93 \
"../../../ip/PxlClkGen/PxlClkGen_sim_netlist.vhdl" \


vlog -work xil_defaultlib \
"glbl.v"

