module lab3_top (
	input logic clk, 
	input logic reset, 
	input logic enable, 
	output logic [3:0] row, 
	output logic [3:0] disp1, disp2
	);
   logic int_osc; 						//to get clock signal
    
   
   // Internal high-speed oscillator -- 
   HSOSC #(.CLKHF_DIV(2'b00))
         hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
