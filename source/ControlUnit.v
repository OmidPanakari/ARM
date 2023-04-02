module ControlUnit (
    mode,
    op_code,
    s,
    controls
);
    input s;
    input [1:0] mode;
    input [3:0] op_code;
    output [8:0] controls;
    reg [3:0] alu_command;
    reg mem_read, mem_write, b, s_out, wb_en;

    always @(mode, op_code, s) begin
        {mem_read, mem_write, wb_en} = 3'd1;
        case ({mode,op_code})
            6'b001101:  // MOV
                alu_command = 4'b0001;
            6'b001111:  // MOVN
                alu_command = 4'b1001;
            6'b000100:  // ADD
                alu_command = 4'b0010;
            6'b000101:  // ADC
                alu_command = 4'b0011;
            6'b000010:  // SUB
                alu_command = 4'b0100;
            6'b000110:  // SBC
                alu_command = 4'b0101;
            6'b000000:  // AND
                alu_command = 4'b0110;
            6'b001100:  // ORR
                alu_command = 4'b0111;
            6'b000001:  // EOR
                alu_command = 4'b1000;
            6'b001010:  // CMP
            begin
                alu_command = 4'b0100;
                wb_en = 1'b0;
            end
            6'b001000:  // TST
            begin
                alu_command = 4'b0110;
                wb_en = 1'b0;
            end
            6'b010100:  // LDR & STR
            begin
                alu_command = 4'b0010;
                mem_read = s;
                mem_write = ~s;
                wb_en = ~s;
            end
            default:
                alu_command = 4'b0000;
        endcase
        b = (mode == 2'b10);
        s_out = (mode == 2'b00) ? s : 1'b0;
    end
    assign controls = {wb_en, mem_read, mem_write, alu_command, b, s_out};

endmodule