`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 08/12/2026 05:06:41 PM
// Design Name: rx synchronizer testbench
// Module Name: rx_sync_tb
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


module rx_sync_tb();

    reg clk_tb;
    reg rst_n_tb;
    reg rx_tb;
    
    wire rx_synced_tb;
    wire rx_fallen_edge_tb;

    rx_sync synchronizer_sim(
                                .clk100mhz(clk_tb),
                                .rst_n(rst_n_tb),
                                .in(rx_tb),
                                .synced_out(rx_synced_tb),
                                .falling_edge(rx_fallen_edge_tb)
                            );
                        
    initial clk_tb = 1'b0; 
    always  #5 clk_tb = ~clk_tb;
    
    initial begin
        rst_n_tb = 1'b0;
        rx_tb = 1'b0;           // initial rx low -> rx_synced stays high after reset for 2 clock cycles then goes low and falling edge pulses
        #1 rst_n_tb = 1'b1;
        @(negedge clk_tb) rx_tb = 1'b1;     // rx high -> shows after 2 clock cycles
        @(negedge clk_tb) rx_tb = 1'b0;     // rx low -> never shows because
        @(negedge clk_tb) rst_n_tb = 1'b0;  // reset is asserted after one clock cycle
        @(negedge clk_tb) $finish;
    end                            

endmodule
