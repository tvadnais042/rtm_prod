`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2020 08:37:30 PM
// Design Name: 
// Module Name: main
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


module main(
//    input wire CLK_REF_P,
//    input wire CLK_REF_N,

    input wire DDMTD_QP0,
    input wire DDMTD_QN0,

    input wire DDMTD_QP1,
    input wire DDMTD_QN1,
    input wire DDMTD_QP2,
    input wire DDMTD_QN2,
    input wire DDMTD_QP3,
    input wire DDMTD_QN3,
    input wire DDMTD_QP4,
    input wire DDMTD_QN4,

    output wire DDMTD_DP1,
    output wire DDMTD_DN1,
    output wire DDMTD_DP2,
    output wire DDMTD_DN2,
    output wire DDMTD_DP3,
    output wire DDMTD_DN3,
    output wire DDMTD_DP4,
    output wire DDMTD_DN4,

////=====================================
    output wire MEZZ2_TX1_P,
    output wire MEZZ2_TX1_N,
    output wire MEZZ2_TX2_P, //disconnect in intV1
    output wire MEZZ2_TX2_N, //disconnect in intV1
    output wire MEZZ2_TX3_P, //disconnect in intV1
    output wire MEZZ2_TX3_N, //disconnect in intV1
    output wire MEZZ2_TX4_P, //disconnect in intV1
    output wire MEZZ2_TX4_N, //disconnect in intV1

    input wire MEZZ2_RX1_P, //disconnect in intV1
    input wire MEZZ2_RX1_N, //disconnect in intV1
    input wire MEZZ2_RX2_P, //disconnect in intV1
    input wire MEZZ2_RX2_N, //disconnect in intV1
    input wire MEZZ2_RX3_P, //disconnect in intV1
    input wire MEZZ2_RX3_N, //disconnect in intV1
    input wire MEZZ2_RX4_P, //disconnect in intV1
    input wire MEZZ2_RX4_N, //disconnect in intV1

//=====================================
    output wire MEZZ3_TX1_P,
    output wire MEZZ3_TX1_N,
    output wire MEZZ3_TX2_P,
    output wire MEZZ3_TX2_N,
    output wire MEZZ3_TX3_P,
    output wire MEZZ3_TX3_N,
    output wire MEZZ3_TX4_P,
    output wire MEZZ3_TX4_N,
    
    input wire MEZZ3_RX1_P,
    input wire MEZZ3_RX1_N,
    input wire MEZZ3_RX2_P,
    input wire MEZZ3_RX2_N,
    input wire MEZZ3_RX3_P,
    input wire MEZZ3_RX3_N,
    input wire MEZZ3_RX4_P,
    input wire MEZZ3_RX4_N,

//=====================================
    output wire MEZZ4_TX1_P, //was PLL_IN1_P
    output wire MEZZ4_TX1_N, //was PLL_IN1_N
    output wire MEZZ4_TX2_P, //was PLL_IN2_P 
    output wire MEZZ4_TX2_N, //was PLL_IN2_N 
    output wire MEZZ4_TX3_P, //not connected on intV1
    output wire MEZZ4_TX3_N, //not connected on intV1
    output wire MEZZ4_TX4_P, //not connected on intV1
    output wire MEZZ4_TX4_N,  //not connected on intV1

    input wire MEZZ4_RX1_P, //not connected on intV1
    input wire MEZZ4_RX1_N, //not connected on intV1
    input wire MEZZ4_RX2_P, //not connected on intV1
    input wire MEZZ4_RX2_N, //not connected on intV1
    input wire MEZZ4_RX3_P, //not connected on intV1
    input wire MEZZ4_RX3_N, //not connected on intV1
    input wire MEZZ4_RX4_P, //not connected on intV1
    input wire MEZZ4_RX4_N //not connected on intV1

//    input wire PLLOUT_P,
//    input wire PLLOUT_N
    
    ); 
    
    reg [7:0] FIRMWARE_VER = 8'd30 ; // divide by 10 to get the firmware version

//     Bypassing SPI to DCPS
//    OBUFDS OBUFDS_MEZZ_PAGE0(.I(DAT0),.O(MEZZ_PAGE0_P),.OB(MEZZ_PAGE0_N));
//    OBUFDS OBUFDS_MEZZ_PAGE1(.I(DAT1),.O(MEZZ_PAGE1_P),.OB(MEZZ_PAGE1_N));
//    OBUFDS OBUFDS_MEZZ_PAGE2(.I(DAT2),.O(MEZZ_PAGE2_P),.OB(MEZZ_PAGE2_N));
//    OBUFDS OBUFDS_MEZZ_PAGE3(.I(DAT3),.O(MEZZ_PAGE3_P),.OB(MEZZ_PAGE3_N));
//    OBUFDS OBUFDS_SDIN(.I(SPI_KOSI),.O(SDIN_P),.OB(SDIN_N));
//    OBUFDS OBUFDS_SCK (.I(SPI_SCK),.O(SCK_P),.OB(SCK_N));
//    Swapped
//    OBUFDS OBUFDS_SDIN(.I(SPI_SCK),.O(SDIN_P),.OB(SDIN_N));
//    OBUFDS OBUFDS_SCK (.I(SPI_KOSI),.O(SCK_P),.OB(SCK_N));
//    OBUFDS OBUFDS_CS1B(.I(SPI_SSB1),.O(CS1B_P),.OB(CS1B_N));
//    OBUFDS OBUFDS_CS2B(.I(SPI_SSB1),.O(CS2B_P),.OB(CS2B_N));

    wire CLK, clk_ref;
    assign clk_ref = MEZZ4_RX1;

//=====================================================================
//    Bundling DDMTD pins
//=====================================================================
// CLK is what we send to all of the DDMTD flipflops
//    wire Q0,Q1,Q2,Q3,Q4;
    wire Q0_out,Q1_out,Q2_out,Q3_out,Q4_out;
   
   
    IBUFDS IBUFDS_Q0 (.O(Q0_out), .I(DDMTD_QP0), .IB(DDMTD_QN0)); //good
    sync_ddr sync_Q0(.clk(clk_ref),.D(Q0_out),.Q(Q0));

    IBUFDS IBUFDS_Q1 (.O(Q1_out), .I(DDMTD_QP1), .IB(DDMTD_QN1)); //good
    sync_ddr sync_Q1(.clk(clk_ref),.D(Q1_out),.Q(Q1));

    IBUFDS IBUFDS_Q2 (.O(Q2_out), .I(DDMTD_QP2), .IB(DDMTD_QN2)); //good
    sync_ddr sync_Q2(.clk(clk_ref),.D(Q2_out),.Q(Q2));

    IBUFDS IBUFDS_Q3 (.O(Q3_out), .I(DDMTD_QP3), .IB(DDMTD_QN3)); //good
    sync_ddr sync_Q3(.clk(clk_ref),.D(Q3_out),.Q(Q3));

    IBUFDS IBUFDS_Q4 (.O(Q4_out), .I(DDMTD_QP4), .IB(DDMTD_QN4)); //good
    sync_ddr sync_Q4(.clk(clk_ref),.D(Q4_out),.Q(Q4));

//    wire D1,D2,D3,D4;
//    wire D1_out,D2_out,D3_out,D4_out;
    
    OBUFDS OBUFDS_D1 (.I(CLK_QUAD), .O(DDMTD_DP1), .OB(DDMTD_DN1)); //good
//    sync_ddr sync_D1(.clk(clk_ref),.D(D1_out),.Q(D1));

    OBUFDS OBUFDS_D2 (.I(CLK_QUAD), .O(DDMTD_DP2), .OB(DDMTD_DN2)); //good
//    sync_ddr sync_D2(.clk(clk_ref),.D(D2_out),.Q(D2));
    
    OBUFDS OBUFDS_D3 (.I(CLK_QUAD), .O(DDMTD_DP3), .OB(DDMTD_DN3)); //good
//    sync_ddr sync_D3(.clk(clk_ref),.D(D3_out),.Q(D3));

    OBUFDS OBUFDS_D4 (.I(CLK_QUAD), .O(DDMTD_DP4), .OB(DDMTD_DN4)); //good
//    sync_ddr sync_D4(.clk(clk_ref),.D(D4_out),.Q(D4));


//=====================================================================
//     Generating a beat clock for DDMTD analysis
//=====================================================================
 
 
    parameter NUM_DDMTD = 24;
    parameter DATA_WIDTH = 32; 
    parameter START_COUNT = 32;
    parameter NUM_BYTES = DATA_WIDTH*8/8; // PER BRAM CONTROLLER
    integer WORDS_TO_SEND = 1024;
  
  //Simple counter to generate data
    reg beat_0_q1=0;
    reg beat_1_q1=0;
    integer counter_clkbeat=0;
    reg odd=0;
    always @(posedge clk_ref) begin
     // 100k subs
        counter_clkbeat<=counter_clkbeat+1;
        if(counter_clkbeat == 50000 ) begin
            beat_0_q1<=~beat_0_q1;
            beat_1_q1<=~beat_1_q1;
            counter_clkbeat <=0;
        end
    end

  // Each bit of this wire will be the clock
    wire [NUM_DDMTD-1:0]  clk_beat;
  
  /*Uncomment later when the HW is ready - Nishant*/
  assign clk_beat =  { 
                      beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,
                      beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,
                      beat_0_q1,beat_0_q1,beat_0_q1,Q4,Q3,Q2,Q1,Q0 
                     };

  // assign clk_beat =  { 
  //                     beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,
  //                     beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,CQ3      ,CQ2      ,CQ1      ,CQ0      ,
  //                     BQ3      ,BQ2      ,BQ1      ,BQ0      ,AQ3      ,AQ2      ,AQ1      ,AQ0 
  //                    };

  // assign clk_beat =  { 
  //                     beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,
  //                     beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,CQ3      ,CQ2      ,CQ1      ,CQ0      ,
  //                     BQ3      ,BQ2      ,BQ1      ,BQ0      ,AQ3      ,AQ2      ,BEAT_REF2      ,BEAT_REF1 
  //                    };
//   assign clk_beat =  { 
//                       beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,
//                        beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,
//                        beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1,beat_0_q1
//                      };
    

    wire [31:0]GPIO;
    wire user_reset;
    assign user_reset = GPIO[0];
    reg enable_sampling_logic=0;
    


  //Internal reset
  //Since clk_ref is the slower clock, we will run this as the reset counter...
    parameter RESET_COUNT = 1000000;
    parameter RESET_RUN   =  950000;
    reg internal_reset=1; //Active High
    integer reset_counter=0;
    always @(posedge clk_ref) begin 
        if(user_reset) begin
            internal_reset<=1;
            reset_counter <=0;
            enable_sampling_logic <=0;
        end
    
        if( reset_counter < RESET_COUNT)
            reset_counter<=reset_counter+1;
    
    
        if(reset_counter == RESET_RUN) internal_reset <=0;
        else if (reset_counter == RESET_COUNT)  enable_sampling_logic<=1;
    
    end
    



    reg [31:0] external_counter;
    // reg  [24:0] ddmtd_counter;
    // assign external_counter = ddmtd_counter;
    always @(negedge clk_ref) begin
        if(~enable_sampling_logic) begin
            external_counter=0;
        end
        else external_counter <= external_counter+1;
    end




    wire [DATA_WIDTH*NUM_DDMTD-1 : 0] TDATA;
    wire [(DATA_WIDTH*NUM_DDMTD/8)-1 : 0] TSTRB;
    wire TLAST;
    wire TVALID;
    reg  TREADY;
    wire TCLK;
    wire [NUM_DDMTD-1:0] PROG_FULL;
    wire RESETN;
  

  


 DDMTD_Array
#(
    .NUM_DDMTD(NUM_DDMTD),
    .DATA_WIDTH(DATA_WIDTH),
    .C_M_START_COUNT(START_COUNT)
 )
  DDMTD_Array_inst
 (
    // Inputs for the sampling logic
    .enable_sampling_logic(enable_sampling_logic), //Active High
    .clk_ref(clk_ref),
    .clk_beat(clk_beat),
    .external_counter(external_counter),
    .reset(internal_reset),
      

    // Fifo chain to AXIS
     .M_AXIS_ACLK(CLK),
     .M_AXIS_ARESETN(1'b1), //RESET when low.
     .M_AXIS_TVALID(TVALID), //output
     .M_AXIS_TDATA(TDATA),  
     .M_AXIS_TSTRB(TSTRB),
     .M_AXIS_TLAST(TLAST),
     .M_AXIS_TREADY(TREADY),
     .WORDS_TO_SEND(WORDS_TO_SEND),
     .PROG_FULL(PROG_FULL)

 );


  wire [31:0]BRAM_PORTB_0_addr;
  wire BRAM_PORTB_0_clk;
  wire [DATA_WIDTH*NUM_DDMTD-1:0]BRAM_PORTB_0_din;
  wire [DATA_WIDTH*NUM_DDMTD-1:0]BRAM_PORTB_0_dout;
  wire BRAM_PORTB_0_en;
  wire BRAM_PORTB_0_rst;
  wire [DATA_WIDTH*NUM_DDMTD/8-1:0]BRAM_PORTB_0_we;

  wire rsta_busy_0;
  wire rstb_busy_0;


  integer addr_pointer=0;
  integer word_counter;
  reg [DATA_WIDTH*NUM_DDMTD-1:0] data=0;
  reg [NUM_BYTES-1:0] we_byte=0;
  reg enable=1;

  reg enable_bram1 = 0; //used to write information to SOC
 


  always @(negedge CLK) begin

    if(internal_reset | ~GPIO[1]) begin
      addr_pointer <=0;
      word_counter <=0;
      we_byte <=0;
      WORDS_TO_SEND <=BRAM_PORTB_0_dout;
      TREADY<=0; 
      enable_bram1 <= 1;
    end
    else if(GPIO[1] & (word_counter<WORDS_TO_SEND)) begin
      enable_bram1 <= 0;
      TREADY<=1; //TREADY
      // data <= {word_counter,32'd5,32'd4,32'd3,32'd2,32'd1,WORDS_TO_SEND,TDATA[31:0]};
      data <= TDATA;
    
      addr_pointer <= addr_pointer + NUM_BYTES;
      word_counter <=word_counter +1;
      we_byte<={(NUM_BYTES){1'b1}};
    end
    else begin
      TREADY<=0; 
      we_byte <=0;
    end
  end
    
    
    assign BRAM_PORTB_0_clk = CLK_QUAD;
    
    //Test Counter...
    reg [31:0] clk_counter = 0;
    always @(posedge CLK) begin
        clk_counter <= clk_counter +1;
    end


    //Erich suggested changes for data synchronization...
    reg addr_pointer_sync;
    reg [DATA_WIDTH*NUM_DDMTD-1:0] BRAM_PORTB_0_data;
    reg [DATA_WIDTH*NUM_DDMTD-1:0] BRAM_PORTB_1_data;
    reg [DATA_WIDTH*NUM_DDMTD-1:0] BRAM_PORTB_2_data;
    reg [NUM_BYTES-1:0] we_byte_sync;
    reg [NUM_BYTES-1:0] we_byte_bram1_sync;



always @(negedge CLK) begin

    if (enable_bram1) begin
        BRAM_PORTB_1_data <= {internal_reset,clk_counter,FIRMWARE_VER,PROG_FULL} ;
        we_byte_bram1_sync <= {(NUM_BYTES){1'b1}};
        addr_pointer_sync <= 0;
    end
    else begin
        addr_pointer_sync <= addr_pointer;
        we_byte_sync <= we_byte;
        we_byte_bram1_sync <= we_byte;
        BRAM_PORTB_0_data <= data[255:0];
        BRAM_PORTB_1_data <= data[511:256];
        BRAM_PORTB_2_data <= data[767:512];
    end

end



design_1_wrapper desing_ins   
   (
    .BRAM_PORTB_0_addr(addr_pointer),
    .BRAM_PORTB_0_clk(CLK),
    .BRAM_PORTB_0_din(BRAM_PORTB_0_data),
    .BRAM_PORTB_0_dout(BRAM_PORTB_0_dout),
    .BRAM_PORTB_0_en(1),
    .BRAM_PORTB_0_we(we_byte_sync),

    .BRAM_PORTB_1_addr(addr_pointer),
    .BRAM_PORTB_1_clk(CLK),
    .BRAM_PORTB_1_din(BRAM_PORTB_1_data),
    // .BRAM_PORTB_1_dout(BRAM_PORTB_0_dout),
    .BRAM_PORTB_1_en(1),
    .BRAM_PORTB_1_we(we_byte_bram1_sync),

    .BRAM_PORTB_2_addr(addr_pointer),
    .BRAM_PORTB_2_clk(CLK),
    .BRAM_PORTB_2_din(BRAM_PORTB_2_data),
    // .BRAM_PORTB_2_dout,
    .BRAM_PORTB_2_en(1),
    .BRAM_PORTB_2_we(we_byte_sync),

    .CLK_QUAD(CLK_QUAD),
    .CLK_OUT(CLK),
    .gpio_rtl_tri_o(GPIO)

    );
    
    // // Mark signals for debug
    // reg [31:0] counter = 0;
    // wire test_signal;

    // always @(posedge CLK_QUAD) begin
    //     counter <= counter + 1;
    // end

    // assign test_signal = counter[24];
    
    // ila_0 ILADebugger(
    //     .clk(CLK_QUAD),
    //     .probe0(test_signal)
    // );
    
    
    // // PRBS implementation
    // wire prbs_out;
    // prbs prbs_inst(.CLK(CLK_QUAD),.prbs_out(prbs_out));
    

//=====================================================================
//  Bundling RX inputs
//=====================================================================

wire MEZZ2_RX1, MEZZ2_RX2, MEZZ2_RX3, MEZZ2_RX4;
wire MEZZ3_RX1, MEZZ3_RX2, MEZZ3_RX3, MEZZ3_RX4;
wire MEZZ4_RX1, MEZZ4_RX2, MEZZ4_RX3, MEZZ4_RX4;

IBUFDS IBUFDS_MEZZ2_RX1(.O(MEZZ2_RX1), .I(MEZZ2_RX1_P), .IB(MEZZ2_RX1_N)); 
IBUFDS IBUFDS_MEZZ2_RX2(.O(MEZZ2_RX2), .I(MEZZ2_RX2_P), .IB(MEZZ2_RX2_N));   
IBUFDS IBUFDS_MEZZ2_RX3(.O(MEZZ2_RX3), .I(MEZZ2_RX3_P), .IB(MEZZ2_RX3_N));
IBUFDS IBUFDS_MEZZ2_RX4(.O(MEZZ2_RX4), .I(MEZZ2_RX4_P), .IB(MEZZ2_RX4_N));

IBUFDS IBUFDS_MEZZ3_RX1(.O(MEZZ3_RX1), .I(MEZZ3_RX1_P), .IB(MEZZ3_RX1_N)); 
IBUFDS IBUFDS_MEZZ3_RX2(.O(MEZZ3_RX2), .I(MEZZ3_RX2_P), .IB(MEZZ3_RX2_N));   
IBUFDS IBUFDS_MEZZ3_RX3(.O(MEZZ3_RX3), .I(MEZZ3_RX3_P), .IB(MEZZ3_RX3_N));
IBUFDS IBUFDS_MEZZ3_RX4(.O(MEZZ3_RX4), .I(MEZZ3_RX4_P), .IB(MEZZ3_RX4_N));

IBUFDS IBUFDS_MEZZ4_RX1(.O(MEZZ4_RX1), .I(MEZZ4_RX1_P), .IB(MEZZ4_RX1_N)); // Supposed PLL returns
IBUFDS IBUFDS_MEZZ4_RX2(.O(MEZZ4_RX2), .I(MEZZ4_RX2_P), .IB(MEZZ4_RX2_N)); 
IBUFDS IBUFDS_MEZZ4_RX3(.O(MEZZ4_RX3), .I(MEZZ4_RX3_P), .IB(MEZZ4_RX3_N));
IBUFDS IBUFDS_MEZZ4_RX4(.O(MEZZ4_RX4), .I(MEZZ4_RX4_P), .IB(MEZZ4_RX4_N));


//=====================================================================
//  Assigning TX outputs
//=====================================================================

OBUFDS OBUFDS_MEZZ2_TX1(.I(MEZZ4_RX1),.O(MEZZ2_TX1_P),.OB(MEZZ2_TX1_N));
OBUFDS OBUFDS_MEZZ2_TX2(.I(MEZZ4_RX2),.O(MEZZ2_TX2_P),.OB(MEZZ2_TX2_N));
OBUFDS OBUFDS_MEZZ2_TX3(.I(MEZZ4_RX3),.O(MEZZ2_TX3_P),.OB(MEZZ2_TX3_N));
OBUFDS OBUFDS_MEZZ2_TX4(.I(CLK),.O(MEZZ2_TX4_P),.OB(MEZZ2_TX4_N));

OBUFDS OBUFDS_MEZZ3_TX1(.I(CLK_QUAD)        ,.O(MEZZ3_TX1_P),.OB(MEZZ3_TX1_N));
OBUFDS OBUFDS_MEZZ3_TX2(.I(MEZZ4_RX2)       ,.O(MEZZ3_TX2_P),.OB(MEZZ3_TX2_N));
OBUFDS OBUFDS_MEZZ3_TX3(.I(Q1)              ,.O(MEZZ3_TX3_P),.OB(MEZZ3_TX3_N));
OBUFDS OBUFDS_MEZZ3_TX4(.I(Q2)              ,.O(MEZZ3_TX4_P),.OB(MEZZ3_TX4_N));

OBUFDS OBUFDS_MEZZ4_TX1(.I(CLK_QUAD),.O(MEZZ4_TX1_P),.OB(MEZZ4_TX1_N));
OBUFDS OBUFDS_MEZZ4_TX2(.I(CLK_QUAD),.O(MEZZ4_TX2_P),.OB(MEZZ4_TX2_N));
OBUFDS OBUFDS_MEZZ4_TX3(.I(CLK_QUAD),.O(MEZZ4_TX3_P),.OB(MEZZ4_TX3_N));
OBUFDS OBUFDS_MEZZ4_TX4(.I(CLK_QUAD),.O(MEZZ4_TX4_P),.OB(MEZZ4_TX4_N));

// CLK is running at 160 -> D inputs IF IT WORKED -> Use CLK_QUAD instead. It'll either work at 256MHZ or 160 if the board plays nice
// clk_ref is running at 159.9984 -> reference clock / offset clock
    
endmodule
