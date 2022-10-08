`timescale 1ns / 1ps


module tb_riscv_reg(
    );
    
    logic clk, nrst, wr_en;
    logic [4:0] wr_addr, rd_addrA, rd_addrB;
    logic [31:0] wr_data;
    wire [31:0] rd_dataA, rd_dataB;
    
    riscv_reg UUT(
    .clk(clk),
    .nrst(nrst),
    .wr_en(wr_en),
    .wr_addr(wr_addr),
    .wr_data(wr_data),
    .rd_addrA(rd_addrA),
    .rd_addrB(rd_addrB),
    .rd_dataA(rd_dataA),
    .rd_dataB(rd_dataB)
    );
    
    always begin #10; clk <= !clk; end
    
    initial begin
    clk = 0;
    nrst = 0;
    wr_en = 0;
    rd_addrA = 5'd0;
    rd_addrB = 5'd0;  
    #50;
    nrst = 1;
    wr_en = 1;
    wr_addr = 5'd1;
    rd_addrA = 5'd1;
    wr_data = 32'd69; 
    #50;
    wr_addr = 5'd2;
    wr_data = 32'd420;
    rd_addrA = 5'd2;
    #50;
    wr_en = 0;
    wr_addr = 5'd1;
    wr_data = 32'd101;
    rd_addrB = 5'd2; 
    #50;
    $finish;
    end
    
    
    
endmodule
