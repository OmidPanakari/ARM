module SramController (
    clk,
    rst,
    wr_en,
    rd_en,
    address,
    writeData,
    readData,
    ready,
    SRAM_DQ,
    SRAM_ADDR,
    SRAM_UB_N,
    SRAM_LB_N,
    SRAM_WE_N,
    SRAM_CE_N,
    SRAM_OE_N
);
    input clk, rst, wr_en, rd_en;
    input [31:0] address, writeData;
    output SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N;
    output [15:0] SRAM_DQ;
    output [17:0] SRAM_ADDR;
    output [31:0] readData;
    output reg SRAM_WE_N, ready;
    reg [2:0] ns, ps;
    wire [15:0] data1, data2;
    wire [17:0] addr1, addr2;

    parameter [2:0] INITIAL = 3'd0,
                    FIRST = 3'd1,
                    SECOND = 3'd2,
                    THIRD = 3'd3,
                    FIFTH = 3'd5;

    always @(ps) begin
        {SRAM_WE_N, ready} = 2'd3;
        ns = INITIAL;
        case (ps)
            INITIAL: begin
                ready = 1'b0;
                if (wr_en) begin
                    ns = FIRST;
                end
                if (rd_en) begin
                    ns = FIRST;
                end
            end
            FIFTH: begin
                if (wr_en) begin
                    SRAM_WE_N = 1'b0;
                end
                ns = INITIAL;
            end
            default: begin
                if (wr_en) begin
                    SRAM_WE_N = 1'b0;
                end
                ns = ps + 1;
            end
        endcase
    end

    always @(posedge clk) begin
        ps = ns;
    end

    assign SRAM_DQ = (rd_en && ps != INITIAL) ? 16'bz
                    : (wr_en && ps == FIRST) ? writeData[31:16]
                    : (wr_en && ps == SECOND) ? writeData[15:0] : 16'bz;
    assign data1 = (rd_en && ps == SECOND) ? SRAM_DQ : 16'd0;
    assign data2 = (rd_en && ps == THIRD) ? SRAM_DQ : 16'd0;
    assign readData = {data1, data2};
    assign address1 = {address[18:2], 1'b0};
    assign address2 = {address[18:2], 1'b1};
    assign SRAM_ADDR = (ps == FIRST) ? address1 : address2;
    assign {SRAM_UB_N, SRAM_LB_N, SRAM_OE_N, SRAM_CE_N} = 4'd0;
    
endmodule