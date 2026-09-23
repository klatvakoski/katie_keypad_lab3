module latch_mod (
	input logic clk, reset, enable, 
	input logic [3:0] decoded_key,
	output logic [3:0] d0, d1,
	); 

always_ff @(posedge clk, negedge reset) 
		if (~reset) begin
			d0 <= 4'h0; 
			d1 <= 4'h0; 
			scan_signal <= 0; 
			end 
		else if (enable) begin 
			d1 <= d0; 	// shifts the digital output 
			d0 <= key; 
			end 
		else begin 		//stays the same
			d0 <= d0; 
			d1 <= d1; 
			end 
		end 
		
endmodule 