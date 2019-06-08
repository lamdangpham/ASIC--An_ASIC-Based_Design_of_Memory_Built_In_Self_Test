module marcha_decoder (clk,
                       rst_n,
                       marcha_en,
                       error_exceed_ignore,
                       allowable_faulty,
                       address,
                       write_read,
                       wdata,
                       rdata,
                       memtype,
                       error,
                       force_terminate,
                       marcha_complete
                       );
//DEFINE PARAMETER
parameter ADDR_WIDTH =  16;
parameter DATA_WIDTH =  64;

input clk;
input rst_n;
input marcha_en;
input error_exceed_ignore;
input [ADDR_WIDTH-1:0] allowable_faulty;
input [DATA_WIDTH-1:0] rdata;
input [4:0] memtype;

output write_read;
output error;		  
output force_terminate;
output marcha_complete;
output [ADDR_WIDTH-1:0] address;
output [DATA_WIDTH-1:0] wdata;
        
wire clk;
wire rst_n;
wire marcha_en;
wire error_exceed_ignore;
wire write_read;
wire error;
wire force_terminate;
wire marcha_complete;
wire start;
wire en1;
wire en2;
wire en3;
wire en4;
wire finish;

wire [ADDR_WIDTH-1:0] allowable_faulty;
wire [ADDR_WIDTH-1:0] address;
wire [DATA_WIDTH-1:0] rdata;
wire [DATA_WIDTH-1:0] wdata;
wire [4:0] counter;
wire [4:0] memtype;

assign marcha_complete = finish;					   
					   
marcha_controller marcha_controller_1(.clk(clk),
                .rst_n(rst_n),
                .marcha_en(marcha_en),
                .address(address),
                .counter(counter),
                .start(start),
                .en1(en1),
                .en2(en2),
                .en3(en3),
                .en4(en4),
                .finish(finish)
                );
                
marcha_datapath marcha_datapath_1(.clk(clk),
                          .rst_n(rst_n),
                          .start(start),
                          .en1(en1),
                          .en2(en2),
                          .en3(en3),
                          .en4(en4),
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
