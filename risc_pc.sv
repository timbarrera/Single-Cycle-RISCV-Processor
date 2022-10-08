`timescale 1ns / 1ps

module risc_pc(
    input clk,
    input nrst,
    input pc_src,
    input [31:0] addr_offset,
    output logic [31:0] addr_out 
    );
    
    always_ff@(posedge clk or negedge nrst)
        if(!nrst)
            addr_out <= 32'b0;
        else
            case(pc_src) 
                1'b0: addr_out <= addr_out + 32'd4;
                1'b1: addr_out <= addr_out + (addr_offset<<1'b1);
                default: addr_out <= addr_out + 32'd4;
            endcase
        
        
        
        
        
    
endmodule
