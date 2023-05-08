module Memory (
    clk,
    rst,
    mem_write_en,
    mem_read_en,
    alu_res,
    val_rm,
    value,
    freeze,
    SRAM_DQ,
    SRAM_ADDR,
    SRAM_UB_N,
    SRAM_LB_N,
    SRAM_WE_N,
    SRAM_CE_N,
    SRAM_OE_N
);
    input clk, rst, mem_read_en, mem_write_en;
    input [31:0] alu_res, val_rm;
    output SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N, SRAM_WE_N, freeze;
    output [15:0] SRAM_DQ;
    output [17:0] SRAM_ADDR;
    output [31:0] value;

    SramController sc(clk, rst, mem_write_en, mem_read_en, alu_res, val_rm, value, freeze, SRAM_DQ, SRAM_ADDR, 
        SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N);
endmodule