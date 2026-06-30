#################################################
# Boolean Board Spartan-7 CPU Project
#################################################

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

#################################################
# CLOCK
#################################################

set_property PACKAGE_PIN F14 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

#################################################
# BUTTONS
#################################################

# BTN0 -> RESET
set_property PACKAGE_PIN J2 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# BTN1 -> IRI
set_property PACKAGE_PIN J5 [get_ports iri]
set_property IOSTANDARD LVCMOS33 [get_ports iri]

# BTN2 -> START
set_property PACKAGE_PIN H2 [get_ports start]
set_property IOSTANDARD LVCMOS33 [get_ports start]

# BTN3 -> DMA START
set_property PACKAGE_PIN J1 [get_ports dma_start]
set_property IOSTANDARD LVCMOS33 [get_ports dma_start]

#################################################
# PROGRAM ADDRESS SWITCHES
#################################################

set_property PACKAGE_PIN V2 [get_ports {prog_addr[0]}]
set_property PACKAGE_PIN U2 [get_ports {prog_addr[1]}]
set_property PACKAGE_PIN U1 [get_ports {prog_addr[2]}]
set_property PACKAGE_PIN T2 [get_ports {prog_addr[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {prog_addr[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {prog_addr[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {prog_addr[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {prog_addr[3]}]

#################################################
# PROGRAM INSTRUCTION SWITCHES
#################################################

set_property PACKAGE_PIN T1 [get_ports {prog_instruction[0]}]
set_property PACKAGE_PIN R2 [get_ports {prog_instruction[1]}]
set_property PACKAGE_PIN R1 [get_ports {prog_instruction[2]}]
set_property PACKAGE_PIN P2 [get_ports {prog_instruction[3]}]
set_property PACKAGE_PIN P1 [get_ports {prog_instruction[4]}]
set_property PACKAGE_PIN N2 [get_ports {prog_instruction[5]}]
set_property PACKAGE_PIN N1 [get_ports {prog_instruction[6]}]
set_property PACKAGE_PIN M2 [get_ports {prog_instruction[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {prog_instruction[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {prog_instruction[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {prog_instruction[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {prog_instruction[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {prog_instruction[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {prog_instruction[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {prog_instruction[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {prog_instruction[7]}]

#################################################
# CPU OUTPUT LEDs
#################################################

set_property PACKAGE_PIN G1 [get_ports {cpu_out[0]}]
set_property PACKAGE_PIN G2 [get_ports {cpu_out[1]}]
set_property PACKAGE_PIN F1 [get_ports {cpu_out[2]}]
set_property PACKAGE_PIN F2 [get_ports {cpu_out[3]}]
set_property PACKAGE_PIN E1 [get_ports {cpu_out[4]}]
set_property PACKAGE_PIN E2 [get_ports {cpu_out[5]}]
set_property PACKAGE_PIN E3 [get_ports {cpu_out[6]}]
set_property PACKAGE_PIN E5 [get_ports {cpu_out[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {cpu_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cpu_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cpu_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cpu_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cpu_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cpu_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cpu_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cpu_out[7]}]

#################################################
# 7 SEGMENT DISPLAY - DIGIT ENABLES
#################################################

set_property PACKAGE_PIN D5 [get_ports {an[0]}]
set_property PACKAGE_PIN C4 [get_ports {an[1]}]
set_property PACKAGE_PIN C7 [get_ports {an[2]}]
set_property PACKAGE_PIN A4 [get_ports {an[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]

#################################################
# 7 SEGMENT DISPLAY - SEGMENTS
#################################################

set_property PACKAGE_PIN D7 [get_ports {seg[0]}]
set_property PACKAGE_PIN C5 [get_ports {seg[1]}]
set_property PACKAGE_PIN A5 [get_ports {seg[2]}]
set_property PACKAGE_PIN B7 [get_ports {seg[3]}]
set_property PACKAGE_PIN A7 [get_ports {seg[4]}]
set_property PACKAGE_PIN D6 [get_ports {seg[5]}]
set_property PACKAGE_PIN B5 [get_ports {seg[6]}]

set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

#################################################
# IR SENSOR INPUT
#################################################

set_property PACKAGE_PIN M14 [get_ports ir_sensor]
set_property IOSTANDARD LVCMOS33 [get_ports ir_sensor]

#################################################
# SECOND 7-SEG DISPLAY (PROGRAM COUNTER)
#################################################

set_property PACKAGE_PIN H3 [get_ports {pc_an[0]}]
set_property PACKAGE_PIN J4 [get_ports {pc_an[1]}]
set_property PACKAGE_PIN F3 [get_ports {pc_an[2]}]
set_property PACKAGE_PIN E4 [get_ports {pc_an[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {pc_an[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pc_an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pc_an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pc_an[3]}]

set_property PACKAGE_PIN F4 [get_ports {pc_seg[0]}]
set_property PACKAGE_PIN J3 [get_ports {pc_seg[1]}]
set_property PACKAGE_PIN D2 [get_ports {pc_seg[2]}]
set_property PACKAGE_PIN C2 [get_ports {pc_seg[3]}]
set_property PACKAGE_PIN B1 [get_ports {pc_seg[4]}]
set_property PACKAGE_PIN H4 [get_ports {pc_seg[5]}]
set_property PACKAGE_PIN D1 [get_ports {pc_seg[6]}]

set_property IOSTANDARD LVCMOS33 [get_ports {pc_seg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pc_seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pc_seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pc_seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pc_seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pc_seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pc_seg[6]}]