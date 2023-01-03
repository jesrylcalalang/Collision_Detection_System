module distance(clock, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, distance);
    reg [3:0] digit0;	// Initialize a variable to hold the 1st digit of the distance
    reg [3:0] digit1;	// Initialize a variable to hold the 2nd digit of the distance
    reg [3:0] digit2;	// Initialize a variable to hold the 3rd digit of the distance
    input logic clock;	// Initialize clock
    input reg [31:0] distance; // distance as input in cm
    output logic [7:0] HEX0;				// Initialize Hex Display output 
    output logic [7:0] HEX1;				// Initialize Hex Display output 
    output logic [7:0] HEX2;				// Initialize Hex Display output 
    output logic [7:0] HEX3 = 8'b11111111;	// Initialize Hex Display output, turn off all display segements 
    output logic [7:0] HEX4 = 8'b11111111;	// Initialize Hex Display output, turn off all display segements 
    output logic [7:0] HEX5 = 8'b11111111;	// Initialize Hex Display output, turn off all display segements 
	
	always@(posedge clock) begin
		digit0 =  distance % 10;		// retrieve 1st the digit from the distance variable
		digit1 = (distance / 10) % 10 ;	// retrieve 2nd the digit from the distance variable
		digit2 = (distance / 100) % 10;	// retrieve 3rd the digit from the distance variable

		// Display the correct digit on the Hex display 0
		case(digit0)
			4'h0 : HEX0 = 8'b11000000;
			4'h1 : HEX0 = 8'b11111001;
			4'h2 : HEX0 = 8'b10100100;
			4'h3 : HEX0 = 8'b10110000;
			4'h4 : HEX0 = 8'b10011001;
			4'h5 : HEX0 = 8'b10010010;
			4'h6 : HEX0 = 8'b10000010;
			4'h7 : HEX0 = 8'b11111000;
			4'h8 : HEX0 = 8'b10000000;
			4'h9 : HEX0 = 8'b10011000;
			default: HEX0 = 8'b11111111;
		endcase
		// Display the correct digit on the Hex display 1
		case(digit1)
			4'h0 : HEX1 = 8'b11000000;
			4'h1 : HEX1 = 8'b11111001;
			4'h2 : HEX1 = 8'b10100100;
			4'h3 : HEX1 = 8'b10110000;
			4'h4 : HEX1 = 8'b10011001;
			4'h5 : HEX1 = 8'b10010010;
			4'h6 : HEX1 = 8'b10000010;
			4'h7 : HEX1 = 8'b11111000;
			4'h8 : HEX1 = 8'b10000000;
			4'h9 : HEX1 = 8'b10011000;
			default: HEX1 = 8'b11111111;
		endcase
		// Display the correct digit on the Hex display 2
		case(digit2)
			4'h0 : HEX2 = 8'b11000000;
			4'h1 : HEX2 = 8'b11111001;
			4'h2 : HEX2 = 8'b10100100;
			4'h3 : HEX2 = 8'b10110000;
			4'h4 : HEX2 = 8'b10011001;
			4'h5 : HEX2 = 8'b10010010;
			4'h6 : HEX2 = 8'b10000010;
			4'h7 : HEX2 = 8'b11111000;
			4'h8 : HEX2 = 8'b10000000;
			4'h9 : HEX2 = 8'b10011000;
			default: HEX2 = 8'b11111111;
		endcase
	end
endmodule
