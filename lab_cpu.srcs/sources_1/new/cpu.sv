module cpu (
    input logic clk,
    output logic [6:0] dig0,
    output logic [6:0] dig1,
    output logic [6:0] dig2
);

logic [4:0] instructionPointer = 0;
logic [5:0] addr = 0;
logic [7:0] din, dout, temp = 0;
logic we = 0;
logic [7:0] perify_wire = 0;

memory mem (
    .clk(clk),
    .addr(addr),
    .din(din),
    .dout(dout),
    .we(we),
    .perify_wire(perify_wire) 
);

controlUnit cu (
    .clk(clk),
    .addr(addr),
    .din(din),
    .dout(dout),
    .we(we),  
    .temp(temp),
    .instructionPointer(instructionPointer)
);


    seven_seg s1(
        .number(perify_wire % 10),
        .digit(dig0)
    );
    
    seven_seg s2(
        .number((perify_wire / 10) % 10),
        .digit(dig1)
    );
    
    seven_seg s3(
        .number(perify_wire / 100),
        .digit(dig2)
    );

endmodule

module seven_seg(
    input [3:0] number,
    output logic [6:0] digit
    );
    always_comb begin
        case (number)
            4'd0:  digit = 7'b0111111;
            4'd1:  digit = 7'b0000110;
            4'd2:  digit = 7'b1011011;
            4'd3:  digit = 7'b1011001;
            4'd4:  digit = 7'b1100110;
            4'd5:  digit = 7'b1101101;
            4'd6:  digit = 7'b1111101;
            4'd7:  digit = 7'b0000111;
            4'd8:  digit = 7'b1111111;
            4'd9:  digit = 7'b1101111;
            4'd10:  digit = 7'b1110111;
            4'd11:  digit = 7'b0111100;
            4'd12:  digit = 7'b0111001;
            4'd13:  digit = 7'b1011110;
            4'd14:  digit = 7'b1111001;
            4'd15:  digit = 7'b1110001;
        endcase
        end
endmodule

