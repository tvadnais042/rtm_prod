#------------------------------------------------------------------------------
#  (c) Copyright 2013-2018 Xilinx, Inc. All rights reserved.
#
#  This file contains confidential and proprietary information
#  of Xilinx, Inc. and is protected under U.S. and
#  international copyright and other intellectual property
#  laws.
#
#  DISCLAIMER
#  This disclaimer is not a license and does not grant any
#  rights to the materials distributed herewith. Except as
#  otherwise provided in a valid license issued to you by
#  Xilinx, and to the maximum extent permitted by applicable
#  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
#  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
#  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
#  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
#  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
#  (2) Xilinx shall not be liable (whether in contract or tort,
#  including negligence, or under any other theory of
#  liability) for any loss or damage of any kind or nature
#  related to, arising under or in connection with these
#  materials, including for any direct, or any indirect,
#  special, incidental, or consequential loss or damage
#  (including loss of data, profits, goodwill, or any type of
#  loss or damage suffered as a result of any action brought
#  by a third party) even if such damage or loss was
#  reasonably foreseeable or Xilinx had been advised of the
#  possibility of the same.
#
#  CRITICAL APPLICATIONS
#  Xilinx products are not designed or intended to be fail-
#  safe, or for use in any application requiring fail-safe
#  performance, such as life-support or safety devices or
#  systems, Class III medical devices, nuclear facilities,
#  applications related to the deployment of airbags, or any
#  other applications that could lead to death, personal
#  injury, or severe property or environmental damage
#  (individually and collectively, "Critical
#  Applications"). Customer assumes the sole risk and
#  liability of any use of Xilinx products in Critical
#  Applications, subject only to applicable laws and
#  regulations governing limitations on product liability.
#
#  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
#  PART OF THIS FILE AT ALL TIMES.
#------------------------------------------------------------------------------

# =========================================================================================
# GTHWIZ constraints
# =========================================================================================


#set_property IOSTANDARD LVDS [get_ports hb_gtwiz_reset_clk_freerun_p]
#set_property IOSTANDARD LVDS [get_ports hb_gtwiz_reset_clk_freerun_n]
#set_property PACKAGE_PIN L3 [get_ports hb_gtwiz_reset_clk_freerun_p]
#set_property PACKAGE_PIN L2 [get_ports hb_gtwiz_reset_clk_freerun_n]
#set_property PACKAGE_PIN L2       [get_ports "som240_2_d19"] ;# Bank  65 VCCO - som240_2_a44 - IO_L12N_T1U_N11_GC_65
#set_property PACKAGE_PIN L3       [get_ports "som240_2_d18"] ;# Bank  65 VCCO - som240_2_a44 - IO_L12P_T1U_N10_GC_65

# UltraScale FPGAs Transceivers Wizard IP example design-level XDC file
# ----------------------------------------------------------------------------------------------------------------------

# Location constraints for differential reference clock buffers
# Note: the IP core-level XDC constrains the transceiver channel data pin locations
# ----------------------------------------------------------------------------------------------------------------------
#set_property PACKAGE_PIN Y5 [get_ports mgtrefclk0_x0y1_n]
#set_property PACKAGE_PIN Y6 [get_ports mgtrefclk0_x0y1_p] #oscilaltor at 156.25MHz
#set_property PACKAGE_PIN Y5       [get_ports "som240_2_c4"] ;# Bank 224 - MGTREFCLK0N_224
#set_property PACKAGE_PIN Y6       [get_ports "som240_2_c3"] ;# Bank 224 - MGTREFCLK0P_224


# Location constraints for other example design top-level ports
# Note: uncomment the following set_property constraints and replace "<>" with appropriate pin locations for your board
# ----------------------------------------------------------------------------------------------------------------------
#set_property package_pin <> [get_ports hb_gtwiz_reset_clk_freerun_in]
#set_property iostandard  <> [get_ports hb_gtwiz_reset_clk_freerun_in]

#set_property package_pin <> [get_ports hb_gtwiz_reset_all_in]
#set_property iostandard  <> [get_ports hb_gtwiz_reset_all_in]

#set_property package_pin <> [get_ports link_down_latched_reset_in]
#set_property iostandard  <> [get_ports link_down_latched_reset_in]

#set_property package_pin <> [get_ports link_status_out]
#set_property iostandard  <> [get_ports link_status_out]

#set_property package_pin <> [get_ports link_down_latched_out]
#set_property iostandard  <> [get_ports link_down_latched_out]

