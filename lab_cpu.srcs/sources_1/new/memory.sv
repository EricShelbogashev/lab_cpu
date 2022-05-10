module memory (
    input clk,
    input logic [4:0] addr,
    input logic [7:0] din,
    output logic [7:0] dout,
    input logic we,
    output logic [7:0] perify_wire
);

logic [7:0] m [31:0];

assign dout = m[addr];
assign perify_wire = m[19];

always_ff @(posedge clk) begin
    if (we == 1'b1)
        m[addr] <= din;
end

initial $readmemb("memory.mem", m, 0, 30);
initial $readmemb("in.txt", m, 31, 31);

endmodule