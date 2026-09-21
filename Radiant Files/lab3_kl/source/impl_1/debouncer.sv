module debouncer(
	input logic clk, reset,
	input logic sw,
	output logic debounce_sw
	);	
	// input a switch that's 1 when presssed (that has bounce on it) and you get an output that is debounced
	
	logic [19:0] counter; 
	
	typedef enum logic [1:0] {IDLE, WAIT, PRESSED} statetype;   // how does this work. 
	statetype state, nextstate; 
	
	always_ff @(posedge clk, posedge reset)
		if (~reset) state <= IDLE; 
		else state <= nextstate; 
	
	always_ff @(posedge clk)
		if (state == IDLE) counter <= 0;
		else counter <= counter +1; 
	
	always_comb 
		case (state)
			IDLE: nextstate = sw ? WAIT:IDLE; // stays in IDLE if 0 ( input will be ~col so that columns high when on), goes to WAIT if 1
			WAIT: if (!sw) nextstate = IDLE; 	// a bounce bc we are going back to 0
				  else if (counter[9]) nextstate = PRESSED;   // return to 19
				  else nextstate = WAIT; 		// stay in wait until we get a new sw val
			PRESSED: nextstate = sw ? PRESSED:IDLE;		// if sw = 1, we are holding the button; if sw = 0 button is let go
			default: nextstate = IDLE;
		endcase 
	
	assign debounce_sw = (state == PRESSED); 	// stay high (on) when we are in pressed

endmodule 
