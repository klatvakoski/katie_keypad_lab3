module output_val (
	input logic [15:0] keylatch; 
	output logic [3:0] decoded_key; 
	); 
	
	if decoded_key[0] = 4'd0;  // keypad input 0
	else if decoded_key[1] = 4'd1;	// 1
	else if decoded_key[2] = 4'd2;
	else if decoded_key[3] = 4'd3;
	else if decoded_key[4] = 4'd4;
	else if decoded_key[5] = 4'd5;
	else if decoded_key[6] = 4'd6;
	else if decoded_key[7] = 4'd7;
	else if decoded_key[8] = 4'd8
	else if decoded_key[9] = 4'd9;
	else if decoded_key[10] = 4'd10;
	else if decoded_key[11] = 4'd11;
	else if decoded_key[12] = 4'd12;
	else if decoded_key[13] = 4'd13;
	else if decoded_key[14] = 4'd14;
	else if decoded_key[15] = 4'd15;

endmodule 		