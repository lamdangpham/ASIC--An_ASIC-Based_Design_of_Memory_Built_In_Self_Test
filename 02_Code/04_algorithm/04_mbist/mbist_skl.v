//`timescale 1ns/1ps
module mbist (clk,
              rst_n,
              test_mode,
              operation,
              error_exceed_ignore,
              allowable_faulty,
              memory_sel,  
//DECLEARE ADDRESS
//DECLEARE WRITE_READ              
              memtype,
//DECLEARE WDATA
//DECLEARE RDATA
              error,
              force_terminate,
              complete);

parameter DATA_WIDTH = 64;
parameter ADDR_WIDTH = 16;

input clk,
      rst_n,
      test_mode;
input [2:0]operation;
input error_exceed_ignore;
input [ADDR_WIDTH-1:0] allowable_faulty;
//DECLEARE INPUT RDATA
input [4:0]memtype;
input [2:0]memory_sel;
//DECLEARE OUTPUT WRITE_READ
output error,		  
       force_terminate,
       complete;
//DECLEARE OUTPUT ADDRESS
//DECLEARE OUTPUT WDATA
        
wire clk,
     rst_n,
     test_mode;
wire [2:0]operation;
wire error_exceed_ignore;
//WIRE WRITE_READ
wire error,
     force_terminate,
     complete;
//DECLEARE_MARCHC
//DECLEARE_MARCHA
//DECLEARE_APNPSF
wire [ADDR_WIDTH-1:0] allowable_faulty;
wire [ADDR_WIDTH-1:0] address;
//WIRE ADDRESS
wire [DATA_WIDTH-1:0] rdata;
//WIRE RDATA
wire [DATA_WIDTH-1:0] wdata;				   					   
//WIRE WDATA

			   					   
controller controller_1 (.clk(clk),
                         .rst_n(rst_n),
                         .test_mode(test_mode),
                         .operation(operation),
//ASSIGN_MARCHC 
//ASSIGN_MARCHA
//ASSIGN_APNPSF
                         .complete(complete));
                
mbist_decoder mbist_decoder_1 (.clk(clk),
                               .rst_n(rst_n),
                               .error_exceed_ignore(error_exceed_ignore),
                               .allowable_faulty(allowable_faulty),
                               .address(address),
                               .write_read(write_read),
                               .memtype(memtype),
                               .wdata(wdata),
                               .rdata(rdata),
                               .error(error),
//ASSIGN_MARCHC 
//ASSIGN_MARCHA 
//ASSIGN_APNPSF
                               .force_terminate(force_terminate)
                              );
				  

mbist_mux_demux mbist_mux_demux_1 (.clk(clk)
                                  ,.rst_n(rst_n)
                                  ,.memory_sel(memory_sel)
                                  ,.wdata_mbist(wdata)
                                  ,.address_mbist(address)
                                  ,.rdata_mbist(rdata)
//ASSIGN WRITE_READ
                                  ,.write_read_mbist(write_read)
//ASSIGN ADDRESS
//ASSIGN RDATA
//ASSIGN WDATA
                                   );
endmodule
