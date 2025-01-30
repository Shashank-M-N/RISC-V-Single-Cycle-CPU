// reset_ff.v - 8-bit resettable D flip-flop

/*
# Team ID:          1664
# Theme:            EcoMender Bot
# Author List:      Shrinivas Basanagouda Malipatil, Shashank M N, Bommisetty Ganesh, Shishir Ravi Jois
# Filename:         reset_ff.v
# File Description: This module implements a parameterized, 8-bit resettable D flip-flop. It stores an input value on
#                   the rising edge of the clock or resets the output to 0 on the rising edge of the reset signal.
# Global variables: None
*/

module reset_ff #(parameter WIDTH = 8) (
    input       clk, rst,
    input       [WIDTH-1:0] d,
    output reg  [WIDTH-1:0] q
);

always @(posedge clk or posedge rst) begin
    /*
    Purpose:
    ---
    This always block describes the behavior of a resettable D flip-flop. On the rising edge of the clock (`clk`),
    the flip-flop captures the input data `d` and stores it in the output `q`. On the rising edge of the reset (`rst`),
    the output `q` is reset to 0.
    */

    if (rst) q <= 0;
    else     q <= d;
end

endmodule
