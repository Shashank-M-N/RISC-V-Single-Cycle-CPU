// t1c_riscv_cpu.v - Top Module to test riscv_cpu

/*
# Team ID:          1664
# Theme:            EcoMender Bot
# Author List:      Shrinivas Basanagouda Malipatil, Shashank M N, Bommisetty Ganesh, Shishir Ravi Jois
# Filename:         t1c_riscv_cpu.v
# File Description: This module is the top-level module for testing the RISCV CPU. It connects the RISCV CPU, instruction memory,
#                   and data memory. It also handles external memory writes.
# Global variables: None
*/

module t1c_riscv_cpu (
    input         clk, reset,
    input         Ext_MemWrite,
    input  [31:0] Ext_WriteData,
    input  [31:0] Ext_DataAdr,
    output        MemWrite,
    output [31:0] WriteData, DataAdr, 
    output [31:0] ReadData, PC, Result 
);

wire [31:0] Instr;
wire [31:0] DataAdr_rv32;
wire [31:0] WriteData_rv32;
wire        MemWrite_rv32;

// instantiate processor and memories
riscv_cpu rvcpu    (clk, reset, PC, Instr,
                    MemWrite_rv32, DataAdr_rv32,
                    WriteData_rv32, ReadData, Result);

instr_mem instrmem (PC, Instr);	// Fetch instruction from instruction memory based on current PC

data_mem  datamem  (clk, MemWrite, Instr[14:12], DataAdr, WriteData, ReadData);

// External memory write control: Overrides internal CPU memory write during reset
assign MemWrite  = (Ext_MemWrite && reset) ? 1 : MemWrite_rv32;
assign WriteData = (Ext_MemWrite && reset) ? Ext_WriteData : WriteData_rv32;
assign DataAdr   = reset ? Ext_DataAdr : DataAdr_rv32;

endmodule