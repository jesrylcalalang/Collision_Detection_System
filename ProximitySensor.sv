module ProximitySensor(clock, trig, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, echo, distance, LEDR, clockout, RESET, buzz_clockout);
    // input and output pins for entire circuit
    input logic clock; 	        // PIN P11
    input logic echo;	        // PIN V10
    output logic trig;	        // PIN W10
    output reg buzz_clockout;   // PIN_V9

    input reg clockout;         // Used to store value of clock output
    input RESET;                // Used to Reset the circuit
    output reg [31:0] distance; // Used to store value of distance in meters
    output logic [9:0] LEDR;    // Initializes LEDs on boards
    output logic [7:0] HEX0;    // Initializes Hex Display on board
    output logic [7:0] HEX1;    // Initializes Hex Display on board
    output logic [7:0] HEX2;    // Initializes Hex Display on board
    output logic [7:0] HEX3 = 8'b11111111;  // Initializes Hex Display on board
    output logic [7:0] HEX4 = 8'b11111111;  // Initializes Hex Display on board
    output logic [7:0] HEX5 = 8'b11111111;  // Initializes Hex Display on board
    
    reg [31:0] microSecCtr = 0;     // Variable used to count duration in microseconds of ultasonic waves recieved
    reg [31:0] countTillOne = 0;    // Variable used to time 1 microseconds from 50mHz base clock
    reg [31:0] countTillTen = 0;    // Variable used to time 10 microseconds from 50mHz base clock
    reg [31:0] countTillForty = 0;  // Variable used to time 40 microseconds from 50mHz base clock

    reg sensorOn = 0;       // Variable used to turn on the ultasonic sensor to send ultrasonic waves

    wire [31:0]distanceWire;   // Wire used to pass the distance in meters to other modules 

    // Initialization of the other 2 modules
    distance dista (clock, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, distanceWire);
    buzzer buzz(clock, buzz_clockout, RESET, LEDR, distanceWire);

    // Turns the ultrasonic sensor on or off to start or stop sending ultasonic waves
    assign trig = sensorOn;
    
    always @(posedge clock) begin
        // If 10 microSeconds have elapsed and the sensor has remained on turn off the sensor
        if (countTillTen == 500 && sensorOn == 1)begin
            sensorOn <= 0;
        end

        // if 1 microsecond has elapsed then check if ultasound waves have been recieved
        // if yes then increment microSecCtr else calculate the distance using microSecCtr and pass the value to wire distanceWire
        if (countTillOne == 50) begin	
            if (echo == 1) begin
                microSecCtr <= microSecCtr + 1;
            end
            else if (microSecCtr != 0) begin
                distance <= microSecCtr / 58;
                microSecCtr <= 0;
                distanceWire <= distance;
            end
        end
        // If counter is currently at 50 reset it to 0 else increment it
        if(countTillOne == 50)begin
            countTillOne <= 0;
        end
        else begin
            countTillOne <= countTillOne+1;
        end
        // If counter is currently at 500 reset it to 0 else increment it
        if(countTillTen == 500)begin
            countTillTen <= 0;
        end
        else begin
            countTillTen <= countTillTen+1;
        end
        // If counter is currently at 2000000 reset it to 0 else increment it
        if(countTillForty == 2000000)begin
            countTillForty <= 0;
        end
        else begin
            countTillForty <= countTillForty+1;
        end
		 // If 40 microSeconds have elapsed then turn on the sensor
		 if (countTillForty == 0) begin
			  sensorOn <= 1;
		 end

	 end
    
endmodule
