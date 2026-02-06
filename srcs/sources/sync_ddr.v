`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2021 06:16:51 AM
// Design Name: 
// Module Name: sync_ddr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sync_ddr(
    input clk,
    input D,
    output Q

    );




    // IDDRE1: Dedicated Dual Data Rate (DDR) Input Register
//         UltraScale
// Xilinx HDL Language Template, version 2019.1
IDDRE1 #(   
.DDR_CLK_EDGE("OPPOSITE_EDGE"),
   // IDDRE1 mode (OPPOSITE_EDGE, SAME_EDGE, SAME_EDGE_PIPELINED)
   .IS_CB_INVERTED(1'b1),          // Optional inversion for CB
   .IS_C_INVERTED(1'b0)            // Optional inversion for C
)
IDDRE1_inst (
   .Q1(Q), // 1-bit output: Registered parallel output 1
//    .Q2(Q2), // 1-bit output: Registered parallel output 2
   .C(clk),   // 1-bit input: High-speed clock
   .CB(clk), // 1-bit input: Inversion of High-speed clock C
   .D(D),   // 1-bit input: Serial Data Input
   .R(1'b0)    // 1-bit input: Active High Async Reset
);
// End of IDDRE1_inst instantiation
endmodule

//module sync_ff(
//input clk,
//input D,
//output Q
//);



//wire Q0;
//   FDRE
//   #(
//      .INIT(1'b0)//Initialvalueofregister(1'b0or1'b1)
//   )
//   FDRE_inst1(
//   .Q(Q0),//1-bit Data output
//   .C(clk),//1-bit Clock input
//   .CE(1'b0), //1-bit Clock enable input
//   .R(1'b1),//1- bit Synchronous reset input
//   .D(D)//1 -bit Data input
//   );

//   FDRE
//   #(
//      .INIT(1'b0)//Initialvalueofregister(1'b0or1'b1)
//   )
//   FDRE_inst2(
//   .Q(Q),//1-bit Data output
//   .C(clk),//1-bit Clock input
//   .CE(1'b1), //1-bit Clock enable input
//   .R(1'b0),//1- bit Synchronous reset input
//   .D(Q0)//1 -bit Data input
//   );

//endmodule
