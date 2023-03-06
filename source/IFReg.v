module IFReg (
    clk,
    rst,
    freeze,
    flush,
    pc_in,
    instruction_in,
    pc_out,
    instruction_out
);
    input clk, rst, freeze, flush;
    input [31:0] pc_in, instruction_in;
    output reg [31:0] pc_out, instruction_out;
    always @(posedge clk) begin
        pc_out <= pc_in;
        instruction_out <= instruction_in;
    end
endmodule