onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory_pdua_tb/clk_tb
add wave -noupdate /memory_pdua_tb/rst_tb
add wave -noupdate /memory_pdua_tb/DUT/CONTROL_UNIT/opcode
add wave -noupdate /memory_pdua_tb/DUT/CONTROL_UNIT/uaddr
add wave -noupdate /memory_pdua_tb/DUT/C
add wave -noupdate /memory_pdua_tb/DUT/N
add wave -noupdate /memory_pdua_tb/DUT/P
add wave -noupdate /memory_pdua_tb/DUT/Z
add wave -noupdate -childformat {{/memory_pdua_tb/DUT/REGISTER_BANK/array_reg(7) -radix binary}} -subitemconfig {/memory_pdua_tb/DUT/REGISTER_BANK/array_reg(7) {-height 15 -radix binary}} /memory_pdua_tb/DUT/REGISTER_BANK/array_reg
add wave -noupdate /memory_pdua_tb/DUT/RAM/ram
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {180918 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2100 ns}
