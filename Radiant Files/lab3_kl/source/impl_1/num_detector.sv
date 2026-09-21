module num_detector (
	input logic reset, enable,
	input logic [3:0] col, row,
	input logic clk,
	output logic [3:0] num
	);

	logic [3:0] synced_col, debounce_col;
	
	// synchronize the column input 
	synchronizer #(4) sync(clk, col, synced_col);
	
	//debounce the column input 
	genvar i; 
	generate 
		for (i = 0; i < 4; i++) begin : debouncing_loop
			debouncer debounce(clk, reset, synced_col[i], debounce_col[i]);
		end
	endgenerate 
	
	// assign each number a bit? 
	always_comb begin 
		// row 0
		if (row[0]) begin 
			if (col[0]) num = 4'b0001; 
			else if (col[1]) num = 4'b0010; 
			else if (col[2]) num = 4'b0011;
			else if (col[3]) num = 4'b1010;
			else num = 4'b0000;		// no latch
			end 
		// row 1
		else if (row[1]) begin 
			if (col[0]) num = 4'b0100; 
			else if (col[1]) num = 4'b0101; 
			else if (col[2]) num = 4'b0110;
			else if (col[3]) num = 4'b1011;
			else num = 4'b0000; 
			end 
		else if (row[2]) begin 
			if (col[0]) num = 4'b0111; 
			else if (col[1]) num = 4'b1000; 
			else if (col[2]) num = 4'b1001;
			else if (col[3]) num = 4'b1100;
			else num = 4'b0000; 
			end 
		else if (row[3]) begin 
			if (col[0]) num = 4'b1110; 
			else if (col[1]) num = 4'b0000; 
			else if (col[2]) num = 4'b1111;
			else if (col[3]) num = 4'b1101;
			else num = 4'b0000; 
			end 
		end 
endmodule 		
	