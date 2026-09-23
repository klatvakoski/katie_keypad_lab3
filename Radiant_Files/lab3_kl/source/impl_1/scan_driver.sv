module scan_driver(
	input logic clk, reset,
	input logic [3:0]col, 
	input logic [15:0] key, 
	output logic [15:0] keylatch,
	output logic scan_signal, enable_key
	); 
	
	typedef enum logic [4:0] {SCAN = 5'b00001, PRESS = 5'b00010, HOLD = 5'b00100, RESET = 5'b01000, CHECK = 5'b10000} statetype;
	statetype state, nextstate;
	logic any_key; 
	logic [19:0] count; 
	logic [3:0] freeze_row; 
	logic [15:0] keylatch;
	
	assign any_key = |key; 		// ors all of the bits of key together; if a key is pushed, then we any_key will be 1
	counter #(262143, 19) debounce(reset, count_enable,clk, counter)
	
	always_ff @(posedge clk, negedge reset)
		if (~reset) state <= RESET; 
		else state <= nextstate; 
	
	always_comb
		case (state)
			RESET: nextstate = SCAN;
			SCAN: nextstate = any_key ? PRESS:SCAN; // if column pressed, we go to the PRESS state, if not keep scanning
			PRESS: nextstate = HOLD; 	// we always go to hold after press, no matter what
			HOLD: nextstate = count[18] ? HOLD:CHECK;  // debounces. debounces for 5 ms and then moves from hold to check 
			CHECK: nextstate = (key == keylatch) ? CHECK:SCAN; 
			default: nextstate = RESET; 
		endcase
		
	always_comb
		case (state)
			RESET: begin 
				scan_signal = 0;  // signal here that tells my rows to start scanning. once i get a column then debounce/sync that one column and feed it into the decoder
				enable_key = 0; 
				row = 4'b0000; 
				count_enable = 0; 
				end 
			SCAN: begin 
				scan_signal = 1; 
				enable_key = 0;  
				count_enable = 0;
				end 
			PRESS: begin 
				scan_signal = 0; 
				enable_key = 0; 
			HOLD: begin 
				scan_signal = 0; 
				enable_key = 0; 
				count_enable = 1;
				row = freeze_row; 
				end 
			CHECK: begin 
				scan_signal = 0; 
				enable_key = 1; 
				count_enable = 0;
				row = freeze_row;
				end 
			
				
	always_ff @(posedge clk, negedge reset) 
		if (~reset) begin
			if (state == PRESS && any_key) freeze_row <= row;
			if (state == CHECK && any_key) keylatch <= key; 
		end 
endmodule 
	