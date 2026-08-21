`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Dr. Aly & Ben Robles
// 
// Create Date: 08/20/2026 03:03:50 PM
// Design Name: Button Debounce
// Module Name: debounce
// Project Name: NexysA7_UART
// Target Devices: Nexys A7
// Tool Versions: Vivado 2025.2
// Description: Expanded example module from ECE3300
// 
// Dependencies: 
// 
// Revision: 0.01
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module debounce(
                    input wire clk,
                    input wire rst_n,
                    input wire btn_raw,
                    output wire btn_pulse
               );
    
    reg btn_clean;
    reg btn_prev;
    reg[2:0] state;
        
    assign btn_pulse = btn_clean && !btn_prev;
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            state <= 3'b000;
            btn_clean <= 1'b0;
            btn_prev <= 1'b0;
        end
        else begin
            state <= {state[1:0], btn_raw};            
            if(state == 3'b000) btn_clean <= 1'b0;
            else if (state == 3'b111) btn_clean <= 1;
            btn_prev <= btn_clean;
        end
    end
    
endmodule