// alu.v - ALU module

/*
# Team ID:          1664
# Theme:            EcoMender Bot
# Author List:      Shrinivas Basanagouda Malipatil, Shashank M N, Bommisetty Ganesh, Shishir Ravi Jois
# Filename:         alu.v
# File Description: This module implements an Arithmetic Logic Unit (ALU) that performs various 
#                   arithmetic and logical operations based on the ALU control signal.
# Global variables: None
*/

module alu #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,        // operands
    input       [3:0] alu_ctrl,          // ALU control
    output reg  [WIDTH-1:0] alu_out,     // ALU output
    output      zero,                    // zero flag
    output      carry                    // carry flag for unsigned comparison
);

reg [WIDTH:0] temp_result;  // Temporary result with extra bit for carry

// always block to determine the ALU output based on the ALU control signal
always @(*) begin
    case (alu_ctrl)
        4'b0000: begin                     // ADD
            temp_result = a + b;           // Perform addition with extra bit for carry
            alu_out = temp_result[WIDTH-1:0];  // Assign result
        end
        4'b0001: begin                     // SUB
            temp_result = a - b;           // Perform subtraction with extra bit for borrow
            alu_out = temp_result[WIDTH-1:0];  // Assign result
        end
        4'b0010: alu_out = a & b;          // AND
        4'b0011: alu_out = a | b;          // OR
        4'b0100: alu_out = a << b[4:0];    // SLL (Shift Left Logical)
        4'b0101: alu_out = ($signed(a) < $signed(b)) ? 1 : 0; // SLT (Signed comparison)
        4'b0110: alu_out = (a < b) ? 1 : 0; // SLTU (Unsigned comparison)
        4'b0111: alu_out = a ^ b;          // XOR
        4'b1000: alu_out = $signed(a) >>> b[4:0]; // SRA (Arithmetic Right Shift)
        4'b1001: alu_out = a >> b[4:0];    // SRL (Logical Right Shift)
        default: alu_out = 0;              // Default case
    endcase
end

// Zero flag directly assigned
assign zero = (alu_out == 0);

// Carry flag for addition and subtraction
assign carry = (alu_ctrl == 4'b0000) ? temp_result[WIDTH] :   // Carry flag for addition
               (alu_ctrl == 4'b0001 && a < b);                // Carry flag for subtraction (borrow)

endmodule
