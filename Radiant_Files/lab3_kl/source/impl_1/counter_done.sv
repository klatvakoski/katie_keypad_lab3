`timescale 1 us/1 ns
module counter_done #(parameter MAX_COUNT = 120000, parameter WIDTH = 18)(
  input  logic reset,
  input  logic enable,
  input  logic clk,
  input  logic [WIDTH-1:0] count,
  output logic count_done
);
  // instantiate counter mod
  counter #(MAX_COUNT, WIDTH) counting(reset, enable, clk, count);
  always_ff @(posedge clk, negedge reset) 
    if (~reset) begin 
      count_done <= (count == MAX_COUNT); 
    end



endmodule

