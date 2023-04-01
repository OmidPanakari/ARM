module IDReg (
    clk,
    rst,
    pc,
    wb_en,
    mem_read,
    mem_write,
    alu_command,
    b,
    status,
    val_rn,
    val_rm,
    shift_operand,
    imm,
    signed_imm,
    dest,
    flush,
    status_reg_data,
    wb_en_out,
    mem_read_out,
    mem_write_out,
    alu_command_out,
    b_out,
    status_out,
    val_rn_out,
    val_rm_out,
    shift_operand_out,
    imm_out,
    signed_imm_out,
    dest_out,
    status_reg_data_out,
    pc_out
);
    input clk, rst;
    input [31:0] pc, val_rm, val_rn;
    input [11:0] shift_operand;
    input [23:0] signed_imm;
    input wb_en, mem_read, b, status, imm, flush, mem_write;
    input [3:0] alu_command, dest, status_reg_data;
    
    output reg [31:0] pc_out, val_rm_out, val_rn_out;
    output reg [11:0] shift_operand_out;
    output reg [23:0] signed_imm_out;
    output reg wb_en_out, mem_read_out, b_out, status_out, imm_out, mem_write_out;
    output reg [3:0] alu_command_out, dest_out, status_reg_data_out;

    //TODO: add flush

    always @(posedge clk) begin
        val_rm_out <= val_rm;
        val_rn_out <= val_rn;
        shift_operand_out <= shift_operand;
        signed_imm_out <= signed_imm;
        wb_en_out <= wb_en;
        mem_read_out <= mem_read;
        b_out <= b;
        status_out <= status;
        imm_out <= imm;
        alu_command_out <= alu_command;
        dest_out <= dest;
        mem_write_out <= mem_write;
        status_reg_data_out <= status_reg_data;
        pc_out <= pc;
    end
endmodule