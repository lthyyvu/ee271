onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/HEX0
add wave -noupdate /DE1_SoC_testbench/HEX5
add wave -noupdate /DE1_SoC_testbench/LEDR
add wave -noupdate /DE1_SoC_testbench/KEY
add wave -noupdate /DE1_SoC_testbench/SW
add wave -noupdate /DE1_SoC_testbench/CLOCK_50
add wave -noupdate -label {SW[9] (Reset)} {/DE1_SoC_testbench/SW[9]}
add wave -noupdate /DE1_SoC_testbench/advance
add wave -noupdate /DE1_SoC_testbench/AUD_DACDAT
add wave -noupdate /DE1_SoC_testbench/AUD_BCLK
add wave -noupdate {/DE1_SoC_testbench/dut/allInstantiations[246]/bass_inst/out}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {512642464 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {5037500 ps} {2120787500 ps}
