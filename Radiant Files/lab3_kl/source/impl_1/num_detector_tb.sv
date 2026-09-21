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
			clk = 0; #1; clk = 1; #1; 
		end 
	
	// tests: 
	initial begin
	
	// test 1: row 0 tests
	reset = 0; #22 // nothing start
	reset = 1; 
	row = 4'b0001; 
		col = 4'b0001; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b0001) else $error("num failed on row 0, col 0");
		col = 4'b0010; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b0010) else $error("num failed on row 0, col 1");
		col = 4'b0100; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b0011) else $error("num failed on row 0, col 2");
		col = 4'b1000; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b1010) else $error("num failed on row 0, col 3");
			
	// test 2: row 1 tests
	row = 4'b0010; 
		col = 4'b0001; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b0100) else $error("num failed on row 1, col 0");
		col = 4'b0010; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b0101) else $error("num failed on row 1, col 1");
		col = 4'b0100; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b0110) else $error("num failed on row 1, col 2");
		col = 4'b1000; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b1011) else $error("num failed on row 1, col 3");
	
	// test 3: row 2 tests 
	row = 4'b0100; 
		col = 4'b0001; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b0111) else $error("num failed on row 2, col 0");
		col = 4'b0010; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b1000) else $error("num failed on row 2, col 1");
		col = 4'b0100; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b1001) else $error("num failed on row 2, col 2");
		col = 4'b1000; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b1100) else $error("num failed on row 2, col 3");
	
	// test 4: row 3 tests 
	row = 4'b1000; 
		col = 4'b0001; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b1110) else $error("num failed on row 3, col 0");
		col = 4'b0010; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b0000) else $error("num failed on row 3, col 1");
		col = 4'b0100; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b1111) else $error("num failed on row 3, col 2");
		col = 4'b1000; #1000   // asserting columns as if they were flipped, which they are in lab3_top
		assert (num === 4'b1101) else $error("num failed on row 3, col 3");
	

  #100 $stop;
  end
  
endmodule 
		