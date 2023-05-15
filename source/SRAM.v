module SRAM (
    clk,
    SRAM_UB_N,
    SRAM_LB_N,
    SRAM_WE_N,
    SRAM_CE_N,
    SRAM_OE_N,
    SRAM_DQ,
    SRAM_ADDR
);
    input SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N, clk;
    inout [15:0] SRAM_DQ;
    input [17:0] SRAM_ADDR;
    reg [15:0] data [0:1023];
    
    assign SRAM_DQ = SRAM_WE_N ? data[SRAM_ADDR] : 16'bz;

    always @(posedge clk) begin
        if (SRAM_WE_N == 1'b0) begin
            data[SRAM_ADDR] <= SRAM_DQ;
        end
    end
endmodule