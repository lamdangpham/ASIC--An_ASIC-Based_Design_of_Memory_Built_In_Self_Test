//`timescale 1ns/1ps
module testbench();

//DEFINE PARAMETER
parameter DATA_WIDTH = 64;
parameter ADDR_WIDTH = 16;

wire write_read;
wire error;
wire force_terminate;
wire complete;
wire [ADDR_WIDTH-1:0] address;
wire [DATA_WIDTH-1:0] wdata;
wire [DATA_WIDTH-1:0] rdata;

reg [2:0]memory_sel;
reg [4:0]memtype;
reg [2:0]operation;
reg clk, rst_n, test_mode, error_exceed_ignore;
reg [ADDR_WIDTH-1:0] allowable_faulty;

//GENERATE CLOCK SIGNAL  
initial begin
    clk = 1;
    forever #10 clk = ~clk;
end
//GENERATE RESET SIGNAL
initial begin
    rst_n = 0;
    #11; rst_n = 1;
end

initial begin
    test_mode = 0;
    operation = 1;
    memory_sel = @MEMORY_SELECTION; 
    error_exceed_ignore = 0;
    allowable_faulty = 16'h00;
//DEFINE MEMTYPE

    #21;
    test_mode = 1;
//DEFINE OPERATION MODE
//-------------------- 0: marchc    ;    1: apnpsf
    error_exceed_ignore = 0;
    allowable_faulty = 16'h0F;
            
    #1001;
    test_mode = 0;
//DEFINE OPERATION MODE
//DEFINE FINISH TIME			  


//------------------- 103 000: marchc    ;    3 016 000: apnpsf
end

//---------- CONNECTION MBIST AND MEMORY TO TEST --------
mbist mbist_1(.clk(clk),
              .rst_n(rst_n),
              .test_mode(test_mode),
              .operation(operation),
              .error_exceed_ignore(error_exceed_ignore),
              .allowable_faulty(allowable_faulty),
              .memtype(memtype),
              .memory_sel(memory_sel),
              .address_@MEMORY_SELECTION(address),
              .write_read_@MEMORY_SELECTION(write_read),
              .wdata_@MEMORY_SELECTION(wdata),
              .rdata_@MEMORY_SELECTION(rdata),
              .error(error),
              .force_terminate(force_terminate),
              .complete(complete));
			  
fault_mem fault_mem_test(.clk(clk),
                .address(address),
                .write_read(write_read),
                .wdata(wdata),
                .rdata(rdata));



always@(posedge error) begin
    if (memtype[4:2] == 3'b000) begin       
        $display("MEMORY IS FAILED AT ADDRESS = : %d", address[8:0]);
    end
    else if (memtype[4:2] == 3'b001) begin       
        $display("MEMORY IS FAILED AT ADDRESS = : %d", address[9:0]);
    end
    else if (memtype[4:2] == 3'b010) begin       
        $display("MEMORY IS FAILED AT ADDRESS = : %d", address[10:0]);
    end
    else if (memtype[4:2] == 3'b011) begin       
        $display("MEMORY IS FAILED AT ADDRESS = : %d", address[11:0]);
    end
    else if (memtype[4:2] == 3'b100) begin       
        $display("MEMORY IS FAILED AT ADDRESS = : %d", address[12:0]);
    end
    else if (memtype[4:2] == 3'b101) begin       
        $display("MEMORY IS FAILED AT ADDRESS = : %d", address[13:0]);
    end
    else if (memtype[4:2] == 3'b110) begin       
        $display("MEMORY IS FAILED AT ADDRESS = : %d", address[14:0]);
    end
    else  begin       
        $display("MEMORY IS FAILED AT ADDRESS = : %d", address[15:0]);
    end
end

/*
initial begin
    $monitor ("time=%d,clk=%b,rst_n=%b,test_mode=%b,operation=%b,error_exceed_ignore=%b,allowable_faulty=%h,complete=%b,force_terminate=%b, address=%h, write_read=%b, wdata=%h, rdata=%h \n",$time,clk,rst_n,test_mode,operation,error_exceed_ignore,allowable_faulty,complete,force_terminate, mbist_1.decoder_1.address, mbist_1.decoder_1.write_read, mbist_1.decoder_1.wdata, mbist_1.decoder_1.rdata);
end
*/


//DEFINE WAVEFORM DEBUG
		
endmodule
