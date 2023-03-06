module ConditionCheck(
    cond,
    condition_check,
    out
);
    input [3:0] cond, condition_check;
    reg result;
    output out;
    wire z_wire, n_wire, c_wire, v_wire;
    assign z_wire = condition_check[2];
    assign n_wire = condition_check[3];
    assign c_wire = condition_check[1];
    assign v_wire = condition_check[0];
    assign out = result;
    always @(cond) begin
        case (cond)
            4'd0: 
                result = z_wire;
            4'd1:
                result = ~z_wire;
            4'd2:
                result = c_wire;
            4'd3:
                result = ~c_wire;
            4'd4:
                result = n_wire;
            4'd5:
                result = ~n_wire;
            4'd6:
                result = v_wire;
            4'd7:
                result = ~v_wire;
            4'd8:
                result = c_wire & ~z_wire;
            4'd9:
                result = ~c_wire | z_wire;
            4'd10:
                result = n_wire == v_wire;
            4'd11:
                result = n_wire != v_wire;
            4'd12:
                result = ~z_wire & (v_wire == n_wire);
            4'd13:
                result = z_wire | (v_wire != n_wire);
            default: 
                result = 1'b1;
        endcase
    end
endmodule