# Clock constraints for clocks provided as inputs to the core
# Note: the IP core-level XDC constrains clocks produced by the core, which drive user clocks via helper blocks
# ----------------------------------------------------------------------------------------------------------------------
#create_clock -period 8.000 -name clk_freerun [get_ports hb_gtwiz_reset_clk_freerun_p]
#create_clock -period 6.400 -name clk_mgtrefclk0_x0y1_p [get_ports mgtrefclk0_x0y1_p] #156.25MHz inflexible, so 6.400

# False path constraints
# ----------------------------------------------------------------------------------------------------------------------
#set_false_path -to [get_cells -hierarchical -filter {NAME =~ *bit_synchronizer*inst/i_in_meta_reg}] -quiet
###set_false_path -to [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_*_reg}] -quiet
#set_false_path -to [get_pins -filter REF_PIN_NAME=~*D -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_meta*}]] -quiet
#set_false_path -to [get_pins -filter REF_PIN_NAME=~*PRE -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_meta*}]] -quiet
#set_false_path -to [get_pins -filter REF_PIN_NAME=~*PRE -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_sync1*}]] -quiet
#set_false_path -to [get_pins -filter REF_PIN_NAME=~*PRE -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_sync2*}]] -quiet
#set_false_path -to [get_pins -filter REF_PIN_NAME=~*PRE -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_sync3*}]] -quiet
#set_false_path -to [get_pins -filter REF_PIN_NAME=~*PRE -of_objects [get_cells -hierarchical -filter {NAME =~ *reset_synchronizer*inst/rst_in_out*}]] -quiet


#set_false_path -to [get_cells -hierarchical -filter {NAME =~ *gtwiz_userclk_tx_inst/*gtwiz_userclk_tx_active_*_reg}] -quiet
#set_false_path -to [get_cells -hierarchical -filter {NAME =~ *gtwiz_userclk_rx_inst/*gtwiz_userclk_rx_active_*_reg}] -quiet

#set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
#set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
#set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
#connect_debug_port dbg_hub/clk [get_nets hb_gtwiz_reset_clk_freerun_buf_int]


# =========================================================================================
# Project_2 constraints
# =========================================================================================


#The pin mapping of the som_240 connectors is avaialble in the file Kria_K26_SOM_Rev1.xdc

#FPGA_CLK SMA ==> U304 ==> pin68/pin66 of JB301 ==> B66_L14_GC of FPGA ==>
#set_property IOSTANDARD LVDS [get_ports CLK_REF_N]
#set_property IOSTANDARD LVDS [get_ports CLK_REF_P]
#set_property PACKAGE_PIN L2 [get_ports CLK_REF_N]
#set_property PACKAGE_PIN L3 [get_ports CLK_REF_P]
#create_clock -period 6.250 -name PLLOUT_P -waveform {0.000 3.125} [get_ports PLLOUT_P]


#-----------------------------------------------------------------------
# MEZZ2_TX1
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ2_TX1_P]
set_property IOSTANDARD LVDS [get_ports MEZZ2_TX1_N]
set_property PACKAGE_PIN H9 [get_ports MEZZ2_TX1_P]
set_property PACKAGE_PIN H8 [get_ports MEZZ2_TX1_N]
#set_property PACKAGE_PIN H9 [get_ports "som240_2_a26"] ;# Bank  65 VCCO - som240_2_a44 - IO_L24P_T3U_N10_PERSTN1_I2C_SDA_65
#set_property PACKAGE_PIN H8 [get_ports "som240_2_a27"] ;# Bank  65 VCCO - som240_2_a44 - IO_L24N_T3U_N11_PERSTN0_65

#-----------------------------------------------------------------------
# MEZZ2_TX2 (inverted on the pcb) (reverted)
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ2_TX2_P]
set_property IOSTANDARD LVDS [get_ports MEZZ2_TX2_N]
set_property PACKAGE_PIN AB2 [get_ports MEZZ2_TX2_P]
set_property PACKAGE_PIN AC2 [get_ports MEZZ2_TX2_N]
#set_property PACKAGE_PIN AB2 [get_ports "som240_2_a35"] ;# Bank  64 VCCO - som240_2_c44 - IO_L17P_T2U_N8_AD10P_64
#set_property PACKAGE_PIN AC2 [get_ports "som240_2_a36"] ;# Bank  64 VCCO - som240_2_c44 - IO_L17N_T2U_N9_AD10N_64

#-----------------------------------------------------------------------
# MEZZ2_TX3
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ2_TX3_P]
set_property IOSTANDARD LVDS [get_ports MEZZ2_TX3_N]
set_property PACKAGE_PIN AH8 [get_ports MEZZ2_TX3_P]
set_property PACKAGE_PIN AH7 [get_ports MEZZ2_TX3_N]
#set_property PACKAGE_PIN AH8 [get_ports "som240_2_b36"] ;# Bank  64 VCCO - som240_2_c44 - IO_L9P_T1L_N4_AD12P_64
#set_property PACKAGE_PIN AH7 [get_ports "som240_2_b37"] ;# Bank  64 VCCO - som240_2_c44 - IO_L9N_T1L_N5_AD12N_64

