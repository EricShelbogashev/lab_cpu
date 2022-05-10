module TB_CPU();
logic clk;
always begin
clk = !clk;
#1;
end

endmodule
