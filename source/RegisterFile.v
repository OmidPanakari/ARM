module RegisterFile (
    clk,
    rst,
    Rn,
    Rm,
    WB_dest,
    WB_value,
    WB_en,
    val_Rn,
    val_Rm
);
    input clk, rst, WB_en;
    input [3:0] Rn, Rm, WB_dest;
    input [31:0] WB_value;
    output [31:0] val_Rn, val_Rm;
    reg [31:0] registers[15:0];
    integer i;


    assign val_Rn = registers[Rn];
    assign val_Rm = registers[Rm];

    always @(negedge clk, posedge rst) begin
        if (WB_en)
            registers[WB_dest] <= WB_value;
        if (rst) begin
            for (i = 0; i < 16; i = i + 1) begin
                registers[i] <= i;
            end
        end
    end

endmodule