#-----------------------------------------------------------------------
# MEZZ2_TX4 (inverted on the pcb) (reverted)
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ2_TX4_P]
set_property IOSTANDARD LVDS [get_ports MEZZ2_TX4_N]
set_property PACKAGE_PIN AB7 [get_ports MEZZ2_TX4_P]
set_property PACKAGE_PIN AC7 [get_ports MEZZ2_TX4_N]
#set_property PACKAGE_PIN AB7 [get_ports "som240_2_d39"] ;# Bank  64 VCCO - som240_2_c44 - IO_L5P_T0U_N8_AD14P_64
#set_property PACKAGE_PIN AC7 [get_ports "som240_2_d40"] ;# Bank  64 VCCO - som240_2_c44 - IO_L5N_T0U_N9_AD14N_64

#-----------------------------------------------------------------------
# MEZZ2_RX1 (inverted on the pcb) (reverted)
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ2_RX1_P]
set_property IOSTANDARD LVDS [get_ports MEZZ2_RX1_N]
set_property PACKAGE_PIN AD5 [get_ports MEZZ2_RX1_P]
set_property PACKAGE_PIN AD4 [get_ports MEZZ2_RX1_N]
#set_property PACKAGE_PIN AD5 [get_ports "som240_2_c29"] ;# Bank  64 VCCO - som240_2_c44 - IO_L13P_T2L_N0_GC_QBC_64
#set_property PACKAGE_PIN AD4 [get_ports "som240_2_c30"] ;# Bank  64 VCCO - som240_2_c44 - IO_L13N_T2L_N1_GC_QBC_64

#-----------------------------------------------------------------------
# MEZZ2_RX2
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ2_RX2_P]
set_property IOSTANDARD LVDS [get_ports MEZZ2_RX2_N]
set_property PACKAGE_PIN AH2 [get_ports MEZZ2_RX2_P]
set_property PACKAGE_PIN AH1 [get_ports MEZZ2_RX2_N]
#set_property PACKAGE_PIN AH2 [get_ports "som240_2_a32"] ;# Bank  64 VCCO - som240_2_c44 - IO_L23P_T3U_N8_64
#set_property PACKAGE_PIN AH1 [get_ports "som240_2_a33"] ;# Bank  64 VCCO - som240_2_c44 - IO_L23N_T3U_N9_64

#-----------------------------------------------------------------------
# MEZZ2_RX3 (inverted on the pcb) (reverted)
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ2_RX3_P]
set_property IOSTANDARD LVDS [get_ports MEZZ2_RX3_N]
set_property PACKAGE_PIN AG3 [get_ports MEZZ2_RX3_P]
set_property PACKAGE_PIN AH3 [get_ports MEZZ2_RX3_N]
#set_property PACKAGE_PIN AG3 [get_ports "som240_2_b33"] ;# Bank  64 VCCO - som240_2_c44 - IO_L20P_T3L_N2_AD1P_64
#set_property PACKAGE_PIN AH3 [get_ports "som240_2_b34"] ;# Bank  64 VCCO - som240_2_c44 - IO_L20N_T3L_N3_AD1N_64

#-----------------------------------------------------------------------
# MEZZ2_RX4
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ2_RX4_P]
set_property IOSTANDARD LVDS [get_ports MEZZ2_RX4_N]
set_property PACKAGE_PIN AD7 [get_ports MEZZ2_RX4_P]
set_property PACKAGE_PIN AE7 [get_ports MEZZ2_RX4_N]
#set_property PACKAGE_PIN AD7 [get_ports "som240_2_a41"] ;# Bank  64 VCCO - som240_2_c44 - IO_L4P_T0U_N6_DBC_AD7P_64
#set_property PACKAGE_PIN AE7 [get_ports "som240_2_a42"] ;# Bank  64 VCCO - som240_2_c44 - IO_L4N_T0U_N7_DBC_AD7N_64

#-----------------------------------------------------------------------
# MEZZ3_TX1
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ3_TX1_P]
set_property IOSTANDARD LVDS [get_ports MEZZ3_TX1_N]
set_property PACKAGE_PIN AB8 [get_ports MEZZ3_TX1_P]
set_property PACKAGE_PIN AC8 [get_ports MEZZ3_TX1_N]
#set_property PACKAGE_PIN AB8 [get_ports "som240_2_d36"] ;# Bank  64 VCCO - som240_2_c44 - IO_L3P_T0L_N4_AD15P_64
#set_property PACKAGE_PIN AC8 [get_ports "som240_2_d37"] ;# Bank  64 VCCO - som240_2_c44 - IO_L3N_T0L_N5_AD15N_64

