//`timescale 1ns/1ps
module mbist (clk,
              rst_n,
              test_mode,
              operation,
              error_exceed_ignore,
              allowable_faulty,
              memory_sel,  
address_3, 
address_2, 
address_1, 
address_0, 
write_read_3, 
write_read_2, 
write_read_1, 
write_read_0, 
              memtype,
wdata_3, 
wdata_2, 
wdata_1, 
wdata_0, 
rdata_3, 
rdata_2, 
rdata_1, 
rdata_0, 
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
input [DATA_WIDTH-1:0] rdata_3; 
input [DATA_WIDTH-1:0] rdata_2; 
input [DATA_WIDTH-1:0] rdata_1; 
input [DATA_WIDTH-1:0] rdata_0; 
input [4:0]memtype;
input [2:0]memory_sel;
output write_read_3; 
output write_read_2; 
output write_read_1; 
output write_read_0; 
output error,		  
       force_terminate,
       complete;
output [ADDR_WIDTH-1:0] address_3; 
output [ADDR_WIDTH-1:0] address_2; 
output [ADDR_WIDTH-1:0] address_1; 
output [ADDR_WIDTH-1:0] address_0; 
output [DATA_WIDTH-1:0] wdata_3; 
output [DATA_WIDTH-1:0] wdata_2; 
output [DATA_WIDTH-1:0] wdata_1; 
output [DATA_WIDTH-1:0] wdata_0; 
        
wire clk,
     rst_n,
     test_mode;
wire [2:0]operation;
wire error_exceed_ignore;
wire write_read_3; 
wire write_read_2; 
wire write_read_1; 
wire write_read_0; 
wire error,
     force_terminate,
     complete;
wire marchc_complete; 
wire marchc_en; 
wire marcha_complete; 
wire marcha_en; 
wire apnpsf_complete; 
wire apnpsf_en; 
wire [ADDR_WIDTH-1:0] allowable_faulty;
wire [ADDR_WIDTH-1:0] address;
wire [ADDR_WIDTH-1:0] address_3; 
wire [ADDR_WIDTH-1:0] address_2; 
wire [ADDR_WIDTH-1:0] address_1; 
wire [ADDR_WIDTH-1:0] address_0; 
wire [DATA_WIDTH-1:0] rdata;
wire [DATA_WIDTH-1:0] rdata_3; 
wire [DATA_WIDTH-1:0] rdata_2; 
wire [DATA_WIDTH-1:0] rdata_1; 
wire [DATA_WIDTH-1:0] rdata_0; 
wire [DATA_WIDTH-1:0] wdata;				   					   
wire [DATA_WIDTH-1:0] wdata_3; 
wire [DATA_WIDTH-1:0] wdata_2; 
wire [DATA_WIDTH-1:0] wdata_1; 
wire [DATA_WIDTH-1:0] wdata_0; 

			   					   
controller controller_1 (.clk(clk),
                         .rst_n(rst_n),
                         .test_mode(test_mode),
                         .operation(operation),
                        .marchc_complete(marchc_complete), 
                        .marchc_en(marchc_en), 
                        .marcha_complete(marcha_complete), 
                        .marcha_en(marcha_en), 
                        .apnpsf_complete(anpsf_complete), 
                        .apnpsf_en(apnpsf_en), 
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
                        .marchc_complete(marchc_complete), 
                        .marchc_en(marchc_en), 
                        .marcha_complete(marcha_complete), 
                        .marcha_en(marcha_en), 
                        .apnpsf_complete(anpsf_complete), 
                        .apnpsf_en(apnpsf_en), 
                               .force_terminate(force_terminate)
                              );
				  

mbist_mux_demux mbist_mux_demux_1 (.clk(clk)
                                  ,.rst_n(rst_n)
                                  ,.memory_sel(memory_sel)
                                  ,.wdata_mbist(wdata)
                                  ,.address_mbist(address)
                                  ,.rdata_mbist(rdata)
,.write_read_3(write_read_3) 
,.write_read_2(write_read_2) 
,.write_read_1(write_read_1) 
,.write_read_0(write_read_0) 
                                  ,.write_read_mbist(write_read)
,.address_3(address_3) 
,.address_2(address_2) 
,.address_1(address_1) 
,.address_0(address_0) 
,.rdata_3(rdata_3) 
,.rdata_2(rdata_2) 
,.rdata_1(rdata_1) 
,.rdata_0(rdata_0) 
,.wdata_3(wdata_3) 
,.wdata_2(wdata_2) 
,.wdata_1(wdata_1) 
,.wdata_0(wdata_0) 
                                   );
endmodule
