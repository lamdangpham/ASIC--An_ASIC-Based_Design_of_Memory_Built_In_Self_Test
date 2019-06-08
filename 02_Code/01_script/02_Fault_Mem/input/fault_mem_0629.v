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
wire [DATA_WIDTH-1:0] tmp_neighborA;
wire [DATA_WIDTH-1:0] tmp_neighborB;
wire [DATA_WIDTH-1:0] tmp_neighborC;
wire [DATA_WIDTH-1:0] tmp_neighborD;
wire [3:0]            tmp_neighbor;
wire [DATA_WIDTH-1:0] tmp_mem;

reg [DATA_WIDTH-1:0] rdata1;
reg [DATA_WIDTH-1:0] wdata1;

always@(posedge clk) begin
    wdata1 <= wdata;
end
always @ (posedge clk) begin
    rdata <= rdata1;
end

assign tmp_neighborA = int_mem[@WRONG_ADDR + 1];
assign tmp_neighborB = int_mem[@WRONG_ADDR - 1];
assign tmp_neighborC = int_mem[@WRONG_ADDR];
assign tmp_neighborD = int_mem[@WRONG_ADDR];
assign tmp_mem       = int_mem[@WRONG_ADDR]; 

assign tmp_neighbor = {tmp_neighborA[1],tmp_neighborB[1],tmp_neighborC[2],tmp_neighborD[0]};

always@(posedge clk) begin
    if (write_read) begin
        if(address != @WRONG_ADDR)begin
            int_mem [address] <=  wdata1;
        end else begin
            if(tmp_neighbor == 4'b1001) begin
                int_mem[address] <= {wdata1[DATA_WIDTH-1:2],int_mem[1],wdata1[0]};
            end else begin
                int_mem [address] <=  wdata1;
            end
        end
    end
    else begin
       rdata1 <=  int_mem[address];
    end
end
endmodule
