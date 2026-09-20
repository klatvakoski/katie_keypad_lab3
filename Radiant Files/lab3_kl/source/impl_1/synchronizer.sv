module synchronizer #(parameter WIDTH = 4)(
	input logic clk, 
	input logic [WIDTH-1:0]d, 
	output logic [WIDTH-1:0]d
	);
	
	logic n1;
	
	always_ff @(posedge clk)
	begin 
		n1 <= d;
		q <= n1; 
	end 
endmodule 