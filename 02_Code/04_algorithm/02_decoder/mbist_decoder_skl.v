//`timescale 1ns/1ps
module mbist_decoder (clk,
                      rst_n,
                      //DECLEARE_MARCHC_EN
                      //DECLEARE_MARCHA_EN
                      //DECLEARE_APNPSF_EN
                      error_exceed_ignore,
                      allowable_faulty,
                      memtype,
                      address,
                      write_read,
                      wdata,
                      rdata,
                      error,
                      force_terminate,
                      //DECLEARE_MARCHC_COMPLETE
                      //DECLEARE_MARCHA_COMPLETE
                      //DECLEARE_APNPSF_COMPLETE
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
//ENABLE MARCHC ALGORITHM
//ENABLE MARCHA ALGORITHM
//ENABLE APNPSF ALGORITHM

//----------------------------------------
output write_read;
output error;
output force_terminate;
output [ADDR_WIDTH-1:0] address;
output [DATA_WIDTH-1:0] wdata; 
//COMPLETE MARCHC ALGORITHM
//COMPLETE MARCHA ALGORITHM
//COMPLETE APNPSF ALGORITHM

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

//MARCHC ALGORITHM

//MARCHA ALGORITHM

//APNPSF ALGORITHM

//ASSIGN_APNPSF_MARCHC_MARCHA

//ASSIGN_MARCHC_ALGORITHM

//ASSIGN_MARCHA_ALGORITHM

//ASSIGN_APNPSF_ALGORITHM

endmodule