#-----------------------------------------------------------------------
# MEZZ3_TX2
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ3_TX2_P]
set_property IOSTANDARD LVDS [get_ports MEZZ3_TX2_N]
set_property PACKAGE_PIN AD2 [get_ports MEZZ3_TX2_P]
set_property PACKAGE_PIN AD1 [get_ports MEZZ3_TX2_N]
#set_property PACKAGE_PIN AD2 [get_ports "som240_2_b30"] ;# Bank  64 VCCO - som240_2_c44 - IO_L16P_T2U_N6_QBC_AD3P_64
#set_property PACKAGE_PIN AD1 [get_ports "som240_2_b31"] ;# Bank  64 VCCO - som240_2_c44 - IO_L16N_T2U_N7_QBC_AD3N_64

#-----------------------------------------------------------------------
# MEZZ3_TX3
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ3_TX3_P]
set_property IOSTANDARD LVDS [get_ports MEZZ3_TX3_N]
set_property PACKAGE_PIN AF8 [get_ports MEZZ3_TX3_P]
set_property PACKAGE_PIN AG8 [get_ports MEZZ3_TX3_N]
#set_property PACKAGE_PIN AF8 [get_ports "som240_2_b27"] ;# Bank  64 VCCO - som240_2_c44 - IO_L8P_T1L_N2_AD5P_64
#set_property PACKAGE_PIN AG8 [get_ports "som240_2_b28"] ;# Bank  64 VCCO - som240_2_c44 - IO_L8N_T1L_N3_AD5N_64

#-----------------------------------------------------------------------
# MEZZ3_TX4 (inverted on the pcb) (reverted)
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ3_TX4_P]
set_property IOSTANDARD LVDS [get_ports MEZZ3_TX4_N]
set_property PACKAGE_PIN M6 [get_ports MEZZ3_TX4_P]
set_property PACKAGE_PIN L5 [get_ports MEZZ3_TX4_N]
#set_property PACKAGE_PIN M6 [get_ports "som240_2_b21"] ;# Bank  65 VCCO - som240_2_a44 - IO_L14P_T2L_N2_GC_65
#set_property PACKAGE_PIN L5 [get_ports "som240_2_b22"] ;# Bank  65 VCCO - som240_2_a44 - IO_L14N_T2L_N3_GC_65

#-----------------------------------------------------------------------
# MEZZ3_RX1
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ3_RX1_P]
set_property IOSTANDARD LVDS [get_ports MEZZ3_RX1_N]
set_property PACKAGE_PIN D7 [get_ports MEZZ3_RX1_P]
set_property PACKAGE_PIN D6 [get_ports MEZZ3_RX1_N]
#set_property PACKAGE_PIN D7 [get_ports "som240_1_c12"] ;# Bank  66 VCCO - som240_1_d1 - IO_L13P_T2L_N0_GC_QBC_66
#set_property PACKAGE_PIN D6 [get_ports "som240_1_c13"] ;# Bank  66 VCCO - som240_1_d1 - IO_L13N_T2L_N1_GC_QBC_66

#-----------------------------------------------------------------------
# MEZZ3_RX2
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ3_RX2_P]
set_property IOSTANDARD LVDS [get_ports MEZZ3_RX2_N]
set_property PACKAGE_PIN E5 [get_ports MEZZ3_RX2_P]
set_property PACKAGE_PIN D5 [get_ports MEZZ3_RX2_N]
#set_property PACKAGE_PIN E5 [get_ports "som240_1_b10"] ;# Bank  66 VCCO - som240_1_d1 - IO_L14P_T2L_N2_GC_66
#set_property PACKAGE_PIN D5 [get_ports "som240_1_b11"] ;# Bank  66 VCCO - som240_1_d1 - IO_L14N_T2L_N3_GC_66

#-----------------------------------------------------------------------
# MEZZ3_RX3
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ3_RX3_P]
set_property IOSTANDARD LVDS [get_ports MEZZ3_RX3_N]
set_property PACKAGE_PIN F8 [get_ports MEZZ3_RX3_P]
set_property PACKAGE_PIN E8 [get_ports MEZZ3_RX3_N]
#set_property PACKAGE_PIN F8 [get_ports "som240_1_d13"] ;# Bank  66 VCCO - som240_1_d1 - IO_L17P_T2U_N8_AD10P_66
#set_property PACKAGE_PIN E8 [get_ports "som240_1_d14"] ;# Bank  66 VCCO - som240_1_d1 - IO_L17N_T2U_N9_AD10N_66

