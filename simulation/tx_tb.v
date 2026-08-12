`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 08/12/2026 03:30:41 PM
// Design Name: UART TX Testbench
// Module Name: tx_tb
// Project Name: NexysA7_UART
// Target Devices: Nexys A7
// Tool Versions: Vivado 2025.2
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.01
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tx_tb();

    reg clk_tb;
    reg rst_n_tb;
    reg [7:0] data_in_tb;
    reg tx_start_tb;

    wire tx_tb;
    wire tx_busy_tb;
    wire tx_done_tb;

    tx tx_sim (
                    .clk100mhz(clk_tb),
                    .rst_n(rst_n_tb),
                    .data_in(data_in_tb),
                    .tx_start(tx_start_tb),
                    .tx(tx_tb),
                    .tx_busy(tx_busy_tb),
                    .tx_done(tx_done_tb)
              );    
          
    initial clk_tb = 1'b1; 
    always #5 clk_tb = ~clk_tb;    
    
    initial begin
        rst_n_tb = 1'b0;
        data_in_tb = 8'd0;
        tx_start_tb = 1'b0;
        
        #1 rst_n_tb = 1'b1;
        
        data_in_tb = 8'b00010001;
        #10_000 tx_start_tb = 1'b1; // Pulse 10001000
        #10 tx_start_tb = 1'b0;
        
        #30_000 data_in_tb = 8'b11101110;
        #10_000 tx_start_tb = 1'b1; // Pulse while busy
        #10 tx_start_tb = 1'b0;
        
        #100_000 data_in_tb = 8'b00010001;
        #10_000 tx_start_tb = 1'b1; // Pulse 10001000
        #10 tx_start_tb = 1'b0;
        
        #30_000 rst_n_tb = 1'b0;
        #10 rst_n_tb = 1'b1;    // Reset while transmitting
        #50_000 $finish;      
    end          

endmodule
