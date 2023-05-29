# PINOUT

#Clock
set_property PACKAGE_PIN U22 [get_ports clk_50]
set_property IOSTANDARD LVCMOS33 [get_ports clk_50]

#Leds QMTECH
set_property PACKAGE_PIN T23 [get_ports LED5]
set_property IOSTANDARD LVCMOS33 [get_ports LED5]
set_property PACKAGE_PIN R23 [get_ports LED6]
set_property IOSTANDARD LVCMOS33 [get_ports LED6]

#Buttons QMTECH
set_property PACKAGE_PIN P4 [get_ports SW2]
set_property IOSTANDARD LVCMOS33 [get_ports SW2]

#####################################################
# Correspondence J9 (DECA CAPE) to  U4 (QMTECH A100T)
# even (parell) = -3   e.g.  J9:12 = U4:9
# odd  (senar)  = -1   e.g.  J9:11 = U4:10
#####################################################

#Keyboard and mouse  (P11=10, P12=9, P10=7, P9=8)
set_property PACKAGE_PIN A4 [get_ports ps2_clk]
set_property IOSTANDARD LVCMOS33 [get_ports ps2_clk]
set_property PULLUP true [get_ports ps2_clk]
set_property PACKAGE_PIN B4 [get_ports ps2_data]
set_property IOSTANDARD LVCMOS33 [get_ports ps2_data]
set_property PULLUP true [get_ports ps2_data]
set_property PACKAGE_PIN B5 [get_ports mouse_clk]
set_property IOSTANDARD LVCMOS33 [get_ports mouse_clk]
set_property PULLUP true [get_ports ps2_data]
set_property PACKAGE_PIN A5 [get_ports mouse_data]
set_property IOSTANDARD LVCMOS33 [get_ports mouse_data]
set_property PULLUP true [get_ports mouse_data]


# Video output
# 14=11, 13=12
set_property PACKAGE_PIN A3 [get_ports vga_hs]
set_property IOSTANDARD LVCMOS33 [get_ports vga_hs]
set_property PACKAGE_PIN A2 [get_ports vga_vs]
set_property IOSTANDARD LVCMOS33 [get_ports vga_vs]

