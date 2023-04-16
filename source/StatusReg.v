module StatusReg (
    clk,
    rst,
    s,
    status,
    status_out
);
    input clk, rst, s;
    input [3:0] status;

    output reg [3:0] status_out;

    always @(negedge clk, posedge rst) begin
        if (rst) begin
            status_out <= 4'd0;
        end
        else begin
            status_out <= (s) ? status : status_out;
        end
    end
endmodule