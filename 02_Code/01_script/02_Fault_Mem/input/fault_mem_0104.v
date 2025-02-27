module fault_mem (clk, write_read, address, wdata, rdata);

parameter DATA_WIDTH = @DATA_WIDTH;
parameter ADDR_WIDTH = @ADDR_WIDTH;
parameter CAPACITY    = @CAPACITY;

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
    if (write_read) begin //write process
       if(address != @WRONG_ADDR) begin
           int_mem[address] <= wdata1;
       end
       else begin
           int_mem[address] <= (wdata1 | @DATA_WIDTH'h@FIX_DATA);  //ERROR_01_04: The fourth cell is always 1
       end
    end
    else begin //read process
       if(address != @WRONG_ADDR) begin
           rdata1 <= int_mem[address];
       end
       else begin
           rdata1 <= int_mem[address] | @DATA_WIDTH'h@FIX_DATA;  //ERROR_01_04: The fourth bit is always 1
       end
    end
end

endmodule
