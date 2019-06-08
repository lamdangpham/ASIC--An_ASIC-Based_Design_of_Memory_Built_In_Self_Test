module fault_mem (clk, write_read, address, wdata, rdata);

parameter DATA_WIDTH = @DATA_WIDTH;
parameter ADDR_WIDTH = @ADDR_WIDTH;
parameter CAPACITY    = @CAPACITY; // 511 255

input clk;
input write_read;
input [ADDR_WIDTH-1:0] address;
input [DATA_WIDTH-1:0] wdata;

output [DATA_WIDTH-1:0] rdata;
reg    [DATA_WIDTH-1:0] rdata;

reg [DATA_WIDTH-1:0] int_mem [CAPACITY:0];

reg [DATA_WIDTH-1:0] rdata1;
reg [DATA_WIDTH-1:0] wdata1;

always@(posedge clk) begin
    wdata1 <= wdata;
end
always @ (posedge clk) begin
    rdata <= rdata1;
end


always@(posedge clk) begin
    if (write_read) begin
        if(address != @WRONG_ADDR) begin
            int_mem [address] <= wdata1;
        end
    end
    else begin
        if(address == @WRONG_ADDR) begin
            rdata1 <= @DATA_WIDTH'h@FIX_DATA;      
        end
        else begin
            rdata1 <= int_mem [address] ;
        end
    end
end

endmodule
