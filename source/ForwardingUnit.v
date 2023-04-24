module ForwardingUnit(
    clk,
    rst,
    src1,
    src2,
    mem_read_en,
    wb_en,
    mem_dest,
    wb_dest,
    sel_src1,
    sel_src2
);
    input clk, rst, mem_read_en, wb_en;
    input [3:0] src1, src2, mem_dest, wb_dest;
    
    output reg [1:0] sel_src1, sel_src2;

    always @(src1, src2, mem_dest, wb_dest, mem_read_en, wb_en) begin
        sel_src1 = ((src1 == mem_dest) && mem_read_en) ? 2'd1
                    : ((src1 == wb_dest) && wb_en) ? 2'd2
                    : 2'd0;
        sel_src2 = ((src2 == mem_dest) && mem_read_en) ? 2'd1
                    : ((src2 == wb_dest) && wb_en) ? 2'd2
                    : 2'd0;
    end
endmodule