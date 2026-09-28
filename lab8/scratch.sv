module scratch(CLOCK_50, reset, advance, dac_right, dac_left, LEDR3, LEDR2, LEDR1, LEDR0, KEY3, KEY2, KEY1, KEY0, SW, switchMode);

	 input logic CLOCK_50, reset, advance;
    output logic LEDR3, LEDR2, LEDR1, LEDR0;
    output logic signed [23:0] dac_right, dac_left;
    input logic KEY3, KEY2, KEY1, KEY0;
    input logic [3:0] SW;
    input logic switchMode;

    logic signed [15:0] bassOut  [999:0];
    logic signed [15:0] snareOut [999:0];
    logic signed [15:0] samp3Out [999:0];
    logic signed [15:0] samp4Out [999:0];

    generate
        genvar i;
        for (i = 0; i < 999; i++) begin : allInstantiations
            bass_sample bass_inst(.index(i), .out(bassOut[i]));
            snare_sample snare_inst(.index(i), .out(snareOut[i]));
            sample3 samp3_inst(.index(i), .out(samp3Out[i]));
            sample4 samp4_inst(.index(i), .out(samp4Out[i]));
        end
    endgenerate

    logic [3:0] sequence_counter;
    logic [9:0] sample_counter;

    // Memory to store the programmed beat (16 steps, 4 bits per step)
    logic [3:0] programmed_beat [0:15];

    // Reset and beat programming logic
    always_ff @(posedge CLOCK_50) begin
        if (reset) begin
            sequence_counter <= 6'b0;
            sample_counter   <= 10'b0;
				
            for (int i = 0; i < 16; i++) begin
                programmed_beat[i] <= 4'b0000;
            end
        end else if (switchMode) begin
            // User is programming the beat
            if (advance) begin
                // Assign the selected instrument to the current step (SW[3:0])
                if (~KEY3) begin
                    programmed_beat[SW] <= 4'b1000; // Bass
                end else if (~KEY2) begin
                    programmed_beat[SW] <= 4'b0100; // Snare
                end else if (~KEY1) begin
                    programmed_beat[SW] <= 4'b0010; // Sample 3
                end else if (~KEY0) begin
                    programmed_beat[SW] <= 4'b0001; // Sample 4
                end
            end
        end else if (~reset && ~switchMode) begin
            // Playback mode
            if (advance) begin
                sample_counter <= sample_counter + 1;
                if (sample_counter == 999) begin
                    sample_counter <= 10'b0;
                    sequence_counter <= sequence_counter + 1;
                end
            end
        end
    end
	 
	 
	 
	 //   if hex2 == 
	 //       move on to hex 3: hex 3 == 1
	 // 
	 //
	 //
	 
	 //

    // Playback logic
    always_comb begin
        LEDR3 = 1'b0;
        LEDR2 = 1'b0;
        LEDR1 = 1'b0;
        LEDR0 = 1'b0;
        dac_right = 24'b0;
        dac_left  = 24'b0;

        if (~switchMode) begin
            // Play the programmed beat
            case (programmed_beat[sequence_counter[3:0]])
                4'b1000: begin // Bass
                    dac_right = {8'b0, bassOut[sample_counter]};
                    dac_left  = {8'b0, bassOut[sample_counter]};
                    LEDR3 = 1'b1;
                end
                4'b0100: begin // Snare
                    dac_right = {8'b0, snareOut[sample_counter]};
                    dac_left  = {8'b0, snareOut[sample_counter]};
                    LEDR2 = 1'b1;
                end
                4'b0010: begin // Sample 3
                    dac_right = {8'b0, samp3Out[sample_counter]};
                    dac_left  = {8'b0, samp3Out[sample_counter]};
                    LEDR1 = 1'b1;
                end
                4'b0001: begin // Sample 4
                    dac_right = {8'b0, samp4Out[sample_counter]};
                    dac_left  = {8'b0, samp4Out[sample_counter]};
                    LEDR0 = 1'b1;
                end
                default: begin // No instrument
                    dac_right = 24'b0;
                    dac_left  = 24'b0;
                end
            endcase
        end
    end

endmodule

`timescale 1 ns/ 1 ps
module scratch_testbench();

	 logic CLOCK_50, advance, reset;
	 logic LEDR3, LEDR2, LEDR1, LEDR0;
	 logic signed [23:0] dac_right, dac_left;
	 logic KEY3, KEY2, KEY1, KEY0;
	 logic [3:0] SW;
	 logic switchMode;
	 
	 	 scratch dut(.*);
		 
		// Set up a simulated clock.
	parameter CLOCK_PERIOD = 100000000;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end

	 
	 initial begin
		reset <= 1;       @(posedge CLOCK_50);
		reset <= 0;       @(posedge CLOCK_50);
		advance <= 1;      @(posedge CLOCK_50);
		advance <= 0;     repeat(10)  @(posedge CLOCK_50);
		advance <= 1;       @(posedge CLOCK_50);
		advance <= 0;     repeat(10) @(posedge CLOCK_50);
		advance <= 1;       @(posedge CLOCK_50);
		advance <= 0;     repeat(10) @(posedge CLOCK_50);
		advance <= 1; switchMode <= 1; SW[3:0] = 4'b0000; KEY3 = 0; @(posedge CLOCK_50);
		advance <= 1; switchMode <= 1; SW[3:0] = 4'b0000; KEY3 = 1; @(posedge CLOCK_50);
		advance <= 1; switchMode <= 1; SW[3:0] = 4'b0001; KEY2 = 0; @(posedge CLOCK_50);
		advance <= 1; switchMode <= 1; SW[3:0] = 4'b0001; KEY2 = 1; @(posedge CLOCK_50);
		advance <= 1; switchMode <= 1; SW[3:0] = 4'b0010; KEY2 = 0; @(posedge CLOCK_50);
		advance <= 1; switchMode <= 1; SW[3:0] = 4'b0010; KEY2 = 1; @(posedge CLOCK_50);
		advance <= 1; switchMode <= 1; SW[3:0] = 4'b0011; KEY3 = 0; @(posedge CLOCK_50);
		advance <= 1; switchMode <= 1; SW[3:0] = 4'b0011; KEY3 = 1; @(posedge CLOCK_50);
		advance <= 1; switchMode <= 1; SW[3:0] = 4'b0100; KEY0 = 0; @(posedge CLOCK_50);
		advance <= 1; switchMode <= 1; SW[3:0] = 4'b0100; KEY0 = 1; @(posedge CLOCK_50);		
		advance <= 1; switchMode <= 1; SW[3:0] = 4'b0101; KEY2 = 0; @(posedge CLOCK_50);											
		advance <= 1; switchMode <= 1; SW[3:0] = 4'b0101; KEY2 = 1; @(posedge CLOCK_50);	
		advance <= 1; switchMode <= 0; repeat(10000) @(posedge CLOCK_50);
		reset <= 1; repeat(10000) @(posedge CLOCK_50);
		
	 $stop;
	 end
	 
 endmodule
	
	