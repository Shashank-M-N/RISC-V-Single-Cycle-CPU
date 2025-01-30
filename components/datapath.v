// datapath.v - Datapath for single-cycle RISC-V CPU

/*
# Team ID:          1664
# Theme:            EcoMender Bot
# Author List:      Shrinivas Basanagouda Malipatil, Shashank M N, Bommisetty Ganesh, Shishir Ravi Jois
# Filename:         datapath.v
# File Description: This module implements the datapath for a single-cycle RISC-V CPU.
#                   It connects various components such as registers, ALU, and instruction 
#                   decoding logic to execute instructions.
# Global variables: None
*/

module datapath (
    input         clk, reset,
    input [1:0]   ResultSrc,
    input         PCSrc, ALUSrc,
    input         RegWrite,
    input [1:0]   ImmSrc,
    input [3:0]   ALUControl,
    input         Jalr,
    output        Zero, ALUR31, carry,
    output [31:0] PC,
    input  [31:0] Instr,
    output [31:0] Mem_WrAddr, Mem_WrData,
    input  [31:0] ReadData,
    output [31:0] Result
);

// Internal wires for connecting various datapath components
wire [31:0] PCNext, PCJalr, PCPlus4, PCTarget;
wire [31:0] ImmExt, SrcA, SrcB, WriteData, ALUResult;
wire [31:0] LUIOrAUIPCResult, ImmPlusPC;

// next PC logic
reset_ff #(32) pcreg(clk, reset, PCJalr, PC);
assign PCPlus4 = PC + 32'd4;
assign PCTarget = PC + ImmExt;
mux2 #(32)     pcmux(PCPlus4, PCTarget, PCSrc, PCNext);
mux2 #(32)     jalrmux (PCNext, ALUResult, Jalr, PCJalr);

// register file logic
reg_file       rf (clk, RegWrite, Instr[19:15], Instr[24:20], Instr[11:7], Result, SrcA, WriteData);
imm_extend     ext (Instr[31:7], ImmSrc, ImmExt);

// ALU logic
mux2 #(32)     srcbmux(WriteData, ImmExt, ALUSrc, SrcB);
alu            alu (SrcA, SrcB, ALUControl, ALUResult, Zero, carry);

// U-Type instructions:
/*
LUI logic:
{Instr[31:12], 12'b0};
*/
// AUIPC logic:
assign ImmPlusPC = PC + {Instr[31:12], 12'b0};
// MUX to select between LUI or AUIPC based on opcode bit [5]
mux2 #(32)     lui_auipc_mux(ImmPlusPC, {Instr[31:12], 12'b0}, Instr[5], LUIOrAUIPCResult);

// MUX to select between ALUResult, ReadData, PCPlus4, and LUI/AUIPC result
mux4 #(32)     resultmux(ALUResult, ReadData, PCPlus4, LUIOrAUIPCResult, ResultSrc, Result);

assign ALUR31 = ALUResult[31];
assign Mem_WrData = WriteData;
assign Mem_WrAddr = ALUResult;

endmodule
