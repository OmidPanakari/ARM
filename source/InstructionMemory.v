module InstructionMemory (
    address,
    instruction
);
    input [31:0] address;
    output [31:0] instruction;
    reg [31:0] mem [0:1023];

    initial begin
        mem[0] = 32'b1110_00_0_0000_0_0000_0000_000000000000; // NOP
        mem[1] = 32'b1110_00_0_1101_0_0000_0000_000000000000; // MOV
        mem[2] = 32'b1110_00_0_1111_0_0000_0001_000000000000; // MVN
        mem[3] = 32'b1110_00_0_0100_0_0000_0001_000000000000; // ADD
        mem[4] = 32'b1110_00_0_0101_0_0000_0001_000000000000; // ADC
        mem[5] = 32'b1110_00_0_0010_0_0000_0001_000000000000; // SUB
        mem[6] = 32'b1110_00_0_0110_0_0000_0001_000000000000; // SBC
        mem[7] = 32'b1110_00_0_0000_0_0000_0001_000000000000; // AND
        mem[8] = 32'b1110_00_0_1100_0_0000_0001_000000000000; // ORR
        mem[9] = 32'b1110_00_0_0001_0_0000_0001_000000000000; // EOR
        mem[10] = 32'b1110_00_0_1010_1_0000_0001_000000000000; // CMP
        mem[11] = 32'b1110_00_0_1000_1_0000_0001_000000000000; // TST
        mem[12] = 32'b1110_01_0_0100_1_0000_0001_000000000000; // LDR
        mem[13] = 32'b1110_01_0_0100_0_0000_0001_000000000000; // STR
        mem[14] = 32'b1110_10_1_0_000000000000000000000000; // EOR
    end
    
    assign instruction = mem[(address >> 2)];
endmodule