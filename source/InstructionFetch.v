module InstructionFetch (
    clk,
    rst,
    branch_taken,
    freeze,
    branch_address,
    pc,
    current_pc
);
    input clk, rst, freeze, branch_taken;
    input [31:0] branch_address;
    output [31:0] pc;
    wire [31:0] next_pc;
    output reg [31:0] current_pc;

    assign pc = 32'd4 + current_pc;
    assign next_pc = (branch_taken) ? branch_address : pc;
    always @(posedge clk, posedge rst) begin
        if (rst)
            current_pc <= 32'd0;
        else    
            current_pc <= (freeze) ? current_pc : next_pc;
    end
endmodule