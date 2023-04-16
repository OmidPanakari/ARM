module Memory (
    clk,
    rst,
    mem_write_en,
    mem_read_en,
    alu_res,
    val_rm,
    value
);
    input clk, rst, mem_read_en, mem_write_en;
    input [31:0] alu_res, val_rm;

    output reg [31:0] value;

    reg [31:0] memory [0:1023];

    always @(alu_res, mem_read_en, rst) begin
        value = (rst) ? 32'd0 : 
                (mem_read_en) ? memory[alu_res >> 2] : value;
    end

    always @(posedge clk) begin
        if (mem_write_en) begin
            memory[alu_res >> 2] <= val_rm;
        end
    end
endmodule