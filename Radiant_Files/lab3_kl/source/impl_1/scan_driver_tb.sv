`timescale 1us/1ps
module scan_driver_tb(); 
	// test signals
	logic clk, reset;
	logic [3:0]col; 
	logic [15:0] key, keylatch; 
	logic scan_signal, enable_key, count_enable; 

	scan_driver dut(
		.clk(clk),
		.reset(reset),
		.col(col),
		.key(key),
		.keylatch(keylatch),
		.scan_signal(scan_signal),
		.enable_key(enable_key), 
		.count_enable(count_enable)
		);
		
	// make a clk: 
	always 
		begin 
			clk = 0; #5; clk = 1; #5; 
		end 
		
	// SCAN = 5'b00001, PRESS = 5'b00010, HOLD = 5'b00100, RESET = 5'b01000, CHECK = 5'b10000
	//tests:
	initial begin 
	// test 0: if reset = 0 do we stay in reset?
	reset = 0; 
	key = 16'd2; #22;
	assert (dut.state === 5'b01000) else $error("failed to stay on reset"); 

	// test 1: if key == 0 do we stay in SCAN? 
	key = 16'd0;
	reset = 1; #22;
	assert (dut.state === 5'b00001) else $error("failed to stay in SCAN when key = 0");
	
	// test 2: if key === 1 do we go to PRESS? 
	key = 16'd2; #2; 
	assert (dut.state === 5'b00010) else $error("failed to stay on PRESS when key = 16'd2");
	
	#100 $finish;
	
	end
	
endmodule
