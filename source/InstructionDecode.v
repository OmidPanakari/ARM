module InstructionDecode (
    clk,
    rst,
    condition_check,
    instruction
);
    input clk, rst;
    input [3:0] condition_check;
    input [31:0] instruction;
    wire imm, s;
    wire[1:0] mode;
    wire[3:0] cond, op_code, rn, rd;
    assign imm = instruction[25];
    assign cond = instruction[31:28];
    assign op_code = instruction[24:21];
    assign s = instruction[20];
    assign mode = instruction[27:26];
    assign rn = instruction[19:16];
    assign rd = instruction[15:12];

endmodule