`timescale 1ns / 1ps


module risc_comb_controller(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    input zero,
    output wr_en,
    output alu_src,
    output [2:0] alu_op,
    output pc_src,
    output [1:0] imm_src,
    output mem_write,
    output [1:0] mem_to_reg   
    );
    
    logic [10:0] ctrl_line;
    logic [2:0] alu_sel;
               
    assign {wr_en, alu_src, pc_src, imm_src, mem_write, mem_to_reg} = ctrl_line;
    assign alu_op = alu_sel;
    
    always_comb
        case(opcode)
            7'b0000011: ctrl_line <= 8'b11000001; //lw
            7'b0100011: ctrl_line <= 8'b01001100; //sw
            7'b0110011: ctrl_line <= 8'b10000000; //r
            7'b0010011: ctrl_line <= 8'b11000000; //i
            7'b1100011: 
                if (funct3==3'b000)
                    ctrl_line <= {2'b0, zero, 5'b10000}; //beq
                else 
                    ctrl_line <= {2'b0, ~zero, 5'b10000}; //bne
            7'b1101111: ctrl_line <= 8'b10111010; //j
            default: ctrl_line <= 8'b00000000; 
        endcase
    

    always_comb begin
        if(opcode == 7'b0110011 || opcode == 7'b0010011) //i or r
            if(funct7==7'b0100000)
                alu_sel <= 3'b001; //sub
            else 
                case(funct3)
                    3'b000: alu_sel <= 3'b000; //add
                    3'b111: alu_sel <= 3'b010; //and
                    3'b110: alu_sel <= 3'b011; //or
                    3'b001: alu_sel <= 3'b100; //sll
                    3'b101: alu_sel <= 3'b101; //srl
                endcase
         else 
            alu_sel <= 3'b000;
    end       
     

endmodule
