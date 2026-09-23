`timescale 1 us/1 ns
module counter #(parameter MAX_COUNT = 120000, parameter WIDTH = 18)(
	input logic reset, 
	input logic enable,
	input logic clk,
	output logic [WIDTH-1:0]counter
);

	// Counter
   
	always_ff @(posedge clk) begin
		if (reset == 0) begin 
			counter <= 0;
			end 
		else if (enable) begin
			if (counter >= MAX_COUNT) begin
				counter <=0;
				end 
			else begin 
				counter <= counter + 1;
				end				
			end
		else begin 
			counter <= counter;
			end 
	end
  
  endmodule 