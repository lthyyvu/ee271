onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /scratch_testbench/CLOCK_PERIOD
add wave -noupdate /scratch_testbench/CLOCK_50
add wave -noupdate /scratch_testbench/advance
add wave -noupdate /scratch_testbench/reset
add wave -noupdate /scratch_testbench/LEDR3
add wave -noupdate /scratch_testbench/LEDR2
add wave -noupdate /scratch_testbench/LEDR1
add wave -noupdate /scratch_testbench/LEDR0
add wave -noupdate /scratch_testbench/dac_right
add wave -noupdate /scratch_testbench/dac_left
add wave -noupdate /scratch_testbench/KEY3
add wave -noupdate /scratch_testbench/KEY2
add wave -noupdate /scratch_testbench/KEY1
add wave -noupdate /scratch_testbench/KEY0
add wave -noupdate /scratch_testbench/SW
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3728531540848 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {15277500 us}
