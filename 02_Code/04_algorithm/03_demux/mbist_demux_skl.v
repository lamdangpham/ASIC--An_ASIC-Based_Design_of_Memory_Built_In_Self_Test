module mbist_mux_demux (clk
                       ,rst_n
                       ,memory_sel
                       ,write_read_mbist
                       ,rdata_mbist
                       ,wdata_mbist
                       ,address_mbist
//DECLEARE WRITE_READ
//DECLEARE RDATA
//DECLEARE WDATA
//DECLEARE ADDRESS
                        );

parameter DATA_WIDTH = 64;
parameter ADDR_WIDTH = 16;

input clk;
input rst_n;
input [2:0]memory_sel;
input write_read_mbist;
input [DATA_WIDTH-1:0] wdata_mbist;
//DECLEARE INPUT RDATA
input [ADDR_WIDTH-1:0] address_mbist;
//DECLEARE OUTPUT WDATA
output [DATA_WIDTH-1:0] rdata_mbist;
//DECLEARE OUTPUT ADDRESS
//DECLEARE OUTPUT WRITE_READ


//REG WDATA
reg [DATA_WIDTH-1:0] rdata_mbist;
//REG ADDRESS
//REG WRITE_READ

always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rdata_mbist <= 0;
//RESET WDATA
//RESET ADDRESS
//RESET WRITE_READ
    end
    else begin
//ASSIGN RDATA_MBIST
//ASSIGN ADDRESS 
//ASSIGN WDATA       
//ASSIGN WRITE_READ       
    end
end
endmodule
