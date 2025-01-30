// mux4.v - logic for 4-to-1 multiplexer

/*
# Team ID:          1664
# Theme:            EcoMender Bot
# Author List:      Shrinivas Basanagouda Malipatil, Shashank M N, Bommisetty Ganesh, Shishir Ravi Jois
# Filename:         mux4.v
# File Description: This module implements a 4-to-1 multiplexer. It selects one of four input data lines 
#                   based on a 2-bit select signal and outputs the selected data line.
# Global variables: None
*/

module mux4 #(parameter WIDTH = 8) (
    input       [WIDTH-1:0] d0, d1, d2, d3,
    input       [1:0] sel,
    output      [WIDTH-1:0] y
);

// Combinational logic for 4-to-1 multiplexer
assign y = sel[1] ? (sel[0] ? d3 : d2) : (sel[0] ? d1 : d0);

endmodule
