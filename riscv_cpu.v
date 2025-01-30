// riscv_cpu.v - single-cycle RISC-V CPU Processor

/*
# Team ID:          1664
# Theme:            EcoMender Bot
# Author List:      Shrinivas Basanagouda Malipatil, Shashank M N, Bommisetty Ganesh, Shishir Ravi Jois
# Filename:         riscv_cpu.v
# File Description: This is a single-cycle RISC-V CPU processor module. It instantiates the controller and datapath modules
#                   to perform instruction execution and memory operations.
# Global variables: None
*/

module riscv_cpu (
    input         clk, reset,
    output [31:0] PC,
    input  [31:0] Instr,
    output        MemWrite,
    output [31:0] Mem_WrAddr, Mem_WrData,
    input  [31:0] ReadData,
    output [31:0] Result
);

wire        ALUSrc, RegWrite, Jump, Jalr, Zero, ALUR31, carry;
wire [1:0]  ResultSrc, ImmSrc;
wire [3:0]  ALUControl;

// Instantiate controller to decode instructions and generate control signals
controller  c   (Instr[6:0], Instr[14:12], Instr[30], Zero, ALUR31, carry,
                ResultSrc, MemWrite, PCSrc, ALUSrc, RegWrite, Jump, Jalr,
                ImmSrc, ALUControl);

// Instantiate datapath to execute instructions and handle ALU operations
datapath    dp  (clk, reset, ResultSrc, PCSrc,
                ALUSrc, RegWrite, ImmSrc, ALUControl, Jalr,
                Zero, ALUR31, carry, PC, Instr, Mem_WrAddr, Mem_WrData, ReadData, Result);

endmodule
