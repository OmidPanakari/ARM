module ExReg (
    clk,
    rst,
    wb_en,
    mem_read_en,
    mem_write_en,
    alu_res,
    val_rm,
    dest,
    wb_en_out,
    mem_read_en_out,
    mem_write_en_out,
    alu_res_out,
    val_rm_out,
    dest_out
);
    input clk, rst;
    input wb_en, mem_read_en, mem_write_en;
    input [3:0] dest;
    input [31:0] alu_res, val_rm;

    output reg wb_en_out, mem_read_en_out, mem_write_en_out;
    output reg [3:0] dest_out;
    output reg [31:0] alu_res_out, val_rm_out;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            {wb_en_out, mem_read_en_out, mem_write_en_out} <= 3'd0;
            dest_out <= 4'd0;
            alu_res_out <= 32'd0;
            val_rm_out <= 32'd0;
        end
        else begin
            wb_en_out <= wb_en;
            mem_read_en_out <= mem_read_en;
            mem_write_en_out <= mem_write_en;
            dest_out <= dest;
            alu_res_out <= alu_res;
            val_rm_out <= val_rm;
        end
    end
endmodule