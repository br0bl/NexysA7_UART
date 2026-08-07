`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 08/07/2026 12:18:19 AM
// Design Name: Baud tick generator
// Module Name: baud_tick
// Project Name: UART_Project
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

module baud_tick#(parameter baud_rate = 115200) 
                (
                    input clk100mhz,
                    input rst_n,
                    input en,
                    output reg baud_tick
                );
                
    localparam cycles = 100_000_000/baud_rate;        
    reg [$clog2(cycles)-1:0] counter;
        
    always@(posedge clk100mhz) begin
        if(!rst_n || !en) begin 
            counter <= 0;
            baud_tick <= 0;
        end
        else begin
        
            if(counter == (cycles - 1)) begin
                counter <= 0;
                baud_tick <= 1;
            end
            else begin
                baud_tick <= 0;
                counter <= counter + 1;
            end     
                 
        end
   
    end                     
                
endmodule
