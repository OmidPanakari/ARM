module HazardUnit(
    exe_wb_en, 
    exe_dest, 
    mem_wb_en, 
    mem_dest, 
    en,
    src2, 
    two_src, 
    src1, 
    freeze
);
    input two_src, mem_wb_en, exe_wb_en, en;
    input [3:0] src1, src2, exe_dest, mem_dest;

    output freeze;

    assign freeze = ((src1 == exe_dest) && exe_wb_en) || 
                    ((src1 == mem_dest) && mem_wb_en && en) || 
                    ((src2 == exe_dest) && exe_wb_en && two_src) || 
                    ((src2 == mem_dest) && mem_wb_en && two_src && en);
endmodule