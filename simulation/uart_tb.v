`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 08/12/2026 07:17:28 PM
// Design Name: UART connected TX and RX simulation
// Module Name: uart_tb
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


module uart_tb();

    reg clk_tb;
    reg rst_n_tb;
    reg [7:0] data_in_tb;
    reg tx_start_tb;
    
    wire tx_tb;
    wire tx_busy_tb;
    wire tx_done_tb;
    
    wire rx_tb;
    wire rx_busy_tb;
    wire rx_done_tb;
    wire rx_error_tb;
    
    wire [7:0] data_out_tb; 
    
    assign rx_tb = tx_tb;
    
    tx uart_tx_sim(
                        .clk100mhz(clk_tb),
                        .rst_n(rst_n_tb),
                        .data_in(data_in_tb),
                        .tx_start(tx_start_tb),
                        .tx(tx_tb),
                        .tx_busy(tx_busy_tb),
                        .tx_done(tx_done_tb)  
                  );
           
    rx uart_rx_sim(
                        .clk100mhz(clk_tb),
                        .rst_n(rst_n_tb),
                        .rx(rx_tb),
                        .rx_busy(rx_busy_tb),
                        .rx_done(rx_done_tb),
                        .rx_error(rx_error_tb),
                        .data_out(data_out_tb)  
                  );
              
    initial clk_tb = 1'b0;
    always #5 clk_tb = ~clk_tb;
    
    initial begin
        rst_n_tb = 1'b0;
        data_in_tb = 8'hAA;     // Transmit 10101010
        tx_start_tb = 1'b0;
        #1 rst_n_tb = 1'b1;
        tx_start_tb = 1'b1;
        #20 tx_start_tb = 1'b0;
        #100_000;
        
        data_in_tb = 8'h55;     // Transmit 01010101   
        tx_start_tb = 1'b1;
        #20 tx_start_tb = 1'b0;
        #100_000;
        
        data_in_tb = 8'hFF;     // Transmit 11111111
        tx_start_tb = 1'b1;
        #20 tx_start_tb = 1'b0;
        #100_000;
        
        data_in_tb = 8'h00;     // Transmit 00000000
        tx_start_tb = 1'b1;
        #20 tx_start_tb = 1'b0;
        #200_000 $finish;
    end                                        

endmodule
