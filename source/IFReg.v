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
    //TODO: add flush

    input clk, rst, freeze, flush;
    input [31:0] pc_in, instruction_in;
    output reg [31:0] pc_out, instruction_out;
    always @(posedge clk) begin
        if(~freeze) begin
            pc_out <= pc_in;
            instruction_out <= instruction_in;
        end
    end
endmodule