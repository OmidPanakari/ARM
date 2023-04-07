module IDReg (
    clk,
    rst,
    pc,
    wb_en,
    mem_read,
    mem_write,
    alu_command,
    b,
    s,
    val_rn,
    val_rm,
    shift_operand,
    imm,
    signed_imm,
    dest,
    flush,
    status,
    wb_en_out,
    mem_read_out,
    mem_write_out,
    alu_command_out,
    b_out,
    s_out,
    val_rn_out,
    val_rm_out,
    shift_operand_out,
    imm_out,
    signed_imm_out,
    dest_out,
    status_out,
    pc_out
);
    input clk, rst, wb_en, mem_read, b, s, imm, flush, mem_write;
    input [3:0] alu_command, dest, status;
    input [11:0] shift_operand;
    input [23:0] signed_imm;
    input [31:0] pc, val_rm, val_rn;
    
    output reg wb_en_out, mem_read_out, b_out, s_out, imm_out, mem_write_out;
    output reg [3:0] alu_command_out, dest_out, status_out;
    output reg [11:0] shift_operand_out;
    output reg [23:0] signed_imm_out;
    output reg [31:0] pc_out, val_rm_out, val_rn_out;

    //TODO: add flush

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            val_rm_out <= 32'd0;
            val_rn_out <= 32'd0;
            shift_operand_out <= 12'd0;
            signed_imm_out <= 24'd0;
            {wb_en_out, mem_read_out, mem_write_out, b_out, s_out, imm_out} <= 6'd0;
            pc_out <= 32'd0;
            alu_command_out <= 4'd0;
            dest_out <= 4'd0;
            status_out <= 4'd0;
        end
        else begin
            val_rm_out <= val_rm;
            val_rn_out <= val_rn;
            shift_operand_out <= shift_operand;
            signed_imm_out <= signed_imm;
            wb_en_out <= wb_en;
            mem_read_out <= mem_read;
            b_out <= b;
            s_out <= s;
            imm_out <= imm;
            alu_command_out <= alu_command;
            dest_out <= dest;
            mem_write_out <= mem_write;
            status_out <= status;
            pc_out <= pc;
        end
    end
endmodule