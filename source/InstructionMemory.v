module InstructionMemory (
    address,
    instruction
);
    input [31:0] address;
    output [31:0] instruction;
    reg [31:0] mem [0:1023];

    initial begin
        mem[0] = 32'b1110_00_0_0100_0_0000_0001_000000000000;
        mem[1] = 32'b1110_00_0_0101_0_0000_0001_000000000000;
        mem[2] = 32'b1110_00_0_0110_0_0000_0001_000000000000;
        mem[3] = 32'b1110_00_0_0111_0_0000_0001_000000000000;
        mem[4] = 32'b1110_00_0_1000_0_0000_0001_000000000000;
        mem[5] = 32'b1110_00_0_1001_0_0000_0001_000000000000;
    end
    
    assign instruction = mem[address];
endmodule