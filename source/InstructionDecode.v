module InstructionDecode (
    clk,
    rst,
    hazard,
    wb_dest,
    wb_value,
    wb_en,
    condition_check,
    instruction,
    pc,
    two_src,
    controls_out,
    pc_out,
    val_rn,
    val_rm,
    imm_out,
    shift_operand,
    dest,
    rn
);
    input clk, rst, hazard, wb_en;
    input [3:0] condition_check, wb_dest;
    input [31:0] instruction, wb_value, pc;


    output two_src, imm_out;
    output [8:0] controls_out;
    output [31:0] pc_out;
    output [31:0] val_rn;
    output [31:0] val_rm;
    output [11:0] shift_operand;
    output [23:0] signed_imm;
    output [3:0] dest, rn;


    wire imm, s, condition_check_out, mem_write_en;
    wire[1:0] mode;
    wire[3:0] cond, op_code, rd. rm;
    wire [8:0] controls;


    assign imm = instruction[25];
    assign imm_out = imm;
    assign signed_imm = instruction[23:0];
    assign shift_operand = instruction[11:0];
    assign mem_write_en = controls_out[6]
    assign cond = instruction[31:28];
    assign op_code = instruction[24:21];
    assign s = instruction[20];
    assign mode = instruction[27:26];
    assign rn = instruction[19:16];
    assign rd = instruction[15:12];
    assign dest = rd;
    assign rm = instruction[3:0];
    assign controls_out = ~condition_check_out | hazard ? controls : 9'd0;
    assign two_src = ~imm | mem_write_en;


    ConditionCheck conditionCheck(cond, condition_check, condition_check_out);
    ControlUnit controlUnit(mode, op_code, s, controls);
    RegisterFile registerFile(clk, rst, rn, mem_write_en ? rd : rm, wb_dest, wb_value, wb_en, val_rn, val_rm);

endmodule