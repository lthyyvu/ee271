module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW,
					 FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT);
					 
					 
	input logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;
	
	logic advance;
	logic reset;
	assign reset = SW[9];
	

	// I2C Audio/Video config interface
	output FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	// Audio CODEC
	output AUD_XCK;
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input AUD_ADCDAT;
	output AUD_DACDAT;
	// Audio data
	
	logic [23:0] dac_left, dac_right;
	logic [23:0] adc_left, adc_right;
	assign adc_left = 24'b0;
	assign adc_right = 24'b0;

	
	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] div_clk;
	
	parameter whichClock = 2;
	clock_divider cdiv (.clock(CLOCK_50),
							  .reset(reset),
							  .divided_clocks(div_clk));
							  
	// Clock selection; allows for easy switching between sim and board clocks
	logic clkSelect;
	
	// Detect when we're in Quartus and use the divided clock,
	// otherwise assume we're in ModelSim and use the fast clock
	`ifdef ALTERA_RESERVED_QIS
		assign clkSelect = div_clk[whichClock]; // for board
	`else
		assign clkSelect = CLOCK_50; // for simulation
	`endif

	
	
	 
	 
	// advance is the input of module ?? that indicates
	//            a sample input is available
	//            when next sample of output audio is generated 
	audio_driver mainAudio(.CLOCK_50(clkSelect), .reset(reset), .dac_left(dac_left), .dac_right(dac_right), .adc_left(adc_left), .adc_right(adc_right), .advance(advance), 
								  .FPGA_I2C_SCLK(FPGA_I2C_SCLK), .FPGA_I2C_SDAT(FPGA_I2C_SDAT), .AUD_XCK(AUD_XCK), .AUD_DACLRCK(AUD_DACLRCK), .AUD_ADCLRCK(AUD_ADCLRCK), .AUD_BCLK(AUD_BCLK), .AUD_ADCDAT(AUD_ADCDAT), .AUD_DACDAT(AUD_DACDAT));
	
	scratch mainSong(.CLOCK_50(clkSelect), .reset(reset), .advance(advance), .dac_right(dac_right), .dac_left(dac_left), .switchMode(SW[8]),
						  .LEDR3(LEDR[3]), .LEDR2(LEDR[2]), .LEDR1(LEDR[1]), .LEDR0(LEDR[0]), .KEY0(KEY[0]), .KEY1(KEY[1]), .KEY2(KEY[2]), .KEY3(KEY[3]), .SW(SW[3:0])); 
								  
endmodule

	
	
`timescale 1 ns/ 1 ps
module DE1_SoC_testbench();

	logic       CLOCK_50;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	logic FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT;
	
	
	DE1_SoC dut(.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW,
					 .FPGA_I2C_SCLK, .FPGA_I2C_SDAT, .AUD_XCK, .AUD_DACLRCK, .AUD_ADCLRCK, .AUD_BCLK, .AUD_ADCDAT, .AUD_DACDAT);
					 

	
	// Set up a simulated clock.																						7
	parameter CLOCK_PERIOD = 10000;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	// Test the design.

	
endmodule 