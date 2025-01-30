// imm_extend.v - logic for sign extension

/*
# Team ID:          1664
# Theme:            EcoMender Bot
# Author List:      Shrinivas Basanagouda Malipatil, Shashank M N, Bommisetty Ganesh, Shishir Ravi Jois
# Filename:         imm_extend.v
# File Description: This module performs sign extension for immediate values based on the 
#                   instruction format specified by immsrc. The immediate value is extracted 
#                   from the instruction and sign-extended to 32 bits.
# Global variables: None
*/

module imm_extend (
    input  [31:7]     instr,
    input  [ 1:0]     immsrc,
    output reg [31:0] immext
);

always @(*) begin
	 /*
	 Purpose: 
	 ---
	 This always block generates the sign-extended immediate value based on the 
    instruction format specified by immsrc.
	 */
	 
    case(immsrc)
        // I−type
        2'b00:   immext = {{20{instr[31]}}, instr[31:20]};
        // S−type (stores)
        2'b01:   immext = {{20{instr[31]}}, instr[31:25], instr[11:7]};
        // B−type (branches)
        2'b10:   immext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
        // J−type (jal)
        2'b11:   immext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
    endcase
end

endmodule
