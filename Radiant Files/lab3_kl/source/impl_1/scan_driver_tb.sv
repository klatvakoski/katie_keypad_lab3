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
	
endmodule