module lab3_top (
	input logic reset, 
	input logic enable, 
	input logic [3:0] col,
	output logic [3:0] row, 
	output logic [3:0] disp1, disp2, chosen_disp,
	output logic [6:0] seg,
	output logic [1:0] chosen_pin
	);
	
   localparam MAX_COUNT = 240000; // this is counting twice as fast as my code last time bc HSOSC
   localparam WIDTH = 18;   
   // logic for keypad stuff: 
   logic [3:0] key; 
   logic scan_signal; 
   
   // logic for mux/seven-seg stuff
   logic s;
   logic [3:0]chosen_dip; 
   logic [WIDTH-1:0] count; 
   logic int_osc; 						//to get clock signal
   
   // Internal high-speed oscillator -- 
   HSOSC #(.CLKHF_DIV(2'b00))
         hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
    
	// call all of the keypad mods: 
	scan_driver fsm(int_osc, reset,col, key, disp1, disp2, scan_signal); 
	keypad row_scanner(reset, scan_signal, int_osc, row);  // scan_signal used as enable for this mod. 
	num_detector out_numbers(reset, enable, col, row, int_osc, key);
	
	
	// call counter module for switching between the two LED segments
   counter #(MAX_COUNT,WIDTH) counting(reset, enable, int_osc, count);
   
   // flip s based on the counting module. Then it can choose dip1 or dip2
   // and which transistor pin is on vs off.    
	assign s = count > MAX_COUNT/2;

	// choose which display we're going to.
	assign chosen_disp = s ? disp1:disp2; 
	
	// choose which transistor pin is on vs off
	assign chosen_pin = {s,!s};
	
   // call display_led module for the seven-segment mapping
   led_display seven_disp(chosen_dip,seg);

endmodule 
