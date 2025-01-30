// mux2.v - logic for 2-to-1 multiplexer

/*
# Team ID:          1664
# Theme:            EcoMender Bot
# Author List:      Shrinivas Basanagouda Malipatil, Shashank M N, Bommisetty Ganesh, Shishir Ravi Jois
# Filename:         mux2.v
# File Description: This module implements a 2-to-1 multiplexer. It selects one of two input data lines 
#                   based on a select signal and outputs the selected data line.
# Global variables: None
*/

module mux2 #(parameter WIDTH = 8) (
    input       [WIDTH-1:0] d0, d1,
    input       sel,
    output      [WIDTH-1:0] y
);

// Combinational logic for 4-to-1 multiplexer
assign y = sel ? d1 : d0;

endmodule
