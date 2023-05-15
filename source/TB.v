module TB;
    reg clk=1'b1, rst=1'b0, forwarding_en=1'b0;

    wire SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N;
    wire [15:0] SRAM_DQ;
    wire [17:0] SRAM_ADDR;

    always #5 clk = ~clk;
    initial begin
       forwarding_en = 1'b0;
       rst = 1'b1;
       #10
       rst = 1'b0;
       #10000
       $stop; 
    end
    TopLevel TL(clk, rst, forwarding_en, SRAM_DQ, SRAM_ADDR, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N);

    SRAM sr(clk, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N, SRAM_DQ, SRAM_ADDR);

endmodule