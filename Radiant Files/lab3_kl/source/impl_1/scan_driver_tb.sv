module scan_driver_tb(); 
	// test signals
	logic clk, reset;
	logic [3:0]col, key; 
	logic [3:0] d0, d1;
	logic scan_signal; 

	scan_driver dut(
		.clk(clk),
		.reset(reset),
		.col(col),
		.key(key),
		.d0(d0),
		.d1(d1),
		.scan_signal(scan_signal)
		);
		
	// make a clk: 
	always 
		begin 
			clk = 0; #5; clk = 1; #5; 
		end 
		
	// SCAN = 3'b001, PRESS = 3'b010, HOLD = 3'b100
	//tests:
	initial begin 
	// test 1: reset = 0, stay in scan
	reset = 0; 
	col = 4'b0111; #22;
	assert (dut.state === 3'b001) else $error("scan failed to stay on reset");
	
	// test 2: reset = 1, cols == 1111 stay in scan
	col = 4'b1111;
	reset = 1; #22; 
	assert (dut.state === 3'b001) else $error("scan failed to stay on cols = 1111");
	
	// test 3: col = 0111, we go to press; also test that if key = 0101, then d0 gets 0101
	key = 4'b0101;
	col = 4'b0111; #7; 
	assert (dut.state === 3'b010) else $error("press failed to appear on cols = 0111");	
	assert (d0 === 4'b0101) else $error("d0 failed to appear on key = 0101");
		
	// test 4: col = 0111, we go to hold 
	#9; 
	assert (dut.state === 3'b100) else $error("HOLD failed to appear on cols = 0111");
	
	// test 5: col = 0111, we stay in hold
	#22; 
	assert (dut.state === 3'b100) else $error("HOLD failed to stay on cols = 0111");
	
	// test 6: col = 1111, we go to scan
	col = 4'b1111; #22; 
	assert (dut.state === 3'b001) else $error("scan failed to appear on cols = 1111");
	
	// test 7: col = 1101, go to press, then col = 1111, we STILL go to hold; also test that if key = 1111, then d0 gets 1111 and d1 gets 0101 
	key = 4'b1111;
	col = 4'b1101; #8; 
	assert (dut.state === 3'b010) else $error("press failed to appear on cols = 1101");
	assert (d0 === 4'b1111) else $error("d0 failed to appear on key = 1111");
	assert (d1 === 4'b0101) else $error("d1 failed to appear on key = 1111");
		
	col = 4'b1111; #6; 
	assert (dut.state === 3'b100) else $error("HOLD failed to appear on cols = 1111");
		
	// test 8: if we get reset in hold, we go back to scan (even if cols != 1111)
	reset = 0; #22 
	assert (dut.state === 3'b001) else $error("scan failed to appear on reset");
	
	#100 $stop;
	
	end
	
endmodule