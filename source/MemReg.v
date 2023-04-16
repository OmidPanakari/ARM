module MemReg (
    clk,
    rst,
    wb_en,
    mem_read_en,
    alu_res,
    value,
    dest,
    wb_en_out,
    mem_read_en_out,
    alu_res_out,
    value_out,
    dest_out
);
    input clk, rst, wb_en, mem_read_en;
    input [3:0] dest;
    input [31:0] alu_res, value;
    output reg wb_en_out, mem_read_en_out;
    output reg [3:0] dest_out;
    output reg [31:0] alu_res_out, value_out;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            wb_en_out <= 1'd0;
            mem_read_en_out <= 1'd0;
            alu_res_out <= 32'd0;
            value_out <= 32'd0;
            dest_out <= 4'd0;
        end
        else begin
            wb_en_out <= wb_en;
            mem_read_en_out <= mem_read_en;
            alu_res_out <= alu_res;
            value_out <= value;
            dest_out <= dest;
        end
    end
endmodule