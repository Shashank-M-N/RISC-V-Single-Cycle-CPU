// alu_decoder.v - ALU Decoder for RISC-V CPU

/*
# Team ID:          1664
# Theme:            EcoMender Bot
# Author List:      Shrinivas Basanagouda Malipatil, Shashank M N, Bommisetty Ganesh, Shishir Ravi Jois
# Filename:         alu_decoder.v
# File Description: This module decodes ALU operation codes based on opcode,
#                   funct3, and funct7b5 signals to generate the appropriate ALU control signals.
# Global variables: None
*/

module alu_decoder (
    input            opb5,
    input [2:0]      funct3,
    input            funct7b5,
    input [1:0]      ALUOp,
    output reg [3:0] ALUControl
);

// always block to generate ALU control signals based on the input instructions
always @(*) begin
    ALUControl = 4'b0000;  // Default to addition
    
	 // Decode ALU operation based on ALUOp
    case (ALUOp)
        2'b00: ALUControl = 4'b0000;             // addition
        2'b01: ALUControl = 4'b0001;             // subtraction
        default: begin
		  // Decode R-type or I-type ALU operations based on funct3 and funct7b5
            case (funct3)  // R-type or I-type ALU
                3'b000: ALUControl = (funct7b5 & opb5) ? 4'b0001 : 4'b0000; // ALU operation: sub / add
                3'b001: ALUControl = 4'b0100; // sll, slli
                3'b010: ALUControl = 4'b0101; // slt, slti
                3'b011: ALUControl = 4'b0110; // sltu, sltiu
                3'b100: ALUControl = 4'b0111; // xor, xori
                3'b110: ALUControl = 4'b0011; // or, ori
                3'b111: ALUControl = 4'b0010; // and, andi
                3'b101: ALUControl = funct7b5 ? 4'b1000 : 4'b1001; // ALU operation: sra / srl
            endcase
        end
    endcase
end

endmodule
