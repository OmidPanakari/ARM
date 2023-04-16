module Execution (
    clk,
    rst,
    mem_write_en,
    mem_read_en,
    val_rn,
    val_rm,
    shift_operand,
    imm,
    signed_imm,
    alu_command,
    pc,
    status,
    alu_res,
    branch_address,
    status_out
);
    input clk, rst, mem_write_en, mem_read_en, imm;
    input [3:0] alu_command, status;
    input [11:0] shift_operand;
    input [23:0] signed_imm;
    input [31:0] pc, val_rn, val_rm;

    output [3:0] status_out;
    output [31:0] alu_res, branch_address;

    wire select;
    wire [31:0] val2;

    assign select = mem_write_en | mem_read_en;
    Val2Generate v2gen(select, val_rm, shift_operand, imm, val2);
    ALU alu(alu_command, status, val_rn, val2, alu_res, status_out);
    assign branch_address = ({{8{signed_imm[23]}}, signed_imm} << 2) + pc;


endmodule