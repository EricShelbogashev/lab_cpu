module controlUnit (
    input clk,
    output logic [4:0] addr,
    output logic [7:0] din,
    input logic [7:0] dout,
    output logic we,
    output logic [4:0] instructionPointer,
    output logic [7:0] temp
);


enum { ld, st, add, cmp, jmp, halt } instruction = ld;

//localparam term_range = 2;
//localparam st_range = 2;
//localparam ld_range = 2;
//localparam add_range = 2;
//localparam cmp_range = 2;
//localparam jmp_range = 2;
//localparam halt_range = 2;

logic [10:0] counter = 2;
logic [4:0] tmp_addr;
logic exitFlag = 1'b0;

always @ (posedge clk) begin
    if (exitFlag == 1'b1) begin
        if (counter == 0) begin
            counter = 50;
            // Parse
            case (din[7:5]) 
                3'b001: instruction = st;
                3'b010: instruction = ld;
                3'b011: instruction = add;
                3'b100: instruction = cmp;
                3'b101: instruction = jmp;
                3'b110: instruction = halt;
            endcase
            tmp_addr = din[4:0];
    
            // States
            case (instruction)    
                st:
                begin
                    we = 1;
                    addr = tmp_addr;
                    din = temp;
                end
    
                ld: 
                begin
                    we = 0;                
                    addr = tmp_addr;
                end
    
                add:
                begin
                    we = 0;
                    addr = tmp_addr;
                end
    
                cmp: 
                begin
                    we = 0;
                    addr = tmp_addr;
                end
    
                jmp: 
                begin
                    instructionPointer = tmp_addr;
                end
    
                halt: 
                begin
                    exitFlag = 1'b1;
                end
            endcase
        end
   
        if (counter == 3) begin
            case(instruction)
                ld: temp = dout;
                cmp:
                begin
                    if (dout > temp) instructionPointer = instructionPointer + 1;
                    else instructionPointer = instructionPointer + 2;
                end
                add: temp = temp + dout;
            endcase
        end
        if (counter == 2) begin
            addr = instructionPointer;
            we = 0;
        end;
        counter = counter - 1; 
    end
end


endmodule