onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /wolfson_testbench/CLOCK_PERIOD
add wave -noupdate /wolfson_testbench/clock
add wave -noupdate /wolfson_testbench/AUD_XCK
add wave -noupdate /wolfson_testbench/AUD_DACLRCK
add wave -noupdate /wolfson_testbench/AUD_ADCLRCK
add wave -noupdate /wolfson_testbench/AUD_BCLK
add wave -noupdate /wolfson_testbench/AUD_ADCDAT
add wave -noupdate /wolfson_testbench/AUD_DACDAT
add wave -noupdate /wolfson_testbench/FPGA_I2C_SCLK
add wave -noupdate /wolfson_testbench/FPGA_I2C_SDAT
add wave -noupdate /wolfson_testbench/chip/counter
add wave -noupdate /wolfson_testbench/top/mainAudio/advance
add wave -noupdate /wolfson_testbench/top/audio_advance
add wave -noupdate /wolfson_testbench/top/fsm_advance
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2961405 ps} 0}
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
WaveRestoreZoom {0 ps} {3560434 ps}
