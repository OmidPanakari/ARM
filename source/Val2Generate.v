module Val2Generate (
    select,
    val_rm,
    shift_operand,
    imm,
    val2
);
    input imm, select;
    input [11:0] shift_operand;
    input [31:0] val_rm;
    
    output reg [31:0] val2;

    assign immed8 = shift_operand[7:0];
    assign rotate_imm = shift_operand[11:8];
    assign shift = shift_operand[6:5];
    assign shift_imm = shift_operand[11:7];

    always @(select, val_rm, shift_operand, imm) begin
        if (select) begin
            val2 = {{20{shift_operand[11]}}, shift_operand};
        end
        else begin
            if (imm) begin
                val2 = {immed8, 24'd0, immed8} >> (rotate_imm * 2);
            end
                else begin
                    case (shift)
                        2'b00: val2 = val_rm << shift_imm;
                        2'b01: val2 = val_rm >> shift_imm;
                        2'b10: val2 = val_rm >>> shift_imm;
                        2'b11: val2 = {val_rm, val_rm} >> shift_imm;
                    endcase
                end
            end
        end
    endmodule