# set_property PACKAGE_PIN  [get_ports {vga_r[5]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[5]}]
# set_property PACKAGE_PIN  [get_ports {vga_r[4]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[4]}]
# 22=19, 24=21, 26=23, 16=13
set_property PACKAGE_PIN C1 [get_ports {vga_r[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[3]}]
set_property PACKAGE_PIN E1 [get_ports {vga_r[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[2]}]
set_property PACKAGE_PIN F2 [get_ports {vga_r[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[1]}]
set_property PACKAGE_PIN D4 [get_ports {vga_r[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[0]}]

# set_property PACKAGE_PIN  [get_ports {vga_g[5]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[5]}]
# set_property PACKAGE_PIN  [get_ports {vga_g[4]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[4]}]
# 18=15, 19=18, 20=17, 17=16
set_property PACKAGE_PIN C2 [get_ports {vga_g[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[3]}]
set_property PACKAGE_PIN D5 [get_ports {vga_g[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[2]}]
set_property PACKAGE_PIN E5 [get_ports {vga_g[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[1]}]
set_property PACKAGE_PIN B2 [get_ports {vga_g[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[0]}]

# set_property PACKAGE_PIN  [get_ports {vga_b[5]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[5]}]
# set_property PACKAGE_PIN  [get_ports {vga_b[4]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[4]}]
# 21=20, 23=22, 25=24, 15=14
set_property PACKAGE_PIN B1 [get_ports {vga_b[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[3]}]
set_property PACKAGE_PIN D1 [get_ports {vga_b[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[2]}]
set_property PACKAGE_PIN E2 [get_ports {vga_b[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[1]}]
set_property PACKAGE_PIN C4 [get_ports {vga_b[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[0]}]

#Audio
# 27=26, 28=25
set_property PACKAGE_PIN F4 [get_ports pwm_audio_out_l]
set_property IOSTANDARD LVCMOS33 [get_ports pwm_audio_out_l]
set_property PACKAGE_PIN G4 [get_ports pwm_audio_out_r]
set_property IOSTANDARD LVCMOS33 [get_ports pwm_audio_out_r]

#Joystick
# 35=34, 36=33, 37=36, 38=35, 40=37, 39=38, 33=32
set_property PACKAGE_PIN G9 [get_ports JOY1_B2_P9]
set_property IOSTANDARD LVCMOS33 [get_ports JOY1_B2_P9]
set_property PULLUP true [get_ports JOY1_B2_P9]
set_property PACKAGE_PIN H9 [get_ports JOY1_B1_P6]
set_property IOSTANDARD LVCMOS33 [get_ports JOY1_B1_P6]
set_property PULLUP true [get_ports JOY1_B1_P6]
set_property PACKAGE_PIN L2 [get_ports JOY1_UP]
set_property IOSTANDARD LVCMOS33 [get_ports JOY1_UP]
set_property PULLUP true [get_ports JOY1_UP]
set_property PACKAGE_PIN M2 [get_ports JOY1_DOWN]
set_property IOSTANDARD LVCMOS33 [get_ports JOY1_DOWN]
set_property PULLUP true [get_ports JOY1_DOWN]
set_property PACKAGE_PIN L5 [get_ports JOY1_LEFT]
set_property IOSTANDARD LVCMOS33 [get_ports JOY1_LEFT]
set_property PULLUP true [get_ports JOY1_LEFT]
set_property PACKAGE_PIN K5 [get_ports JOY1_RIGHT]
set_property IOSTANDARD LVCMOS33 [get_ports JOY1_RIGHT]
set_property PULLUP true [get_ports JOY1_RIGHT]
set_property PACKAGE_PIN H1 [get_ports JOYX_SEL_O]
set_property IOSTANDARD LVCMOS33 [get_ports JOYX_SEL_O]


#####################################################
# Correspondence J8 (DECA CAPE) to  U2 (QMTECH A100T)
# even (parell) = +3   e.g.  J8:8 = U2:11
# odd  (senar)  = +5   e.g.  J8:7 = U2:12 
#####################################################


#SD
set_property PACKAGE_PIN W25 [get_ports sd_clk]
set_property IOSTANDARD LVCMOS33 [get_ports sd_clk]
set_property PACKAGE_PIN Y25 [get_ports sd_cs_n]
set_property IOSTANDARD LVCMOS33 [get_ports sd_cs_n]
set_property PACKAGE_PIN W21 [get_ports sd_miso]
set_property IOSTANDARD LVCMOS33 [get_ports sd_miso]
set_property PULLUP true [get_ports sd_miso]
set_property PACKAGE_PIN AB24 [get_ports sd_mosi]
set_property IOSTANDARD LVCMOS33 [get_ports sd_mosi]


###### PMOD 3

#SPI
# 31=30, J8:5=U2:10, 29=28, 30=27, J8:6=U2:9, 42=39
set_property PACKAGE_PIN H4 [get_ports SPI_SCLK]
set_property IOSTANDARD LVCMOS33 [get_ports SPI_SCLK]
set_property PACKAGE_PIN E25 [get_ports SPI_CS0]
set_property IOSTANDARD LVCMOS33 [get_ports SPI_CS0]
set_property PACKAGE_PIN G1 [get_ports SPI_MISO]
set_property IOSTANDARD LVCMOS33 [get_ports SPI_MISO]
#set_property PULLUP true [get_ports SPI_MISO]
set_property PACKAGE_PIN G2 [get_ports SPI_MOSI]
set_property IOSTANDARD LVCMOS33 [get_ports SPI_MOSI]
set_property PACKAGE_PIN D25 [get_ports SPI_CS1]
set_property IOSTANDARD LVCMOS33 [get_ports SPI_CS1]
set_property PACKAGE_PIN M4 [get_ports SPI_CS2]
set_property IOSTANDARD LVCMOS33 [get_ports SPI_CS2]

#UART
# J8:3=U2:8, J8:4=U2:7
set_property PACKAGE_PIN E26 [get_ports UART_TXD]
set_property IOSTANDARD LVCMOS33 [get_ports UART_TXD]
set_property PACKAGE_PIN D26 [get_ports UART_RXD]
set_property IOSTANDARD LVCMOS33 [get_ports UART_RXD]

###### END PMOD 3

# #Flash SPI
# set_property PACKAGE_PIN T4 [get_ports flash_clk]
# set_property IOSTANDARD LVCMOS33 [get_ports flash_clk]
# set_property PACKAGE_PIN T19 [get_ports flash_cs_n]
# set_property IOSTANDARD LVCMOS33 [get_ports flash_cs_n]
# set_property PACKAGE_PIN R22 [get_ports flash_miso]
# # DQ1
# set_property IOSTANDARD LVCMOS33 [get_ports flash_miso]  
# set_property PULLUP true [get_ports flash_miso]
# # DQ0
# set_property PACKAGE_PIN P22 [get_ports flash_mosi]
# set_property IOSTANDARD LVCMOS33 [get_ports flash_mosi]  
# #set_property PACKAGE_PIN P21 [get_ports flash_dq2]
# #set_property IOSTANDARD LVCMOS33 [get_ports flash_sclk]
# #set_property PACKAGE_PIN R21 [get_ports flash_dq3]
# #set_property IOSTANDARD LVCMOS33 [get_ports flash_sclk]


#
# SDRAM signals
#
set_property PACKAGE_PIN M26 [get_ports sdram_clk]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_clk]
set_property PACKAGE_PIN AA25  [get_ports sdram_cke]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_cke]

set_property PACKAGE_PIN AC24 [get_ports sdram_dqmh_n]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dqmh_n]
set_property PACKAGE_PIN Y21 [get_ports sdram_dqml_n]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dqml_n]

set_property PACKAGE_PIN R25 [get_ports sdram_cas_n]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_cas_n]
set_property PACKAGE_PIN P25 [get_ports sdram_ras_n]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_ras_n]
set_property PACKAGE_PIN N21 [get_ports sdram_we_n]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_we_n]
set_property PACKAGE_PIN T24 [get_ports sdram_cs_n]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_cs_n]

set_property PACKAGE_PIN U21 [get_ports sdram_ba[1]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_ba[1]]
set_property PACKAGE_PIN T25 [get_ports sdram_ba[0]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_ba[0]]

set_property PACKAGE_PIN N26 [get_ports sdram_addr[12]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_addr[12]]
set_property PACKAGE_PIN L23 [get_ports sdram_addr[11]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_addr[11]]
set_property PACKAGE_PIN V21 [get_ports sdram_addr[10]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_addr[10]]
set_property PACKAGE_PIN L22 [get_ports sdram_addr[9]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_addr[9]]
set_property PACKAGE_PIN P26 [get_ports sdram_addr[8]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_addr[8]]
set_property PACKAGE_PIN R26 [get_ports sdram_addr[7]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_addr[7]]
set_property PACKAGE_PIN M25 [get_ports sdram_addr[6]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_addr[6]]
set_property PACKAGE_PIN M24 [get_ports sdram_addr[5]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_addr[5]]
set_property PACKAGE_PIN N22 [get_ports sdram_addr[4]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_addr[4]]
set_property PACKAGE_PIN Y23 [get_ports sdram_addr[3]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_addr[3]]
set_property PACKAGE_PIN Y22 [get_ports sdram_addr[2]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_addr[2]]
set_property PACKAGE_PIN W23 [get_ports sdram_addr[1]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_addr[1]]
set_property PACKAGE_PIN V23 [get_ports sdram_addr[0]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_addr[0]]

set_property PACKAGE_PIN H26 [get_ports sdram_dq[0]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[0]]
set_property PACKAGE_PIN G26 [get_ports sdram_dq[1]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[1]]
set_property PACKAGE_PIN F23 [get_ports sdram_dq[2]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[2]]
set_property PACKAGE_PIN E23 [get_ports sdram_dq[3]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[3]]
set_property PACKAGE_PIN G22 [get_ports sdram_dq[4]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[4]]
set_property PACKAGE_PIN F22 [get_ports sdram_dq[5]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[5]]
set_property PACKAGE_PIN J25 [get_ports sdram_dq[6]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[6]]
set_property PACKAGE_PIN J26 [get_ports sdram_dq[7]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[7]]
set_property PACKAGE_PIN K23 [get_ports sdram_dq[8]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[8]]
set_property PACKAGE_PIN K22 [get_ports sdram_dq[9]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[9]]
set_property PACKAGE_PIN K26 [get_ports sdram_dq[10]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[10]]
set_property PACKAGE_PIN K25 [get_ports sdram_dq[11]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[11]]
set_property PACKAGE_PIN J21 [get_ports sdram_dq[12]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[12]]
set_property PACKAGE_PIN K21 [get_ports sdram_dq[13]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[13]]
set_property PACKAGE_PIN G20 [get_ports sdram_dq[14]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[14]]
set_property PACKAGE_PIN G21 [get_ports sdram_dq[15]]
set_property IOSTANDARD LVCMOS33 [get_ports sdram_dq[15]]


#SRAM
# set_property PACKAGE_PIN U18 [get_ports {sram_addr[0]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[0]}]
# set_property PACKAGE_PIN AB18 [get_ports {sram_addr[1]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[1]}]
# set_property PACKAGE_PIN P15 [get_ports {sram_addr[2]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[2]}]
# set_property PACKAGE_PIN T18 [get_ports {sram_addr[3]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[3]}]
# set_property PACKAGE_PIN R17 [get_ports {sram_addr[4]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[4]}]
# set_property PACKAGE_PIN P14 [get_ports {sram_addr[5]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[5]}]
# set_property PACKAGE_PIN AB3 [get_ports {sram_addr[6]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[6]}]
# set_property PACKAGE_PIN Y3 [get_ports {sram_addr[7]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[7]}]
# set_property PACKAGE_PIN R14 [get_ports {sram_addr[8]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[8]}]
# set_property PACKAGE_PIN T3 [get_ports {sram_addr[9]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[9]}]
# set_property PACKAGE_PIN P16 [get_ports {sram_addr[10]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[10]}]
# set_property PACKAGE_PIN AA3 [get_ports {sram_addr[11]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[11]}]
# set_property PACKAGE_PIN P17 [get_ports {sram_addr[12]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[12]}]
# set_property PACKAGE_PIN AB2 [get_ports {sram_addr[13]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[13]}]
# set_property PACKAGE_PIN AA18 [get_ports {sram_addr[14]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[14]}]
# set_property PACKAGE_PIN Y2 [get_ports {sram_addr[15]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[15]}]
# set_property PACKAGE_PIN Y1 [get_ports {sram_addr[16]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[16]}]
# set_property PACKAGE_PIN W1 [get_ports {sram_addr[17]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[17]}]
# set_property PACKAGE_PIN V3 [get_ports {sram_addr[18]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_addr[18]}]

# set_property PACKAGE_PIN N17 [get_ports {sram_dq[0]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[0]}]
# set_property PACKAGE_PIN AA5 [get_ports {sram_dq[1]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[1]}]
# set_property PACKAGE_PIN N14 [get_ports {sram_dq[2]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[2]}]
# set_property PACKAGE_PIN N13 [get_ports {sram_dq[3]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[3]}]
# set_property PACKAGE_PIN R16 [get_ports {sram_dq[4]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[4]}]
# set_property PACKAGE_PIN AA1 [get_ports {sram_dq[5]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[5]}]
# set_property PACKAGE_PIN AB1 [get_ports {sram_dq[6]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[6]}]
# set_property PACKAGE_PIN U3 [get_ports {sram_dq[7]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {sram_dq[7]}]

# set_property PACKAGE_PIN N15 [get_ports sram_we_n]
# set_property IOSTANDARD LVCMOS33 [get_ports sram_we_n]
