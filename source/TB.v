module TB;
    reg clk = 1'b0, rst = 1'b0;
    wire [31:0] IF_pc, ID_pc, Ex_pc, Mem_pc, Inst;

    InstructionFetch IF(clk, rst, 1'b0, 1'b0, 32'd0, IF_pc, Inst);
    IFReg IF_Reg(clk, rst, IF_pc, ID_pc);
    InstructionDecode ID(clk, rst, ID_pc);
    IDReg ID_Reg(clk, rst, ID_pc, Ex_pc);
    Execution Ex(clk, rst, Ex_pc);
    ExReg Ex_Reg(clk, rst, Ex_pc, Mem_pc);
    Memory Mem(clk, rst, Mem_pc);

    always #4 clk = ~clk;

    initial begin
        rst = 1'b1;
        #5
        rst = 1'b0;
        #1000
        $stop;
    end


endmodule
