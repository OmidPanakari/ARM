module Execution (
    clk,
    rst,
    mem_write_en,
    mem_read_en,
    sel_src1,
    sel_src2,
    val_rn,
    val_rm,
    ex_alu_res,
    wb_value,
    shift_operand,
    imm,
    signed_imm,
    alu_command,
    pc,
    status,
    alu_res,
    branch_address,
    status_out,
    val2_out
);
    input clk, rst, mem_write_en, mem_read_en, imm;
    input [1:0] sel_src1, sel_src2;
    input [3:0] alu_command, status;
    input [11:0] shift_operand;
    input [23:0] signed_imm;
    input [31:0] pc, val_rn, val_rm, ex_alu_res, wb_value;

    output [3:0] status_out;
    output [31:0] alu_res, branch_address, val2_out;

    wire select;
    wire [31:0] val2, alu_val1, alu_val2;

    assign val2_out = alu_val2;
    assign select = mem_write_en | mem_read_en;
    assign alu_val1 = (sel_src1 == 2'd0) ? val_rn
                    : (sel_src1 == 2'd1) ? ex_alu_res
                    : wb_value;
    assign alu_val2 = (sel_src2 == 2'd0) ? val_rm
                    : (sel_src2 == 2'd1) ? ex_alu_res
                    : wb_value;
    Val2Generate v2gen(select, alu_val2, shift_operand, imm, val2);
    ALU alu(alu_command, status, alu_val1, val2, alu_res, status_out);
    assign branch_address = ({{8{signed_imm[23]}}, signed_imm} << 2) + pc;


endmodule