// main_decoder.v - logic for main decoder

/*
# Team ID:          1664
# Theme:            EcoMender Bot
# Author List:      Shrinivas Basanagouda Malipatil, Shashank M N, Bommisetty Ganesh, Shishir Ravi Jois
# Filename:         main_decoder.v
# File Description: This module implements the main decoder for the RISC-V CPU. It takes opcode 
#                   and function codes as inputs and generates control signals for the CPU's 
#                   datapath based on the instruction type.
# Global variables: None
*/

module main_decoder (
    input  [6:0] op,
    input  [2:0] funct3,
    input        Zero, ALUR31, carry,
    output [1:0] ResultSrc,
    output       MemWrite, Branch, ALUSrc,
    output       RegWrite, Jump, Jalr,
    output [1:0] ImmSrc,
    output [1:0] ALUOp
);

reg [10:0] controls;
reg TakeBranch;

always @(*) begin
	 /*
	 Purpose: 
	 ---
	 This always block generates control signals based on the opcode and function codes.
    It assigns values to the controls register and determines if a branch should be taken.
	 */
	 
    TakeBranch = 0;                  // Initialize TakeBranch to 0
    case (op)
        // Assign control signals based on the opcode
        // RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_ALUOp_Jump_Jalr
        7'b0000011: controls = 11'b1_00_1_0_01_00_0_0; // lw
        7'b0100011: controls = 11'b0_01_1_1_00_00_0_0; // sw
        7'b0110011: controls = 11'b1_xx_0_0_00_10_0_0; // R–type
        7'b1100011: begin // branch instructions
            controls = 11'b0_10_0_0_00_01_0_0; 
            // Determine if the branch should be taken based on funct3
            case(funct3)
                3'b000: TakeBranch =     Zero; // beq
                3'b001: TakeBranch =    !Zero; // bne
                3'b100: TakeBranch =   ALUR31; // blt
                3'b101: TakeBranch =  !ALUR31; // bge
                3'b110: TakeBranch =   carry;  // bltu
                3'b111: TakeBranch =  !carry;  // bgeu
            endcase
        end
        7'b0010011: controls = 11'b1_00_1_0_00_10_0_0; // I–type ALU
        7'b1101111: controls = 11'b1_11_0_0_10_00_1_0; // jal
        7'b1100111: controls = 11'b1_00_1_0_10_00_0_1; // jalr
        default: controls = 11'b1_xx_1_0_11_00_0_0;    // lui and auipc: default control signals
    endcase
end

assign Branch = TakeBranch;
assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, ALUOp, Jump, Jalr} = controls;

endmodule