#-----------------------------------------------------------------------
# MEZZ3_RX4
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ3_RX4_P]
set_property IOSTANDARD LVDS [get_ports MEZZ3_RX4_N]
set_property PACKAGE_PIN G6 [get_ports MEZZ3_RX4_P]
set_property PACKAGE_PIN F6 [get_ports MEZZ3_RX4_N]
#set_property PACKAGE_PIN G6 [get_ports "som240_1_a9"] ;# Bank  66 VCCO - som240_1_d1 - IO_L15P_T2L_N4_AD11P_66
#set_property PACKAGE_PIN F6 [get_ports "som240_1_a10"] ;# Bank  66 VCCO - som240_1_d1 - IO_L15N_T2L_N5_AD11N_66

#-----------------------------------------------------------------------
# MEZZ4_TX1 (PLL_IN1)
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ4_TX1_P]
set_property IOSTANDARD LVDS [get_ports MEZZ4_TX1_N]
set_property PACKAGE_PIN AE3 [get_ports MEZZ4_TX1_P]
set_property PACKAGE_PIN AF3 [get_ports MEZZ4_TX1_N]
#set_property PACKAGE_PIN AE3 [get_ports "som240_2_c26"] ;# Bank  64 VCCO - som240_2_c44 - IO_L21P_T3L_N4_AD8P_64
#set_property PACKAGE_PIN AF3 [get_ports "som240_2_c27"] ;# Bank  64 VCCO - som240_2_c44 - IO_L21N_T3L_N5_AD8N_64

#-----------------------------------------------------------------------
# MEZZ4_TX2 (PLL_IN2)
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ4_TX2_P]
set_property IOSTANDARD LVDS [get_ports MEZZ4_TX2_N]
set_property PACKAGE_PIN K9 [get_ports MEZZ4_TX2_P]
set_property PACKAGE_PIN J9 [get_ports MEZZ4_TX2_N]
#set_property PACKAGE_PIN K9 [get_ports "som240_2_c23"] ;# Bank  65 VCCO - som240_2_a44 - IO_L23P_T3U_N8_I2C_SCLK_65
#set_property PACKAGE_PIN J9 [get_ports "som240_2_c24"] ;# Bank  65 VCCO - som240_2_a44 - IO_L23N_T3U_N9_65

#-----------------------------------------------------------------------
# MEZZ4_TX3 (SGMII_TX)
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ4_TX3_P]
set_property IOSTANDARD LVDS [get_ports MEZZ4_TX3_N]
set_property PACKAGE_PIN N7 [get_ports MEZZ4_TX3_P]
set_property PACKAGE_PIN N6 [get_ports MEZZ4_TX3_N]
#set_property PACKAGE_PIN N7 [get_ports "som240_2_a17"] ;# Bank  65 VCCO - som240_2_a44 - IO_L15P_T2L_N4_AD11P_65
#set_property PACKAGE_PIN N6 [get_ports "som240_2_a18"] ;# Bank  65 VCCO - som240_2_a44 - IO_L15N_T2L_N5_AD11N_65

#-----------------------------------------------------------------------
# MEZZ4_TX4
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ4_TX4_P]
set_property IOSTANDARD LVDS [get_ports MEZZ4_TX4_N]
set_property PACKAGE_PIN J5 [get_ports MEZZ4_TX4_P]
set_property PACKAGE_PIN J4 [get_ports MEZZ4_TX4_N]
#set_property PACKAGE_PIN J5 [get_ports "som240_2_a11"] ;# Bank  65 VCCO - som240_2_a44 - IO_L19P_T3L_N0_DBC_AD9P_65
#set_property PACKAGE_PIN J4 [get_ports "som240_2_a12"] ;# Bank  65 VCCO - som240_2_a44 - IO_L19N_T3L_N1_DBC_AD9N_65

#-----------------------------------------------------------------------
# MEZZ4_RX1 (PLLOUT1)
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ4_RX1_P]
set_property IOSTANDARD LVDS [get_ports MEZZ4_RX1_N]
set_property PACKAGE_PIN AE5 [get_ports MEZZ4_RX1_P]
set_property PACKAGE_PIN AF5 [get_ports MEZZ4_RX1_N]
#set_property PACKAGE_PIN AE5 [get_ports "som240_2_c41"] ;# Bank  64 VCCO - som240_2_c44 - IO_L12P_T1U_N10_GC_64
#set_property PACKAGE_PIN AF5 [get_ports "som240_2_c42"] ;# Bank  64 VCCO - som240_2_c44 - IO_L12N_T1U_N11_GC_64

