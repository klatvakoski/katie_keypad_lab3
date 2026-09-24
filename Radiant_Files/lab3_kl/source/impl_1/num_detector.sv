module num_detector (
	input logic reset,
	input logic [3:0] col, row,
	input logic clk,
	output logic [15:0] key,
	output logic [3:0] synced_row,
	output logic [3:0] synced_col
	);
	// translates rows & cols to key. Assume that col is put in as ~col (i.e. 0001 = col[0] is pressed). 
	logic [3:0] synced_col, synced_row;
	
	// synchronize the column input 
	synchronizer #(4) col_sync(clk, col, synced_col);
	
	
	// for timing sake, synchronize the row input: 
	synchronizer #(4) row_sync(clk, row, synced_row);
	
	
	assign key[0] = (row[3] & col[1]);  // keypad input 0
	assign key[1] = (row[0] & col[0]);	// 1
	assign key[2] = (row[0] & col[1]);	// 2
	assign key[3] = (row[0] & col[2]);	// 3
	assign key[4] = (row[1] & col[0]);	// 4
	assign key[5] = (row[1] & col[1]);	// 5
	assign key[6] = (row[1] & col[2]);	// 6
	assign key[7] = (row[2] & col[0]);	// 7
	assign key[8] = (row[2] & col[1]);	// 8
	assign key[9] = (row[2] & col[2]);	// 9
	assign key[10] = (row[0] & col[3]);	// 10 / A
	assign key[11] = (row[1] & col[3]);	// 11 / B
	assign key[12] = (row[2] & col[3]);	// 12 / C
	assign key[13] = (row[3] & col[3]);	// 13 / D
	assign key[14] = (row[3] & col[0]);	// 14 / E
	assign key[15] = (row[3] & col[2]);	// 15 / F
	
endmodule 
	