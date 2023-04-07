module ALU (
    alu_command,
    status,
    val1,
    val2,
    alu_res,
    status_out
);
    input [3:0] alu_command, status;
    input [31:0] val1, val2;

    output [3:0] status_out;
    output reg [31:0] alu_res;

    wire c_in;
    reg n, z, c, v;

    assign c_in = status[1];
    always @(alu_command, c_in, val1, val2) begin
        alu_res = 32'd0;
        {n, z, c, v} = 4'd0;
        case (alu_command)
            4'b0001: alu_res = val2;
            4'b1001: alu_res = ~val2;
            4'b0010: begin
                {c, alu_res} = val1 + val2; 
                v = (val1[31] == val2[31] && val1[31] == ~alu_res[31]);
            end
            4'b0011: begin
                {c, alu_res} = val1 + val2 + c_in;
                v = (val1[31] == val2[31] && val1[31] == ~alu_res[31]);
            end
            4'b0100: begin
                {c, alu_res} = val1 - val2;
                v = (val1[31] == ~val2[31] && val1[31] == ~alu_res[31]);
            end
            4'b0101: begin
                {c, alu_res} = val1 - val2 - ~c_in;
                v = (val1[31] == ~val2[31] && val1[31] == ~alu_res[31]);
            end
            4'b0110: alu_res = val1 & val2;
            4'b0111: alu_res = val1 | val2;
            4'b1000: alu_res = val1 ^ val2;
        endcase
        z = (alu_res == 0);
        n = alu_res[31];
    end

    assign status_out = {n, z, c, v};

endmodule