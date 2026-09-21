`timescale 1 us/1 ns
module num_detector_tb(); 
	// test signals
	logic reset;
	logic [3:0]col, row; 
	logic clk;
	logic [3:0] num;
	logic [3:0] debounce_col;

	num_detector dut(
		.reset(reset),
		.col(col),
		.row(row),
		.clk(clk),
		.num(num),
		.debounce_col(debounce_col)
		);
		
	// make a clk: 
	always 
		begin 
			clk = 0; #5; clk = 1; #5; 
		end 
	
	// tests: 
	initial begin
	
	// test 1: row 0 tests
	reset = 0; #22 // nothing start
	reset = 1; 
	row = 4'b0001; 
	col = 4'b0001; #22   // asserting columns as if they were flipped, which they are in lab3_top
	assert (num === 4'b0001) else $error("num failed on row 0, col 0");

  #100 $stop;
  end
  
endmodule 
		