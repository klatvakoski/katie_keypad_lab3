module scan_driver(
	input logic clk, reset,
	input logic [3:0]col, key, 
	output logic [3:0] row,
	output logic [3:0] d0, d1
	); 
	
	typedef enum logic [2:0] {SCAN = 3'b0001, PRESS = 3'b010, HOLD = 3'b100} statetype;
	statetype state, nextstate;
	logic any_key; 
	
	assign any_key = ~&col; 		// ands all of the bits of col together; if a column is low (pushed) then any_key will be 1
	
	always_ff @(posedge clk, posedge reset)
		if (reset) state <= SCAN; 
		else state <= nextstate; 
	
	always_comb
		case (state)
			SCAN: nextstate = any_key ? PRESS:SCAN; // if column pressed, we go to the PRESS state, if not keep scanning
			PRESS: nextstate = HOLD; 	// we always go to hold after press, no matter what
			HOLD: nextstate = any_key ? HOLD:SCAN; // if column pressed, stay on hold if not go back to scanning
			default: nextstate = SCAN; 
		endcase
	
	always_ff @(posedge clk, posedge reset) 
		if (reset) begin
			d0 <= 4'h0; 
			d1 <= 4'h0; 
		end 
		else begin 
			if (state == SCAN && !any_key) // add some sort of signal here that tells my rows to start scanning. once i get a column then debounce/sync that one column and feed it into the decoder
			
			if (state == PRESS) begin
				d1 <= d0; 	// shifts the digital output 
				d0 <= key; 
			end 
		end 
	
	