create_clock -period 6.250 -name MEZZ4_RX1_P -waveform {0.000 3.125} [get_ports MEZZ4_RX1_P]

#-----------------------------------------------------------------------
# MEZZ4_RX2 (PLLOUT2)
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ4_RX2_P]
set_property IOSTANDARD LVDS [get_ports MEZZ4_RX2_N]
set_property PACKAGE_PIN AG9 [get_ports MEZZ4_RX2_P]
set_property PACKAGE_PIN AH9 [get_ports MEZZ4_RX2_N]
#set_property PACKAGE_PIN AG9 [get_ports "som240_2_c38"] ;# Bank  64 VCCO - som240_2_c44 - IO_L7P_T1L_N0_QBC_AD13P_64
#set_property PACKAGE_PIN AH9 [get_ports "som240_2_c39"] ;# Bank  64 VCCO - som240_2_c44 - IO_L7N_T1L_N1_QBC_AD13N_64

#-----------------------------------------------------------------------
# MEZZ4_RX3 (SGMII_RX) (inverted on the pcb) (reverted)
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ4_RX3_P]
set_property IOSTANDARD LVDS [get_ports MEZZ4_RX3_N]
set_property PACKAGE_PIN P7 [get_ports MEZZ4_RX3_P]
set_property PACKAGE_PIN P6 [get_ports MEZZ4_RX3_N]
#set_property PACKAGE_PIN P7 [get_ports "som240_2_c20"] ;# Bank  65 VCCO - som240_2_a44 - IO_L16P_T2U_N6_QBC_AD3P_65
#set_property PACKAGE_PIN P6 [get_ports "som240_2_c21"] ;# Bank  65 VCCO - som240_2_a44 - IO_L16N_T2U_N7_QBC_AD3N_65

#-----------------------------------------------------------------------
# MEZZ4_RX4 (inverted on the pcb) (reverted)
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MEZZ4_RX4_P]
set_property IOSTANDARD LVDS [get_ports MEZZ4_RX4_N]
set_property PACKAGE_PIN L7 [get_ports MEZZ4_RX4_P]
set_property PACKAGE_PIN L6 [get_ports MEZZ4_RX4_N]
#set_property PACKAGE_PIN L7 [get_ports "som240_2_b12"] ;# Bank  65 VCCO - som240_2_a44 - IO_L13P_T2L_N0_GC_QBC_65
#set_property PACKAGE_PIN L6 [get_ports "som240_2_b13"] ;# Bank  65 VCCO - som240_2_a44 - IO_L13N_T2L_N1_GC_QBC_65

#-----------------------------------------------------------------------
# DDMTD_Q0
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports DDMTD_QP0]
set_property IOSTANDARD LVDS [get_ports DDMTD_QN0]
set_property PACKAGE_PIN AG4 [get_ports DDMTD_QP0]
set_property PACKAGE_PIN AH4 [get_ports DDMTD_QN0]
#set_property PACKAGE_PIN AG4 [get_ports "som240_2_a38"] ;# Bank  64 VCCO - som240_2_c44 - IO_L19P_T3L_N0_DBC_AD9P_64
#set_property PACKAGE_PIN AH4 [get_ports "som240_2_a39"] ;# Bank  64 VCCO - som240_2_c44 - IO_L19N_T3L_N1_DBC_AD9N_64

#-----------------------------------------------------------------------
# DDMTD_Q1 (inverted on the pcb)
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports DDMTD_QP1]
set_property IOSTANDARD LVDS [get_ports DDMTD_QN1]
set_property PACKAGE_PIN AB4 [get_ports DDMTD_QP1]
set_property PACKAGE_PIN AB3 [get_ports DDMTD_QN1]
#set_property PACKAGE_PIN AB4 [get_ports "som240_2_c35"] ;# Bank  64 VCCO - som240_2_c44 - IO_L15P_T2L_N4_AD11P_64
#set_property PACKAGE_PIN AB3 [get_ports "som240_2_c36"] ;# Bank  64 VCCO - som240_2_c44 - IO_L15N_T2L_N5_AD11N_64

#-----------------------------------------------------------------------
# DDMTD_Q2 (inverted on the pcb)
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports DDMTD_QP2]
set_property IOSTANDARD LVDS [get_ports DDMTD_QN2]
set_property PACKAGE_PIN AC4 [get_ports DDMTD_QP2]
set_property PACKAGE_PIN AC3 [get_ports DDMTD_QN2]
#set_property PACKAGE_PIN AC4 [get_ports "som240_2_c32"] ;# Bank  64 VCCO - som240_2_c44 - IO_L14P_T2L_N2_GC_64
#set_property PACKAGE_PIN AC3 [get_ports "som240_2_c33"] ;# Bank  64 VCCO - som240_2_c44 - IO_L14N_T2L_N3_GC_64

