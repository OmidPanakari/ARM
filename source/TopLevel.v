module TopLevel (
    clk,
    rst
);
    input clk, rst;
    wire [31:0] IF_pc, ID_pc, Ex_pc, Mem_pc, instruction, current_pc;

    InstructionFetch IF(clk, rst, 1'b0, 1'b0, 32'd0, IF_pc, current_pc);
    InstructionMemory IM(current_pc, instruction);
    IFReg IF_Reg(clk, rst, IF_pc, ID_pc);
    InstructionDecode ID(clk, rst, ID_pc);
    IDReg ID_Reg(clk, rst, ID_pc, Ex_pc);
    Execution Ex(clk, rst, Ex_pc);
    ExReg Ex_Reg(clk, rst, Ex_pc, Mem_pc);
    Memory Mem(clk, rst, Mem_pc);


endmodule
