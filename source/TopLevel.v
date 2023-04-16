module TopLevel (
    clk,
    rst
);
    input clk, rst;
    wire two_src, imm_out, ID_wb_en, ID_mem_read, ID_mem_write, ID_imm, ID_b, ID_s, Ex_wb_en, Ex_mem_read_en,
        Ex_mem_write_en, Mem_wb_en, Mem_mem_read_en, freeze;
    wire [3:0] dest, Rn, ID_alu_command, ID_dest, ID_status, status, Ex_dest, status_out,
        Mem_dest, src2;
    wire [8:0] controls;
    wire [11:0] shift_operand, ID_shift_operand;
    wire [23:0] signed_imm, ID_signed_imm;
    wire [31:0] pc, IF_pc, ID_pc, Ex_pc, Mem_pc, instruction, val_Rn, val_Rm, ID_val_Rn, ID_val_Rm,
        IF_instruction, alu_res, branch_address, value, Mem_alu_res, Mem_value, wb_value, Ex_alu_res,
        Ex_val_rm;

    // IF
    InstructionFetch IF(clk, rst, ID_b, freeze, branch_address, pc, instruction);
    IFReg IF_Reg(clk, rst, freeze, ID_b, pc, instruction, IF_pc, IF_instruction);

    // ID
    InstructionDecode ID(clk, rst, freeze, Mem_dest, wb_value, Mem_wb_en, status_out, IF_instruction, two_src, controls, 
        val_Rn, val_Rm, imm_out, shift_operand, signed_imm, dest, Rn, src2);
    IDReg ID_Reg(clk, rst, IF_pc, controls[8], controls[7], controls[6], controls[5:2], controls[1], 
        controls[0], val_Rn, val_Rm, shift_operand, imm_out, signed_imm, dest, ID_b, status_out, ID_wb_en,
        ID_mem_read, ID_mem_write, ID_alu_command, ID_b, ID_s, ID_val_Rn, ID_val_Rm, ID_shift_operand,
        ID_imm, ID_signed_imm, ID_dest, ID_status, ID_pc);
    
    // EX
    Execution Ex(clk, rst, ID_mem_write, ID_mem_read, ID_val_Rn, ID_val_Rm, ID_shift_operand, 
        ID_imm, ID_signed_imm, ID_alu_command, ID_pc, ID_status, alu_res, branch_address, status);
    ExReg Ex_Reg(clk, rst, ID_wb_en, ID_mem_read, ID_mem_write, alu_res, ID_val_Rm, ID_dest, 
        Ex_wb_en, Ex_mem_read_en, Ex_mem_write_en, Ex_alu_res, Ex_val_rm, Ex_dest);
    StatusReg status_reg(clk, rst, ID_s, status, status_out);

    // MEM
    Memory Mem(clk, rst, Ex_mem_write_en, Ex_mem_read_en, Ex_alu_res, Ex_val_rm, value);
    MemReg Mem_Reg(clk, rst, Ex_wb_en, Ex_mem_read_en, Ex_alu_res, value, Ex_dest, Mem_wb_en, Mem_mem_read_en,
        Mem_alu_res, Mem_value, Mem_dest);
    HazardUnit hazard(ID_wb_en, ID_dest, Ex_wb_en, Ex_dest, src2, two_src, Rn, freeze);

    // WB
    WriteBack WB(clk, rst, Mem_mem_read_en, Mem_alu_res, Mem_value, wb_value);


endmodule
