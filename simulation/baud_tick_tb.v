`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 08/12/2026 04:30:17 PM
// Design Name: Baud tick generator testbench
// Module Name: baud_tick_tb
// Project Name: NexysA7_UART
// Target Devices: Nexys A7
// Tool Versions: Vivado 2025.2
// Description: Waveform simulation
// 
// Dependencies: 
// 
// Revision: 0.01
// Revision 0.01 - File Created
// Additional Comments: 
// 
//////////////////////////////////////////////////////////////////////////////////

module baud_tick_tb();

    reg clk_tb;
    reg rst_n_tb;
    reg en_tb;
    reg restart_tb;
    
    wire baud_tick_tb;
    wire baud_half_tick_tb;

    baud_tick tick_gen(
                        .clk100mhz(clk_tb),
                        .rst_n(rst_n_tb),
                        .restart(restart_tb),
                        .en(en_tb),
                        .baud_tick(baud_tick_tb),
                        .baud_half_tick(baud_half_tick_tb)
                  ); 
              
    initial clk_tb = 1;
    always #5 clk_tb = ~clk_tb;
    
    initial begin
        rst_n_tb = 1'b0;
        en_tb = 1'b0;
        restart_tb = 1'b0;
        
        #1 rst_n_tb = 1'b1;   
        #10_000;        // ~1 tick disabled w enable
        en_tb = 1'b1;  
        #15_000;        // ~1.5 ticks enabled
        rst_n_tb = 1'b0;
        #10_000;        // ~1 tick disabled w rst_n
        rst_n_tb = 1'b1; 
        #5000;          // ~half tick enabled
        restart_tb = 1'b1;
        #10 restart_tb = 1'b0;
        #10_000;        // ~1 tick after restart
        $finish;        
    end                  

endmodule
