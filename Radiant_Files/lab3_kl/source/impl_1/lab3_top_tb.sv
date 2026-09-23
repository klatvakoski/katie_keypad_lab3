`timescale 1 ms/1 ns
module lab3_top_tb (); 

	// test signals 
	logic reset'
	//input logic enable; 
	logic [3:0] col;
	logic [3:0] row;
	logic [3:0] disp1, disp2, chosen_disp;
	logic [6:0] seg;
	logic [1:0] chosen_pin;
	
	num_detector dut(
		.reset(reset),
		//.enable(enable),
		.col(col),
		.row(row),
		.disp1(disp1),
		.disp2(disp2),
		.chosen_disp(chosen_disp),
		.seg(seg),
		.chosen_pin(chosen_pin)
		);
	
	// tests: 
	initial begin
	
	// test 1: does it work when two columns are pressed in the same row at ~ the same time
	reset = 0; #22 // nothing start
	reset = 1; 
	row = 4'b0001; 
		col = 4'b1110; #2   // asserting columns to be flipped, which they are in lab3_top
		col = 4'b1101; #5   
		assert (num === 4'b0001) else $error("num failed on row 0, col 0");
		
	// test 2: does it work when different columns are pressed in different rows
	row = 4'b0010; 
	col = 4'b1110; #2
	row = 4'b0100; 
	col = 4'b0110; #7
	
  #100 $stop;
  end
  
endmodule 	