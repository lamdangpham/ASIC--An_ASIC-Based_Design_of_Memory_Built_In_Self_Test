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

//reg [DATA_WIDTH-1:0] pre_rdata;
reg [DATA_WIDTH-1:0] int_mem [CAPACITY:0];
wire [DATA_WIDTH-1:0] tmp_mem;

reg [DATA_WIDTH-1:0] rdata1;
reg [DATA_WIDTH-1:0] wdata1;

always@(posedge clk) begin
    wdata1 <= wdata;
end
always @ (posedge clk) begin
    rdata <= rdata1;
end

assign tmp_mem = int_mem[@WRONG_ADDR]; 

always@(posedge clk) begin
    if (write_read) begin
       if( address != @WRONG_ADDR ) begin
            int_mem [address] <=  wdata1;
       end
       else if ((wdata1[4] == 0) && (tmp_mem[4] == 1))begin
            int_mem[address + 1] <= {wdata1[DATA_WIDTH-1:6], !wdata1[5], wdata1[4:0]};
       end
    end
    else begin
        rdata1 <=  int_mem[address];
    end
end
endmodule
