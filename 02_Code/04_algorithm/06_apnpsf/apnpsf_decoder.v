//`timescale 1ns/1ps
module apnpsf_decoder (clk,
                       rst_n,
                       apnpsf_en,
                       error_exceed_ignore,
                       allowable_faulty,
                       address,
                       write_read,
                       memtype,
                       wdata,
                       rdata,
                       error,
                       force_terminate,
                       apnpsf_complete);
// DEFINE PARAMETER
parameter DATA_WIDTH = 64;
parameter ADDR_WIDTH = 16;

input clk,
      rst_n,
      apnpsf_en,
      error_exceed_ignore;
input [ADDR_WIDTH-1:0] allowable_faulty;
input [DATA_WIDTH-1:0] rdata;
input [4:0]memtype;


output write_read,
       error,		  
       force_terminate,
       apnpsf_complete;
output [ADDR_WIDTH-1:0] address;
output [DATA_WIDTH-1:0] wdata; 
 
wire clk,
     rst_n,
     apnpsf_en,
     error_exceed_ignore,
     write_read,
     error,
     force_terminate,
     apnpsf_complete;
wire start, en1, en2, en3, en4, en5, en6, en7, en8, en9, en10, en11, en12, en13, en14, en15, en16, finish;
wire [ADDR_WIDTH-1:0] allowable_faulty;
wire [ADDR_WIDTH-1:0] address;
wire [DATA_WIDTH-1:0] rdata;
wire [DATA_WIDTH-1:0] wdata;
wire [8:0] counter;
wire [4:0] memtype;
assign apnpsf_complete = finish;					   
					   
apnpsf_controller apnpsf_controller_1(.clk(clk),
                                      .rst_n(rst_n),
                                      .apnpsf_en(apnpsf_en),
                                      .address(address),
                                      .memtype(memtype),
                                      .counter(counter),
                                      .start(start),
                                      .en1(en1),
                                      .en2(en2),
                                      .en3(en3),
                                      .en4(en4),
                                      .en5(en5),
                                      .en6(en6),
                                      .en7(en7),
                                      .en8(en8),
                                      .en9(en9),
                                      .en10(en10),
                                      .en11(en11),
                                      .en12(en12),
                                      .en13(en13),
                                      .en14(en14),
                                      .en15(en15),
                                      .en16(en16),
                                      .finish(finish));
                
apnpsf_datapath apnpsf_datapath_1(.clk(clk),
                                  .rst_n(rst_n),
                                  .start(start),
                                  .en1(en1),
                                  .en2(en2),
                                  .en3(en3),
                                  .en4(en4),
                                  .en5(en5),
                                  .en6(en6),
                                  .en7(en7),
                                  .en8(en8),
                                  .en9(en9),
                                  .en10(en10),
                                  .en11(en11),
                                  .en12(en12),
                                  .en13(en13),
                                  .en14(en14),
                                  .en15(en15),
                                  .en16(en16),
                                  .memtype(memtype),                  
                                  .error_exceed_ignore(error_exceed_ignore),
                                  .allowable_faulty(allowable_faulty),
                                  .address(address),
                                  .write_read(write_read),
                                  .wdata(wdata),
                                  .rdata(rdata),
                                  .counter(counter),
                                  .error(error),
                                  .force_terminate(force_terminate));
				  
endmodule
