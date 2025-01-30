// controller.v - Controller for RISC-V CPU

/*
# Team ID:          1664
# Theme:            EcoMender Bot
# Author List:      Shrinivas Basanagouda Malipatil, Shashank M N, Bommisetty Ganesh, Shishir Ravi Jois
# Filename:         controller.v
# File Description: This module implements the controller for a RISC-V CPU,
#                   generating control signals based on the opcode and function fields
#                   of the instruction. It interacts with the main decoder and ALU decoder.
# Global variables: None
*/

module controller (
    input [6:0]  op,
    input [2:0]  funct3,
    input        funct7b5,
    input        Zero, ALUR31, carry,
    output       [1:0] ResultSrc,
    output       MemWrite,
    output       PCSrc, ALUSrc,
    output       RegWrite, Jump, Jalr,
    output [1:0] ImmSrc,
    output [3:0] ALUControl
);

wire [1:0] ALUOp;
wire       Branch;

// Main decoder instance to generate control signals based on opcode and funct3
main_decoder    md (op, funct3, Zero, ALUR31, carry, ResultSrc, MemWrite, Branch,
                    ALUSrc, RegWrite, Jump, Jalr, ImmSrc, ALUOp);

// ALU decoder instance to generate ALU control signals based on ALUOp and instruction functions						  
alu_decoder     ad (op[5], funct3, funct7b5, ALUOp, ALUControl);

// Determine PC source based on branch or jump control signals
assign PCSrc = Branch | Jump;

endmodule