#-----------------------------------------------------------------------
# DDMTD_Q3
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports DDMTD_QP3]
set_property IOSTANDARD LVDS [get_ports DDMTD_QN3]
set_property PACKAGE_PIN AG6 [get_ports DDMTD_QP3]
set_property PACKAGE_PIN AG5 [get_ports DDMTD_QN3]
#set_property PACKAGE_PIN AG6 [get_ports "som240_2_a29"] ;# Bank  64 VCCO - som240_2_c44 - IO_L10P_T1U_N6_QBC_AD4P_64
#set_property PACKAGE_PIN AG5 [get_ports "som240_2_a30"] ;# Bank  64 VCCO - som240_2_c44 - IO_L10N_T1U_N7_QBC_AD4N_64

#-----------------------------------------------------------------------
# DDMTD_Q4
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports DDMTD_QP4]
set_property IOSTANDARD LVDS [get_ports DDMTD_QN4]
set_property PACKAGE_PIN J7 [get_ports DDMTD_QP4]
set_property PACKAGE_PIN H7 [get_ports DDMTD_QN4]
#set_property PACKAGE_PIN J7 [get_ports "som240_2_a23"] ;# Bank  65 VCCO - som240_2_a44 - IO_L21P_T3L_N4_AD8P_65
#set_property PACKAGE_PIN H7 [get_ports "som240_2_a24"] ;# Bank  65 VCCO - som240_2_a44 - IO_L21N_T3L_N5_AD8N_65

#-----------------------------------------------------------------------
# DDMTD_D1
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports DDMTD_DP1]
set_property IOSTANDARD LVDS [get_ports DDMTD_DN1]
set_property PACKAGE_PIN AC9 [get_ports DDMTD_DP1]
set_property PACKAGE_PIN AD9 [get_ports DDMTD_DN1]
#set_property PACKAGE_PIN AC9 [get_ports "som240_2_d33"] ;# Bank  64 VCCO - som240_2_c44 - IO_L1P_T0L_N0_DBC_64
#set_property PACKAGE_PIN AD9 [get_ports "som240_2_d34"] ;# Bank  64 VCCO - som240_2_c44 - IO_L1N_T0L_N1_DBC_64

#-----------------------------------------------------------------------
# DDMTD_D2
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports DDMTD_DP2]
set_property IOSTANDARD LVDS [get_ports DDMTD_DN2]
set_property PACKAGE_PIN AE9 [get_ports DDMTD_DP2]
set_property PACKAGE_PIN AE8 [get_ports DDMTD_DN2]
#set_property PACKAGE_PIN AE9 [get_ports "som240_2_d30"] ;# Bank  64 VCCO - som240_2_c44 - IO_L2P_T0L_N2_64
#set_property PACKAGE_PIN AE8 [get_ports "som240_2_d31"] ;# Bank  64 VCCO - som240_2_c44 - IO_L2N_T0L_N3_64

#-----------------------------------------------------------------------
# DDMTD_D3
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports DDMTD_DP3]
set_property IOSTANDARD LVDS [get_ports DDMTD_DN3]
set_property PACKAGE_PIN AF7 [get_ports DDMTD_DP3]
set_property PACKAGE_PIN AF6 [get_ports DDMTD_DN3]
#set_property PACKAGE_PIN AF7 [get_ports "som240_2_d27"] ;# Bank  64 VCCO - som240_2_c44 - IO_L11P_T1U_N8_GC_64
#set_property PACKAGE_PIN AF6 [get_ports "som240_2_d28"] ;# Bank  64 VCCO - som240_2_c44 - IO_L11N_T1U_N9_GC_64

#-----------------------------------------------------------------------
# DDMTD_D4
#-----------------------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports DDMTD_DP4]
set_property IOSTANDARD LVDS [get_ports DDMTD_DN4]
set_property PACKAGE_PIN K8 [get_ports DDMTD_DP4]
set_property PACKAGE_PIN K7 [get_ports DDMTD_DN4]
#set_property PACKAGE_PIN K8 [get_ports "som240_2_d24"] ;# Bank  65 VCCO - som240_2_a44 - IO_L22P_T3U_N6_DBC_AD0P_65
#set_property PACKAGE_PIN K7 [get_ports "som240_2_d25"] ;# Bank  65 VCCO - som240_2_a44 - IO_L22N_T3U_N7_DBC_AD0N_65

