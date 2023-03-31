module ControlUnit (
    mode,
    op_code,
    s,
    controls
);
    input s;
    input [1:0] mode;
    input [3:0] op_code;

    wire [3:0] alu_command;
    wire mem_read, mem_write, b, status;

    always @(mode, op_code, s) begin
        {mem_read, mem_write} = 2'd0;
        case ({mode,op_code})
            6'b001101:
                alu_command = 4'b0001;
            6'b001111:
                alu_command = 4'b1001;
            6'b001111:
                alu_command = 4'b1001;
            6'b000100:
                alu_command = 4'b0010;
            6'b000101:
                alu_command = 4'b0011;
            6'b000010:
                alu_command = 4'b0100;
            6'b000110:
                alu_command = 4'b0101;
            6'b000000:
                alu_command = 4'b0110;
            6'b001100:
                alu_command = 4'b0111;
            6'b000001:
                alu_command = 4'b1000;
            6'b001010:
                alu_command = 4'b0100;
            6'b001000:
                alu_command = 4'b0110;
            6'b010100:
                alu_command = 4'b0010;
                mem_read = s;
                mem_write = ~s;
            default:
                alu_command = 4'b0000;
        endcase
        b = (mode == 2'b10);
        status = (mode == 2'b00) ? s : 1'b0;
    end

endmodule