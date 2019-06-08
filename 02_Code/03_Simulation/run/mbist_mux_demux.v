module mbist_mux_demux (clk
                       ,rst_n
                       ,memory_sel
                       ,write_read_mbist
                       ,rdata_mbist
                       ,wdata_mbist
                       ,address_mbist
 ,write_read_3
 ,write_read_2
 ,write_read_1
 ,write_read_0
 ,rdata_3 
 ,rdata_2 
 ,rdata_1 
 ,rdata_0 
 ,wdata_3 
 ,wdata_2 
 ,wdata_1 
 ,wdata_0 
 ,address_3 
 ,address_2 
 ,address_1 
 ,address_0 
                        );

parameter DATA_WIDTH = 64;
parameter ADDR_WIDTH = 16;

input clk;
input rst_n;
input [2:0]memory_sel;
input write_read_mbist;
input [DATA_WIDTH-1:0] wdata_mbist;
input [DATA_WIDTH-1:0] rdata_3; 
input [DATA_WIDTH-1:0] rdata_2; 
input [DATA_WIDTH-1:0] rdata_1; 
input [DATA_WIDTH-1:0] rdata_0; 
input [ADDR_WIDTH-1:0] address_mbist;
output [DATA_WIDTH-1:0] wdata_3; 
output [DATA_WIDTH-1:0] wdata_2; 
output [DATA_WIDTH-1:0] wdata_1; 
output [DATA_WIDTH-1:0] wdata_0; 
output [DATA_WIDTH-1:0] rdata_mbist;
output [ADDR_WIDTH-1:0] address_3 ; 
output [ADDR_WIDTH-1:0] address_2 ; 
output [ADDR_WIDTH-1:0] address_1 ; 
output [ADDR_WIDTH-1:0] address_0 ; 
output write_read_3 ; 
output write_read_2 ; 
output write_read_1 ; 
output write_read_0 ; 


reg [DATA_WIDTH-1:0] wdata_3 ; 
reg [DATA_WIDTH-1:0] wdata_2 ; 
reg [DATA_WIDTH-1:0] wdata_1 ; 
reg [DATA_WIDTH-1:0] wdata_0 ; 
reg [DATA_WIDTH-1:0] rdata_mbist;
reg [ADDR_WIDTH-1:0] address_3 ; 
reg [ADDR_WIDTH-1:0] address_2 ; 
reg [ADDR_WIDTH-1:0] address_1 ; 
reg [ADDR_WIDTH-1:0] address_0 ; 
reg write_read_3 ; 
reg write_read_2 ; 
reg write_read_1 ; 
reg write_read_0 ; 

always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rdata_mbist <= 0;
wdata_3      <= 0 ; 
wdata_2      <= 0 ; 
wdata_1      <= 0 ; 
wdata_0      <= 0 ; 
address_3    <= 0 ; 
address_2    <= 0 ; 
address_1    <= 0 ; 
address_0    <= 0 ; 
write_read_3 <= 0 ; 
write_read_2 <= 0 ; 
write_read_1 <= 0 ; 
write_read_0 <= 0 ; 
    end
    else begin
rdata_mbist <= (memory_sel == 3) ? rdata_3 :(memory_sel == 2) ? rdata_2 :(memory_sel == 1) ? rdata_1 :(memory_sel == 0) ? rdata_0 :0 ;
address_3 <= (memory_sel == 3) ? address_mbist:0;
address_2 <= (memory_sel == 2) ? address_mbist:0;
address_1 <= (memory_sel == 1) ? address_mbist:0;
address_0 <= (memory_sel == 0) ? address_mbist:0;
wdata_3 <= (memory_sel == 3) ? wdata_mbist:0;
wdata_2 <= (memory_sel == 2) ? wdata_mbist:0;
wdata_1 <= (memory_sel == 1) ? wdata_mbist:0;
wdata_0 <= (memory_sel == 0) ? wdata_mbist:0;
write_read_3 <= (memory_sel == 3) ? write_read_mbist:0;
write_read_2 <= (memory_sel == 2) ? write_read_mbist:0;
write_read_1 <= (memory_sel == 1) ? write_read_mbist:0;
write_read_0 <= (memory_sel == 0) ? write_read_mbist:0;
    end
end
endmodule
