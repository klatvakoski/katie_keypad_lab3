module debouncer(
	input logic clk, reset,
	input logic sw,
	output logic debounce_sw
	);	
	// input a switch (that has bounce on it) and you get an output that is debounced
	
	logic [19:0] counter; 
	
	typedef enum logic [1:0] {IDLE, WAIT, PRESSED} statetype;   // how does this work. 
	statetype state, nextstate; 
	
	always_ff @(posedge clk, posedge reset)
		if (reset) state <= IDLE; 
		else state <= nextstate; 
	
	always_ff @(posedge clk)
		if (state == IDLE) counter <= 0;
		else counter <= counter +1; 
	
	always_comb 
		case (state)
			IDLE: nextstate = sw ? IDLE:WAIT; // stays in IDLE if 1 (pulling columns low when on), goes to WAIT if 0
			WAIT: if (sw) nextstate = IDLE; 	// a bounce bc we are going back to 1
				  else if (counter[19]) nextstate = PRESSED; 
				  else nextstate = WAIT; 		// stay in wait until we get a new sw val
			PRESSED: nextstate = sw ? IDLE:PRESSED;		// if sw = 1, we are letting go of the button; if sw = 0 button is held
			default: nextstate = IDLE;
		endcase 
	
	assign debounced_sw = (state = PRESSED); 

endmodule 
