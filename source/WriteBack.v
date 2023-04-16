module WriteBack (
    clk,
    rst,
    mem_read_en,
    alu_res,
    value,
    wb_value
);
    input clk, rst, mem_read_en;
    input [31:0] alu_res, value;

    output [31:0] wb_value;

    assign wb_value = (mem_read_en) ? value : alu_res;
endmodule