# Collision_Detection_System
Group project for EECS3201 using a DE-10 Lite FPGA, HC-SR04 sensor, and buzzer.
This project was programmed using SystemVerilog.
A collision detection system for automobiles that will assist drivers while parking in urban environments. 
The system uses an ultrasonic sensor as input and uses 3 HEX displays, LEDs, and a buzzer as outputs to assist the driver. 
The system will detect the distance between the car and its surroundings. 
The buzzer and first LED (LEDR[0]) on the board will function in sync, and the next 3 LEDs will indicate the distance along with the hexadecimal. 
The hexadecimal displays the distance between the car and surroundings in centimetres. 
Three alarm levels (low, medium, high) depending on the measured distance.
