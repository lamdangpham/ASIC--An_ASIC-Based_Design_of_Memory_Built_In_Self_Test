//`timescale 1ns/1ps
module mbist_decoder (clk,
                      rst_n,
                       marchc_en, 
                       marcha_en, 
                      apnpsf_en, 
                      error_exceed_ignore,
                      allowable_faulty,
                      memtype,
                      address,
                      write_read,
                      wdata,
                      rdata,
                      error,
                      force_terminate,
                      marchc_complete,
                      marcha_complete, 
                     apnpsf_complete 
                      );

parameter DATA_WIDTH = 64;
parameter ADDR_WIDTH = 16;
//----------------------------------------
input clk;
input rst_n;
input error_exceed_ignore;
input [ADDR_WIDTH-1:0] allowable_faulty;
input [DATA_WIDTH-1:0] rdata;
input [4:0] memtype;
input marchc_en; 
input marcha_en; 
input apnpsf_en; 

//----------------------------------------
output write_read;
output error;
output force_terminate;
output [ADDR_WIDTH-1:0] address;
output [DATA_WIDTH-1:0] wdata; 
output marchc_complete; 
output marcha_complete; 
output apnpsf_complete; 

//----------------------------------------
        
wire clk;
wire rst_n;
wire error_exceed_ignore;
wire write_read;
wire error;
wire force_terminate;
wire [ADDR_WIDTH-1:0] allowable_faulty;
wire [ADDR_WIDTH-1:0] address;
wire [DATA_WIDTH-1:0] rdata;
reg  [DATA_WIDTH-1:0] wdata;
wire [4:0] memtype;

wire marchc_en;
wire marchc_complete;
wire marchc_write_read;
wire marchc_error;
wire marchc_force_terminate;
wire [ADDR_WIDTH-1:0] marchc_address;
wire [DATA_WIDTH-1:0] marchc_wdata;

wire marcha_en;
wire marcha_complete;
wire marcha_write_read;
wire marcha_error;
wire marcha_force_terminate;
wire [ADDR_WIDTH-1:0] marcha_address;
wire [DATA_WIDTH-1:0] marcha_wdata;

wire apnpsf_en;
wire apnpsf_complete;
wire apnpsf_write_read;
wire apnpsf_error;
wire apnpsf_force_terminate;
wire [ADDR_WIDTH-1:0] apnpsf_address;
wire [DATA_WIDTH-1:0] apnpsf_wdata;

assign address = (marcha_en) ? marcha_address : (marchc_en) ? marchc_address : (apnpsf_en) ?  apnpsf_address : 16'h00;
assign write_read = (marcha_en) ? marcha_write_read : (marchc_en) ? marchc_write_read : (apnpsf_en) ?  apnpsf_write_read: 1'b0;
assign error = (marcha_en) ? marcha_error : (marchc_en) ? marchc_error : (apnpsf_en) ? apnpsf_error: 1'b0;
assign force_terminate = (marcha_en) ? marcha_force_terminate : (marchc_en) ? marchc_force_terminate : (apnpsf_en) ? apnpsf_force_terminate : 1'b0;
always@(posedge clk or negedge rst_n) begin 
    if(!rst_n) begin 
        wdata <= 0;
    end 
    else begin 
        if (marcha_en ==1) begin 
            wdata <= marcha_wdata;
        end 
        else if (marchc_en ==1) begin 
            wdata <= marchc_wdata;
        end 
        else if (apnpsf_en ==1) begin 
            wdata <= apnpsf_wdata;
        end 
        else begin
            wdata <= 0;
        end 
    end 
end 

marchc_decoder marchc_decoder_1(.clk(clk),.rst_n(rst_n),.marchc_en(marchc_en),.error_exceed_ignore(error_exceed_ignore),.allowable_faulty(allowable_faulty),.address(marchc_address),.write_read(marchc_write_read),.memtype(memtype),.wdata(marchc_wdata),.rdata(rdata),.error(marchc_error),.force_terminate(marchc_force_terminate),.marchc_complete(marchc_complete));

marcha_decoder marcha_decoder_1(.clk(clk),.rst_n(rst_n),.marcha_en(marcha_en),.error_exceed_ignore(error_exceed_ignore),.allowable_faulty(allowable_faulty),.address(marcha_address),.write_read(marcha_write_read),.memtype(memtype),.wdata(marcha_wdata),.rdata(rdata),.error(marcha_error),.force_terminate(marcha_force_terminate),.marcha_complete(marcha_complete));

apnpsf_decoder apnpsf_decoder_1(.clk(clk),.rst_n(rst_n),.apnpsf_en(apnpsf_en),.error_exceed_ignore(error_exceed_ignore),.allowable_faulty(allowable_faulty),.address(apnpsf_address),.write_read(apnpsf_write_read),.memtype(memtype),.wdata(apnpsf_wdata),.rdata(rdata),.error(apnpsf_error),.force_terminate(apnpsf_force_terminate),.apnpsf_complete(apnpsf_complete));

endmodule
