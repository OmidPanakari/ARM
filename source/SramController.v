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
    inout [15:0] SRAM_DQ;
    output SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N, SRAM_WE_N;
    output [17:0] SRAM_ADDR;
    output [31:0] readData;
    output reg ready;
    reg [1:0] ns, ps;
    reg [2:0] counter;
    wire count_en;
    wire [15:0] data1, data2;
    wire [17:0] address1, address2;
    wire [31:0] rebased_addr;

    parameter [1:0] INITIAL = 3'd0,
                    READ = 3'd1,
                    WRITE = 3'd2;

    always @(ps, wr_en, rd_en, counter) begin
        if (rst) begin
            ns = INITIAL;
        end
        else begin
            case (ps)
                INITIAL: begin
                    ns = (wr_en) ? WRITE
                       : (rd_en) ? READ 
                       : INITIAL;
                end 
                READ: begin
                    ns = (counter == 3'd6) ? INITIAL : READ;
                end
                WRITE: begin
                    ns = (counter == 3'd6) ? INITIAL : WRITE;
                end
            endcase
        end
    end

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            ps <= INITIAL;
        end
        else begin
            ps <= ns;
        end
    end

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            counter <= 3'd0;
        end
        else if (count_en) begin
            counter <= (counter == 3'd6) ? 3'd0 : counter + 3'd1; 
        end
        else begin
            counter <= 3'd0;
        end
    end

    assign count_en = (ps != INITIAL) ? 1'b1 : 1'b0;

    assign SRAM_WE_N = (ps == WRITE && counter <= 3'd3) ? 1'b0 : 1'b1;

    assign SRAM_DQ = (ps == WRITE && (counter == 3'd0 || counter == 3'd1)) ? writeData[15:0]
                   : (ps == WRITE && (counter == 3'd2 || counter == 3'd3)) ? writeData[31:16] 
                   : 16'bz;
    assign data1 = (ps == READ && (counter == 3'd0 || counter == 3'd1)) ? SRAM_DQ : data1;
    assign data2 = (ps == READ && (counter == 3'd2 || counter == 3'd3)) ? SRAM_DQ : data2;
    assign readData = {data2, data1};

    assign rebased_addr = address - 32'd1024;
    assign address1 = {rebased_addr[18:2], 1'b0};
    assign address2 = {rebased_addr[18:2], 1'b1};
    assign SRAM_ADDR = (ps != INITIAL && (counter == 3'd0 || counter == 3'd1)) ? address1
                     : (ps != INITIAL && (counter == 3'd2 || counter == 3'd3)) ? address2
                     : 18'd0;
    
    assign ready = (rst) ? 1'b0
                 : (ps == INITIAL && (wr_en || rd_en)) ? 1'b1
                 : (ps != INITIAL && (counter != 3'd6)) ? 1'b1
                 : 1'b0;

    assign {SRAM_UB_N, SRAM_LB_N, SRAM_OE_N, SRAM_CE_N} = 4'd0;
    
endmodule