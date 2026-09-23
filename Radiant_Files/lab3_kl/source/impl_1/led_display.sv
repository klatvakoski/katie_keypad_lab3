module led_display (
	input logic [3:0]s,
	output logic [6:0]seg
	); 
// controls a 7-segment display
	
	always_comb 		// most numbers have ~ to reverse them
		case (s) 
			4'd0: seg = 7'b100_0000; // ~7'b011_1111;   //
			4'd1: seg = 7'b111_1001; //~7'b000_0110;
			4'd2: seg = 7'b010_0100; // ~7'b101_1011;
			4'd3: seg = 7'b011_0000; //~7'b100_1111;
			4'd4: seg = 7'b001_1001; // ~7'b110_0110;
			4'd5: seg = 7'b001_0010; // ~7'b110_1101;
			4'd6: seg = 7'b000_0010; // ~7'b111_1101;
			4'd7: seg = 7'b111_1000; // ~7'b000_0111;
			4'd8: seg = 7'b000_0000; 	// in right orientation
			4'd9: seg = 7'b001_0000;    // in right orientation
			4'd10: seg = 7'b000_1000; // ~7'b111_0111;
			4'd11: seg = 7'b000_0011; // ~7'b111_1100;
			4'd12: seg = 7'b100_0110; // ~7'b011_1001;
			4'd13: seg = 7'b010_0001; // ~7'b101_1110;
			4'd14: seg = 7'b000_0110; // ~7'b111_1001;
			4'd15: seg = 7'b000_1110; // ~7'b111_0001;
			default: seg = 7'b111_1111;
		endcase			
	
endmodule
