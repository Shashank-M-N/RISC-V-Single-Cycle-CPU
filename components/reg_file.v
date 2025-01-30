// reg_file.v - register file for single-cycle RISC-V CPU
//              (with 32 registers, each of 32 bits)
//              having two read ports, one write port
//              write port is synchronous, read ports are combinational
//              register 0 is hardwired to 0

/*
# Team ID:          1664
# Theme:            EcoMender Bot
# Author List:      Shrinivas Basanagouda Malipatil, Shashank M N, Bommisetty Ganesh, Shishir Ravi Jois
# Filename:         reg_file.v
# File Description: This module implements a register file for a single-cycle RISC-V CPU with 32 registers,
#                   each 32 bits wide. It features two combinational read ports and one synchronous write port.
#                   Register 0 is hardwired to zero, and all registers are initialized to zero at startup.
# Global variables: None
*/

module reg_file #(parameter DATA_WIDTH = 32) (
    input       clk,
    input       wr_en,
    input       [4:0] rd_addr1, rd_addr2, wr_addr,
    input       [DATA_WIDTH-1:0] wr_data,
    output      [DATA_WIDTH-1:0] rd_data1, rd_data2
);

reg [DATA_WIDTH-1:0] reg_file_arr [0:31];

// initialize all registers to 0
integer i;
initial begin
    for (i = 0; i < 32; i = i + 1) begin
        reg_file_arr[i] = 0;
    end
end

// register file write logic (synchronous)
always @(posedge clk) begin
    if (wr_en) reg_file_arr[wr_addr] <= wr_data;
end

// register file read logic (combinational)
assign rd_data1 = ( rd_addr1 != 0 ) ? reg_file_arr[rd_addr1] : 0;
assign rd_data2 = ( rd_addr2 != 0 ) ? reg_file_arr[rd_addr2] : 0;

endmodule