#-----------------------------------------------------------------------
# MEZZ1_ABC
#-----------------------------------------------------------------------
#set_property IOSTANDARD LVTTL [get_ports MEZZ1_A]
#set_property IOSTANDARD LVTTL [get_ports MEZZ1_B]
#set_property IOSTANDARD LVTTL [get_ports MEZZ1_C]
#set_property PACKAGE_PIN AA13 [get_ports MEZZ1_A]
#set_property PACKAGE_PIN AB13 [get_ports MEZZ1_B]
#set_property PACKAGE_PIN W14 [get_ports MEZZ1_C]
#set_property PACKAGE_PIN AA13 [get_ports "som240_2_b52"] ;# Bank  44 VCCO - som240_2_d59 - IO_L7P_HDGC_44
#set_property PACKAGE_PIN AB13 [get_ports "som240_2_b53"] ;# Bank  44 VCCO - som240_2_d59 - IO_L7N_HDGC_44
#set_property PACKAGE_PIN W14 [get_ports "som240_2_b54"] ;# Bank  44 VCCO - som240_2_d59 - IO_L9P_AD11P_44

#-----------------------------------------------------------------------
# MEZZ2_ABC
#-----------------------------------------------------------------------
#set_property IOSTANDARD LVTTL [get_ports MEZZ2_A]
#set_property IOSTANDARD LVTTL [get_ports MEZZ2_B]
#set_property IOSTANDARD LVTTL [get_ports MEZZ2_C]
#set_property PACKAGE_PIN AE14 [get_ports MEZZ2_A]
#set_property PACKAGE_PIN AG14 [get_ports MEZZ2_B]
#set_property PACKAGE_PIN AH14 [get_ports MEZZ2_C]
#set_property PACKAGE_PIN AE14 [get_ports "som240_2_d56"] ;# Bank  44 VCCO - som240_2_d59 - IO_L1N_AD15N_44
#set_property PACKAGE_PIN AG14 [get_ports "som240_2_d57"] ;# Bank  44 VCCO - som240_2_d59 - IO_L2P_AD14P_44
#set_property PACKAGE_PIN AH14 [get_ports "som240_2_d58"] ;# Bank  44 VCCO - som240_2_d59 - IO_L2N_AD14N_44

#-----------------------------------------------------------------------
# MEZZ3_ABC
#-----------------------------------------------------------------------
#set_property IOSTANDARD LVTTL [get_ports MEZZ3_A]
#set_property IOSTANDARD LVTTL [get_ports MEZZ3_B]
#set_property IOSTANDARD LVTTL [get_ports MEZZ3_C]
#set_property PACKAGE_PIN AD14 [get_ports MEZZ3_A]
#set_property PACKAGE_PIN AD14 [get_ports MEZZ3_B]
#set_property PACKAGE_PIN AE15 [get_ports MEZZ3_C]
#set_property PACKAGE_PIN AD15 [get_ports "som240_2_d52"] ;# Bank  44 VCCO - som240_2_d59 - IO_L5P_HDGC_44
#set_property PACKAGE_PIN AD14 [get_ports "som240_2_d53"] ;# Bank  44 VCCO - som240_2_d59 - IO_L5N_HDGC_44
#set_property PACKAGE_PIN AE15 [get_ports "som240_2_d54"] ;# Bank  44 VCCO - som240_2_d59 - IO_L1P_AD15P_44

#-----------------------------------------------------------------------
# MEZZ4_ABC (SGMII_MDIO) (SGMII_MDC) (SGMII_RSTb)
#-----------------------------------------------------------------------
#set_property IOSTANDARD LVTTL [get_ports SGMII_MDIO]
#set_property IOSTANDARD LVTTL [get_ports SGMII_MDC]
#set_property IOSTANDARD LVTTL [get_ports SGMII_RSTb]
#set_property PACKAGE_PIN W13 [get_ports SGMII_MDIO]
#set_property PACKAGE_PIN AB15 [get_ports SGMII_MDC]
#set_property PACKAGE_PIN AB14 [get_ports SGMII_RSTb]
#set_property PACKAGE_PIN W13 [get_ports "som240_2_b56"] ;# Bank  44 VCCO - som240_2_d59 - IO_L9N_AD11N_44
#set_property PACKAGE_PIN AB15 [get_ports "som240_2_b57"] ;# Bank  44 VCCO - som240_2_d59 - IO_L8P_HDGC_44
#set_property PACKAGE_PIN AB14 [get_ports "som240_2_b58"] ;# Bank  44 VCCO - som240_2_d59 - IO_L8N_HDGC_44




