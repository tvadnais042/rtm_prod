`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rohith Saradhy
// 
// Create Date: 09/10/2020 05:25:24 PM
// Design Name: 
// Module Name: DDMTD_Array
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: Array of DDMTD Samplers...
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DDMTD_Array
#(
    parameter  NUM_DDMTD  = 2, //Number of DDMTD 
    parameter  DATA_WIDTH = 32,
    parameter  C_M_START_COUNT	=32
 )

(
//Signal
input wire                  clk_ref,
input wire [NUM_DDMTD-1:0]  clk_beat,
input wire [DATA_WIDTH-1:0] external_counter,
input wire                  reset,
input wire                  enable_sampling_logic,

//AXIS lines
input  wire  M_AXIS_ACLK,
// 
input  wire  M_AXIS_ARESETN, //RESET when low.
// Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
output wire  M_AXIS_TVALID,
// TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
output wire  [DATA_WIDTH*NUM_DDMTD-1 : 0] M_AXIS_TDATA,
// TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
output wire  [(DATA_WIDTH/8)*NUM_DDMTD-1 : 0] M_AXIS_TSTRB,
// TLAST indicates the boundary of a packet.
output wire  M_AXIS_TLAST,
// TREADY indicates that the slave can accept a transfer in the current cycle.
input  wire  M_AXIS_TREADY,

input wire [31:0] WORDS_TO_SEND, //Not used...

output wire [NUM_DDMTD-1:0] PROG_FULL
);

//Declaring nets
genvar m;
generate
    for (m=0;m<NUM_DDMTD;m=m+1) begin:net

        wire [DATA_WIDTH-1:0] tdata;
        wire [(DATA_WIDTH/8)-1 : 0] tstrb;
        wire tlast;
        wire tvalid;
        wire enable_read_logic;
        wire [NUM_DDMTD-1:0] enable_read_logic_dummy;

    end:net
endgenerate

wire [NUM_DDMTD-1:0] tlast_dummy;
wire [NUM_DDMTD-1:0] tvalid_dummy;





// use generate-loop to instantiate DDMTD_Array
genvar i; 
generate 
    for (i=0;i<NUM_DDMTD;i=i+1) begin:ddmtd_inst
        DDMTD_Sampler
        #(
        .DATA_WIDTH(DATA_WIDTH),
        .C_M_START_COUNT(C_M_START_COUNT)
        )
        DDMTD_i
        (
        // Inputs for the sampling logic
        .enable_sampling_logic(enable_sampling_logic), //Active High
        .clk_ref(clk_ref),
        .clk_beat(clk_beat[i]),
        .external_counter(external_counter),
        .reset(reset),


        // Fifo chain to AXIS
        .M_AXIS_ACLK(M_AXIS_ACLK),
        .M_AXIS_ARESETN(M_AXIS_ARESETN), //RESET when low.
        .M_AXIS_TREADY(M_AXIS_TREADY),
        .M_AXIS_TDATA(net[i].tdata),  
        .M_AXIS_TSTRB(net[i].tstrb),
        .M_AXIS_TVALID(net[i].tvalid), //output
        .M_AXIS_TLAST(net[i].tlast),
        .enable_read_logic(1),
        .WORDS_TO_SEND(WORDS_TO_SEND), //Not used
        .prog_full(PROG_FULL[i])
        );



        // connections to the nets...
        assign M_AXIS_TDATA[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH ] = net[i].tdata;
        assign M_AXIS_TSTRB[(i+1)*DATA_WIDTH/8-1:i*DATA_WIDTH/8 ] = net[i].tstrb;
        assign tlast_dummy[i] = net[i].tlast;
        assign tvalid_dummy[i] = net[i].tvalid;
    end: ddmtd_inst
endgenerate

  assign M_AXIS_TLAST  = &tlast_dummy;
  assign M_AXIS_TVALID = |tvalid_dummy;





// genvar j;
// generate
//     for (i=0;i<NUM_DDMTD;i=i+1)begin 
//         for (j=0;j<NUM_DDMTD;j=j+1)begin
//             if(i!=j)
//             assign net[i].enable_read_logic_dummy[j] = net[j].tvalid;
//             else
//             assign net[i].enable_read_logic_dummy[j]  =  1;
//         end
//         assign net[i].enable_read_logic = (&net[i].enable_read_logic_dummy);
//     end
// endgenerate


endmodule
