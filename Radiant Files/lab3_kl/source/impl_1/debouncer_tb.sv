`timescale 1 us/1 ns
module debouncer_tb(); 
	// test signals
	logic clk;
	logic reset;
	logic sw;
	logic debounce_sw;
	 	
	debouncer dut(
		.clk(clk),
		.reset(reset),
		.sw(sw),
		.debounce_sw(debounce_sw)
		);
	
	// make a clk
	always 
		begin
		clk = 0; #1; clk = 1; #1; 
		end 

	// test: check if given an oscillation on a switch, can we debounce
	// 8 bounces
	initial begin 
	reset = 0; 
	#20; 
	reset = 1; 
	sw = 0; #1000; 
	
	sw = 0; #1000;
	sw = 1; #1000;
	
	sw = 0; #1000;
	sw = 1; #1000; 
	
	sw = 0; #1000;
	sw = 1; #1000; 
	
	sw = 0; #1000;
	sw = 1; #1000;
	
	sw = 0; #5;
	sw = 1; #5; 
	
	sw = 0; #5;
	sw = 1; #5; 
	
	sw = 0; #5;
	sw = 1; #5; 
	
	sw = 0; #5;
	sw = 1; #5; 
	
	#20000; 
	
	assert (debounce_sw === 1) else $error("debounce_sw failed at sw = 0");
	
	sw = 0; #1000; 
	assert (debounce_sw === 0) else $error("debounce_sw failed at sw = 1");
		
  #100 $stop;
  end
  
endmodule 