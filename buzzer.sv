module buzzer(clock, buzz_clockout, RESET, LEDR, distance);
	input RESET;				// Used to reset the circuit
	input logic clock;			// clock used to time the buzzing
	input reg [31:0] distance;	// distance calculated by other module

	output reg buzz_clockout;	// Variable to turn the buzzer on and off
	output reg [9:0] LEDR;		// Initialize all LEDs on board

	parameter buzzLv1 = 32'd25000000;	// Used for slow buzzer frequency
	parameter buzzLv2 = 32'd12500000;	// Used for medium buzzer frequency
	parameter buzzLv3 = 32'd3125000; 	// Used for fast buzzer frequency

	reg [31:0] freq;			// Used to store the frequency at which buzzer operates
	reg [63:0] buzz_counter;	// Counter to buzz buzzer at correct frequency
	integer level;				// Variable used to indicate how fast buzzer should buzz
		
	always @(distance) begin
		LEDR[1] <= 0;	// Turn off all LED[1] 
		LEDR[2] <= 0;	// Turn off all LED[2] 
		LEDR[3] <= 0;	// Turn off all LED[3] 
		
		// If distance is under 25 cm assign level 3 for fast buzzing and turn on LED[1]
		if(distance < 25) begin
			level = 3;
			LEDR[1] <= 1;
		end
		// If distance is under 50 cm assign level 2 for medium buzzing and turn on LED[2]
		else if(distance < 50) begin
			level = 2;
			LEDR[2] <= 1;
		end
		// If distance is under 100 cm assign level 1 for slow buzzing and turn on LED[3]
		else if(distance < 100) begin
			level = 1;
			LEDR[3] <= 1;
		end
		// If distance is greater than 100 cm do not buzz and no LED is ON
		else begin
			level = 0;
		end
	end
	
	always @(posedge clock) begin
		// If circuit is in normal state
		if(!RESET) begin
			// Assign freq to correct frequency based on level
			case(level)
				1 : freq = buzzLv1;
				2 : freq = buzzLv2;
				3 : freq = buzzLv3;
				default : freq = 0;
			endcase
			// If level is 0 then reset the buzz counter, turn off buzzing LED and buzzer
			if (!clock || level == 0) begin
				buzz_clockout <= 0;
				buzz_counter <= 32'd0;
				LEDR[0] <= 0;
			end
			// Else increment buzz counter and if buzz counter is at current frequency then reset buzz counter and invert buzzer output and LED output
			else begin 
				buzz_counter <= buzz_counter + 1;
				if(buzz_counter >= freq) begin
					buzz_counter <= 32'd0;
					buzz_clockout <= ~buzz_clockout;
					LEDR[0] <= ~LEDR[0];
				end
			end
		end
		// if circuit is reset, reset buzz_clockout counter and turn off buzzing LED
		else begin
				buzz_clockout <= 0;
				LEDR[0] <= 0;
		end
	end
endmodule
