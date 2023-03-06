module InstructionFetch (
    clk,
    rst,
    branch_taken,
    freeze,
    branch_address,
    pc,
    instruction
);
    input clk, rst, freeze, branch_taken;
    input [31:0] branch_address;
    output reg [31:0] pc;
    output [31:0] instruction;
    wire [31:0] pc_in, next_pc;

    assign next_pc = 32'd4 + pc;
    assign pc_in = (branch_taken) ? branch_address : next_pc;
    always @(posedge clk, posedge rst) begin
        if (rst)
            pc <= 32'd0;
        else    
            pc <= pc_in;
    end
endmodule