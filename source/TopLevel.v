module TopLevel (
    clk,
    rst
);
    input clk, rst;
    wire two_src, imm_out, ID_wb_en, ID_mem_read, ID_mem_write, ID_imm, ID_b, ID_s;
    wire [3:0] dest, Rn, ID_alu_command, ID_dest, ID_status;
    wire [8:0] controls;
    wire [11:0] shift_operand, ID_shift_operand;
    wire [23:0] signed_imm, ID_signed_imm;
    wire [31:0] pc, IF_pc, ID_pc, Ex_pc, Mem_pc, instruction, val_Rn, val_Rm, ID_val_Rn, ID_val_Rm,
        IF_instruction;

    // IF
    InstructionFetch IF(clk, rst, 1'b0, 1'b0, 32'd0, pc, instruction);
    IFReg IF_Reg(clk, rst, 1'd0, 1'd0, pc, instruction, IF_pc, IF_instruction);

    // ID
    InstructionDecode ID(clk, rst, 1'd0, 4'd0, 32'd0, 1'd0, 4'd0, IF_instruction, two_src, controls, 
        val_Rn, val_Rm, imm_out, shift_operand, signed_imm, dest, Rn);
    IDReg ID_Reg(clk, rst, IF_pc, controls[8], controls[7], controls[6], controls[5:2], controls[1], 
        controls[0], val_Rn, val_Rm, shift_operand, imm_out, signed_imm, dest, 1'd0, 4'd0, ID_wb_en,
        ID_mem_read, ID_mem_write, ID_alu_command, ID_b, ID_s, ID_val_Rn, ID_val_Rm, ID_shift_operand,
        ID_imm, ID_signed_imm, ID_dest, ID_status, ID_pc);
    
    // EX
    Execution Ex(clk, rst, ID_pc);
    ExReg Ex_Reg(clk, rst, ID_pc, Ex_pc);

    // MEM
    Memory Mem(clk, rst, Ex_pc);
    MemReg Mem_Reg(clk, rst, Ex_pc, Mem_pc);

    // WB
    WriteBack WB(clk, rst, Mem_pc);


endmodule
