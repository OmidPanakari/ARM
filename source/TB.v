module TB;
    reg clk=1'b1, rst=1'b0;

    always #5 clk = ~clk;
    initial begin
       rst = 1'b1;
       #10
       rst = 1'b0;
       #10000
       $stop; 
    end
    TopLevel TL(clk, rst);
endmodule