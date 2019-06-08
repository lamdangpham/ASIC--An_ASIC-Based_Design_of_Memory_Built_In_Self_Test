//`timescale 1ns/1ps
module marchc_decoder (clk,
                       rst_n,
                       marchc_en,
                       error_exceed_ignore,
                       allowable_faulty,
                       address,
                       write_read,
                       wdata,
                       rdata,
                       memtype,
                       error,
                       force_terminate,
                       marchc_complete
                       );
//DEFINE PARAMETER
parameter ADDR_WIDTH =  16;
parameter DATA_WIDTH =  64;

input clk,
      rst_n,
      marchc_en,
      error_exceed_ignore;
input [ADDR_WIDTH-1:0] allowable_faulty;
input [DATA_WIDTH-1:0] rdata;
input [4:0] memtype;

output write_read,
       error,		  
       force_terminate,
       marchc_complete;
output [ADDR_WIDTH-1:0] address;
output [DATA_WIDTH-1:0] wdata;
        
wire clk,
     rst_n,
     marchc_en,
     error_exceed_ignore,
     write_read,
     error,
     force_terminate,
     marchc_complete,
     start,
     en1,
     en2,
     en3,
     en4,
     en5,
     finish;
wire [ADDR_WIDTH-1:0] allowable_faulty;
wire [ADDR_WIDTH-1:0] address;
wire [DATA_WIDTH-1:0] rdata;
wire [DATA_WIDTH-1:0] wdata;
wire [3:0] counter;
wire [4:0] memtype;

assign marchc_complete = finish;					   
					   
marchc_controller marchc_controller_1(.clk(clk),
                .rst_n(rst_n),
                .marchc_en(marchc_en),
                .address(address),
                .counter(counter),
                .start(start),
                .en1(en1),
                .en2(en2),
                .en3(en3),
                .en4(en4),
                .en5(en5),
                .finish(finish)
                );
                
marchc_datapath marchc_datapath_1(.clk(clk),
                          .rst_n(rst_n),
                          .start(start),
                          .en1(en1),
                          .en2(en2),
                          .en3(en3),
                          .en4(en4),
                          .en5(en5),
                          .error_exceed_ignore(error_exceed_ignore),
                          .allowable_faulty(allowable_faulty),
                          .memtype(memtype),
                          .address(address),
                          .write_read(write_read),
                          .wdata(wdata),
                          .rdata(rdata),
                          .counter(counter),
                          .error(error),
                          .force_terminate(force_terminate));
				  
endmodule
