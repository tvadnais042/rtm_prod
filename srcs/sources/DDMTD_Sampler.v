`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rohith 
// 
// Create Date: 08/12/2020 08:00:43 AM
// Design Name: 
// Module Name: DDMTD_Sampler
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


module DDMTD_Sampler
#(
    parameter integer DATA_WIDTH = 32,
    parameter integer C_M_START_COUNT	= 32
 )
 (
    // Inputs for the sampling logic
    input clk_ref,
    input clk_beat,
    input [DATA_WIDTH-1:0] external_counter,
    input reset,
    input enable_sampling_logic, // Active high


    // Fifo chain to AXIS
    input wire  M_AXIS_ACLK,
    // 
    input wire  M_AXIS_ARESETN, //RESET when low.
    // Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
    output wire  M_AXIS_TVALID,
    // TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
    output reg [DATA_WIDTH-1 : 0] M_AXIS_TDATA,
    // TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
    output wire [(DATA_WIDTH/8)-1 : 0] M_AXIS_TSTRB,
    // TLAST indicates the boundary of a packet.
    output wire  M_AXIS_TLAST,
    // TREADY indicates that the slave can accept a transfer in the current cycle.
    input wire  M_AXIS_TREADY,
    input wire enable_read_logic,
    input wire [31:0] WORDS_TO_SEND,
    output wire prog_full 

 );

wire full,empty;
wire prog_empty;
//wire prog_full;



assign M_AXIS_TSTRB = {(DATA_WIDTH/8){1'b1}};


wire ARESETN;
assign ARESETN = M_AXIS_ARESETN;

reg temp_mem=0;
reg write_en=0;

always @(negedge clk_ref) begin
    if(temp_mem != clk_beat && enable_sampling_logic) begin
        temp_mem <= clk_beat;
        write_en <= 1;
    end
    else begin
        write_en <=0;
    end

end

// wire write_en;
// //wire beat_edge;
// pedge p1 (
//     .clk(clk_ref),
//     .reset(reset),
//     .clk_obs(clk_beat),
//     .clk_en(enable_sampling_logic),
//     .out(write_en)
//     // ,.beat_edge(beat_edge)
// );



//Saving values of edge
reg  beat_edge = 0;
always @(negedge clk_ref)
begin
    beat_edge<=clk_beat;
end

wire [31:0] DATA_IN;
assign DATA_IN = {beat_edge,external_counter[30:0]};


// MAXIS
//circuit to count number of clock cycles after reset
reg sampleGeneratorEnR=0;
reg [7:0] afterResetCycleCounterR=0;



always @(posedge M_AXIS_ACLK)
    if( ! ARESETN )begin
        sampleGeneratorEnR <=0;
        afterResetCycleCounterR <=0;	
    end
    else if(M_AXIS_TREADY)   begin
        afterResetCycleCounterR <= afterResetCycleCounterR + 1;
        if (afterResetCycleCounterR == C_M_START_COUNT) begin
            sampleGeneratorEnR <=1;
        end
    end
	




//M_AXIS_TVALID circuit
// reg  		tValidR=0;

// always @(negedge M_AXIS_ACLK)
//     if( (! ARESETN) )begin
//         tValidR <=0;
//     end
//     else if (sampleGeneratorEnR && M_AXIS_TREADY) tValidR <= 1;
            

// //Valid only after 500 cycles of clk_ref after empty is deasserted
// reg data_in_fifo = 0;
// parameter DATA_IN_FIFO_THRESHOLD = 200;

// integer data_in_fifo_counter=0;
// always @(posedge clk_ref)
// begin
//     if(reset | empty)
//     begin
//         data_in_fifo <= 0;
//         data_in_fifo_counter <= 0;
//     end
//     else 
//     begin
//         if(write_en) data_in_fifo_counter <= data_in_fifo_counter +1;
//         if(data_in_fifo_counter >= DATA_IN_FIFO_THRESHOLD) data_in_fifo <=1;
//     end
// end

    
// assign M_AXIS_TVALID = tValidR & data_in_fifo ;



assign  M_AXIS_TVALID = 1; //Always valid





//     // First FIFO
// FIFO_DUALCLOCK_MACRO #(
//     .ALMOST_EMPTY_OFFSET(9'h080),//Setsthealmostemptythreshold
//     .ALMOST_FULL_OFFSET(9'h080),//Setsalmostfullthreshold
//     .DATA_WIDTH(DATA_WIDTH),//Validvaluesare1-72(37-72onlyvalidwhenFIFO_SIZE = "36Kb")
//     .DEVICE("7SERIES"),//Targetdevice:"7SERIES".
//     .FIFO_SIZE("36Kb"),//TargetBRAM:"18Kb"or"36Kb"
//     .FIRST_WORD_FALL_THROUGH("TRUE")//SetstheFIforFWFTto"TRUE"or"FALSE"
//     )
// FIFO_FWFT(
//     // .ALMOSTEMPTY(ALMOSTEMPTY),//1-bitoutputalmostempty
//     // .ALMOSTFULL(ALMOSTFULL),//1-bitoutputalmostfull
//     .DO(M_AXIS_TDATA),//Outputdata,widthdefinedbyDATA_WIDTHparameter
//     // .EMPTY(net[0].EMPTY),//1-bitoutputempty
//     // .FULL(net[0].FULL),//1-bitoutputfull
//     // .RDCOUNT(net[0].RC),//Outputreadcount,widthdeterminedbyFIfordepth
//     // .RDERR(RDERR),//1-bitoutputreaderror
//     // .WRCOUNT(net[0].WC),//Outputwritecount,widthdeterminedbyFIfordepth
//     // .WRERR(WRERR),//1-bitoutputwriteerror
//     .DI(external_counter),//Inputdata,widthdefinedbyDATA_WIDTHparameter.

//     .RDCLK(M_AXIS_ACLK),//1-bitinputreadclock
//     .RDEN(M_AXIS_TVALID && M_AXIS_TREADY),//1-bitinputreadenable
//     .RST(reset),//1-bitinputreset
//     .WRCLK(clk_ref),//1-bit input write clock
//     .WREN(write_en)//1-bitinputwriteenable
//     );







 
    // FIFOs_Ultrascale  
    // #(
    //  .data_width(36),
    //  .num_fifo(10)
    // )
    // FIFOs_Ultrascale_1(
    
    
    // .read_en(M_AXIS_TVALID && M_AXIS_TREADY && enable_sampling_logic && enable_read_logic | reset),
    // .write_en(write_en),
    // .data_in(external_counter),
    // .data_out(M_AXIS_TDATA),
    // .full(full),
    // .empty(empty),
    // .rst(reset),
    // .read_clk(M_AXIS_ACLK),
    // .write_clk(clk_ref)
    // );



    //Sync Circuit from Erich
    reg write_en_sync=0;
    reg [DATA_WIDTH-1 : 0] DATA_IN_SYNC = 0;
    always @(negedge clk_ref)
    begin
        write_en_sync <=write_en;
        DATA_IN_SYNC <= DATA_IN;
        
    end


    reg read_en_sync=0;
    wire [DATA_WIDTH-1 : 0] DATA_OUT;
    always @(negedge M_AXIS_ACLK)
    begin
        read_en_sync <=(M_AXIS_TVALID && M_AXIS_TREADY && enable_sampling_logic && enable_read_logic | reset);
        M_AXIS_TDATA <= DATA_OUT;
    end



    fifo_generator_0  FIFO_10_inst (
    .srst(reset),

    // .clk(clk_ref),
    .wr_clk(clk_ref),
    .rd_clk(M_AXIS_ACLK),
    .din(DATA_IN_SYNC),
    .wr_en(write_en_sync),
    .rd_en(read_en_sync),
    .dout(DATA_OUT),
    .full(full),
    .empty(empty),
    .prog_empty(prog_empty),
    .prog_full(prog_full)
    // wr_rst_busy,
    // rd_rst_busy
    );


    // //M_AXIS_TLAST LOGIC
    // // The Current page size is 4096 bytes which 1024 32bit words // modified
    // // So we trigger TLAST on 1024th word
    // // parameter integer WORDS_TO_SEND = 8000; 
    // integer counter_TLAST =0;
    // reg tlast=0;
    // always @(negedge M_AXIS_ACLK)begin
    //     if( ! ARESETN )begin
    //     counter_TLAST<=0;	
    //     end
    //     else if (M_AXIS_TVALID && M_AXIS_TREADY && enable_sampling_logic && enable_read_logic) begin
    //         if (counter_TLAST == WORDS_TO_SEND-1) counter_TLAST<=0;
    //         else begin
    //             counter_TLAST = counter_TLAST+1;      
    //         end
    //     end 
    // end

    // assign M_AXIS_TLAST = (counter_TLAST == WORDS_TO_SEND-2)?1:empty;
    
    assign M_AXIS_TLAST = 0;
    
    
    






    // // FIFO36E2: 36Kb FIFO (First-In-First-Out) Block RAM Memory
    // //           UltraScale// Xilinx HDL Language Template, version 2018.3
    // FIFO36E2 #(   
    // .CASCADE_ORDER("NONE"),            // FIRST, LAST, MIDDLE, NONE, PARALLEL   
    // .CLOCK_DOMAINS("INDEPENDENT"),     // COMMON, INDEPENDENT   
    // .EN_ECC_PIPE("FALSE"),             // ECC pipeline register, (FALSE, TRUE)   
    // .EN_ECC_READ("FALSE"),             // Enable ECC decoder, (FALSE, TRUE)   
    // .EN_ECC_WRITE("FALSE"),            // Enable ECC encoder, (FALSE, TRUE)   
    // .FIRST_WORD_FALL_THROUGH("TRUE"), // FALSE, TRUE   
    // .INIT(36'h0000000000),     // Initial values on output port   
    // .PROG_EMPTY_THRESH(256),           // Programmable Empty Threshold   
    // .PROG_FULL_THRESH(256),            // Programmable Full Threshold   // Programmable Inversion Attributes: Specifies the use of the built-in programmable inversion   
    // .IS_RDCLK_INVERTED(1'b0),          // Optional inversion for RDCLK   
    // .IS_RDEN_INVERTED(1'b0),           // Optional inversion for RDEN   
    // .IS_RSTREG_INVERTED(1'b0),         // Optional inversion for RSTREG   
    // .IS_RST_INVERTED(1'b0),            // Optional inversion for RST   
    // .IS_WRCLK_INVERTED(1'b0),          // Optional inversion for WRCLK   
    // .IS_WREN_INVERTED(1'b0),           // Optional inversion for WREN   
    // .RDCOUNT_TYPE("RAW_PNTR"),         // EXTENDED_DATACOUNT, RAW_PNTR, SIMPLE_DATACOUNT, SYNC_PNTR   
    // .READ_WIDTH(36),                    // 18-9   
    // .REGISTER_MODE("UNREGISTERED"),    // DO_PIPELINED, REGISTERED, UNREGISTERED   
    // .RSTREG_PRIORITY("RSTREG"),        // REGCE, RSTREG   
    // .SLEEP_ASYNC("TRUE"),             // FALSE, TRUE   
    // .SRVAL(72'h000000000000000000),    // SET/reset value of the FIFO outputs   
    // .WRCOUNT_TYPE("RAW_PNTR"),         // EXTENDED_DATACOUNT, RAW_PNTR, SIMPLE_DATACOUNT, SYNC_PNTR   
    // .WRITE_WIDTH(36)                    // 18-9
    // )

    // FIFO36E2_inst (   
    // // // Cascade Signals outputs: Multi-FIFO cascade signals   
    // // .CASDOUT(CASDOUT),             // 64-bit output: Data cascade output bus   
    // // .CASDOUTP(CASDOUTP),           // 8-bit output: Parity data cascade output bus   
    // // .CASNXTEMPTY(CASNXTEMPTY),     // 1-bit output: Cascade next empty   
    // // .CASPRVRDEN(CASPRVRDEN),       // 1-bit output: Cascade previous read enable   
    // // // ECC Signals outputs: Error Correction Circuitry ports   
    // // .DBITERR(DBITERR),             // 1-bit output: Double bit error status   
    // // .ECCPARITY(ECCPARITY),         // 8-bit output: Generated error correction parity 
    // // .SBITERR(SBITERR),             // 1-bit output: Single bit error status   
    // // // Read Data outputs: Read output data   
    // .DOUT(M_AXIS_TDATA),
    // // .DOUTP(DOUTP),                 // 8-bit output: FIFO parity output bus.   
    // // Status outputs: Flags and other FIFO status outputs   
    // // .EMPTY(EMPTY),                 // 1-bit output: Empty   
    // // .FULL(FULL),                   // 1-bit output: Full   
    // // .PROGEMPTY(PROGEMPTY),         // 1-bit output: Programmable empty   
    // // .PROGFULL(PROGFULL),           // 1-bit output: Programmable full   
    // // .RDCOUNT(RDCOUNT),             // 14-bit output: Read count   
    // // .RDERR(RDERR),                 // 1-bit output: Read error   
    // // .RDRSTBUSY(RDRSTBUSY),         // 1-bit output: Reset busy (sync to RDCLK)   
    // // .WRCOUNT(WRCOUNT),             // 14-bit output: Write count   
    // // .WRERR(WRERR),                 // 1-bit output: Write Error   
    // // .WRRSTBUSY(WRRSTBUSY),         // 1-bit output: Reset busy (sync to WRCLK)   
    // // // Cascade Signals inputs: Multi-FIFO cascade signals   
    // // .CASDIN(CASDIN),               // 64-bit input: Data cascade input bus
    // // .CASDINP(CASDINP),             // 8-bit input: Parity data cascade input bus   
    // // .CASDOMUX(CASDOMUX),           // 1-bit input: Cascade MUX select input   
    // // .CASDOMUXEN(CASDOMUXEN),       // 1-bit input: Enable for cascade MUX select   
    // // .CASNXTRDEN(CASNXTRDEN),       // 1-bit input: Cascade next read enable   
    // // .CASOREGIMUX(CASOREGIMUX),     // 1-bit input: Cascade output MUX select   
    // // .CASOREGIMUXEN(CASOREGIMUXEN), // 1-bit input: Cascade output MUX select enable   
    // // .CASPRVEMPTY(CASPRVEMPTY),     // 1-bit input: Cascade previous empty   
    // // // ECC Signals inputs: Error Correction Circuitry ports   
    // // .INJECTDBITERR(INJECTDBITERR), // 1-bit input: Inject a double bit error   
    // // .INJECTSBITERR(INJECTSBITERR), // 1-bit input: Inject a single bit error  
    // //  // Read Control Signals inputs: Read clock, enable and reset input signals   
    // .RDCLK(M_AXIS_ACLK),                 // 1-bit input: Read clock   
    // .RDEN(M_AXIS_TVALID && M_AXIS_TREADY && enable_sampling_logic),                   // 1-bit input: Read enable   
    // // .REGCE(0),                 // 1-bit input: Output register clock enable   
    // // .RSTREG(0),               // 1-bit input: Output register reset   
    // // .SLEEP(0),                     // 1-bit input: Sleep Mode   
    // // Write Control Signals inputs: Write clock and enable input signals   
    // .RST(reset),                     // 1-bit input: Reset   
    // .WRCLK(clk_ref),                 // 1-bit input: Write clock   
    // .WREN(write_en),                   // 1-bit input: Write enable   
    // // Write Data inputs: Write input data   
    // .DIN(external_counter)                     // 64-bit input: FIFO data input bus   
    // // .DINP(DINP)                    // 8-bit input: FIFO parity input bus
    // );
    // // End of FIFO36E2_inst instantiation










    
endmodule




//module pedge(
//input clk,
//input reset,
//input clk_obs,
//input clk_en,
//output out,
//output beat_edge
//    );


// //OLD Stuff   
//        // wire clk_obs_sync;
//        // SYNC sync1(.O(clk_obs_sync),.I(clk_obs),.clk(clk),.reset(reset));            
//        wire D0,D1,D2;
//        wire Q0,Q1,Q2;


//        assign D0  = clk_obs;
//        assign D1  = Q0;
//        assign D2  = Q1;
//        assign beat_edge = Q1;




//        FDRE
//        #(
//            .INIT(1'b0)//Initialvalueofregister(1'b0or1'b1)
//         )
//        FDRE_inst1(
//        .Q(Q0),//1-bit Data output
//        .C(clk),//1-bit Clock input
//        .CE(clk_en), //1-bit Clock enable input
//        .R(reset),//1- bit Synchronous reset input
//        .D(D0)//1 -bit Data input
//        );



//        FDRE
//        #(
//            .INIT(1'b0)//Initialvalueofregister(1'b0or1'b1)
//         )
//        FDRE_inst2(
//        .Q(Q1),//1-bit Data output
//        .C(clk),//1-bit Clock input
//        .CE(clk_en), //1-bit Clock enable input
//        .R(reset),//1- bit Synchronous reset input
//        .D(D1)//1 -bit Data input
//        );


//                FDRE
//        #(
//            .INIT(1'b0)//Initialvalueofregister(1'b0or1'b1)
//         )
//        FDRE_inst3(
//        .Q(Q2),//1-bit Data output
//        .C(clk),//1-bit Clock input
//        .CE(clk_en), //1-bit Clock enable input
//        .R(reset),//1- bit Synchronous reset input
//        .D(D2)//1 -bit Data input
//        );


        

//    //    wire temp_out;
////       XORCY X1(.O(temp_out) ,.LI(clk_obs_sync),.CI(out_FF));
//    //    assign out = Q1^Q2; //Save all edges
//    //    assign out = Q2&(~Q1); //Save negedge
//       assign out = Q1&(~Q2); //Save posedge

//    //    assign temp_out = clk_obs_sync&(~out_FF);
//    //    SYNC sync2(.O(out),.I(temp_out),.clk(~clk),.reset(reset));
    
//endmodule
