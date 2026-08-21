`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 08/20/2026 02:30:20 PM
// Design Name: NexysA7 UART
// Module Name: top_uart
// Project Name: NexysA7_UART
// Target Devices: Nexys A7
// Tool Versions: Vivado 2025.2
// Description: JA1 = Tx | Ja2 = Rx
//              tx_led = {tx_start, tx_busy, tx_done} = led[15:13]
//              rx_led = {rx_error, rx_busy, rx_done} = led[12:10] 
//              Data in = sw[7:0] | Data out = led[7:0]
// 
// Dependencies: 
// 
// Revision: 0.01
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top_uart(   
                    input clk100mhz, 
                    input [7:0] sw,
                    input btnc,
                    input btnd,
                    input gpio_in,
                    output wire gpio_out,
                    output wire [2:0] tx_led,
                    output wire [2:0] rx_led,
                    output wire [7:0] data_led
               );
           
    wire start;
            
    debounce tx_start_debounce(
                                    .clk(clk100mhz),
                                    .rst_n(~btnd),
                                    .btn_raw(btnc),
                                    .btn_pulse(start)
                              );    
                              
    assign tx_led[2] = start;
           
    tx uart_tx(
                    .clk100mhz(clk100mhz),
                    .rst_n(~btnd),
                    .data_in(sw),
                    .tx_start(start),
                    .tx(gpio_out),
                    .tx_busy(tx_led[1]),
                    .tx_done(tx_led[0])  
              );

    rx uart_rx(
                    .clk100mhz(clk100mhz),
                    .rst_n(~btnd),
                    .rx(gpio_in),
                    .rx_error(rx_led[2]),
                    .rx_busy(rx_led[1]),
                    .rx_done(rx_led[0]),
                    .data_out(data_led)  
              );              
               
endmodule
