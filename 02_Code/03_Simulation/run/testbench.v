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
    memory_sel = 0; 
    error_exceed_ignore = 0;
    allowable_faulty = 16'h00;
    memtype = 30 ; 

    #21;
    test_mode = 1;
    operation = 0; 
//-------------------- 0: marchc    ;    1: apnpsf
    error_exceed_ignore = 0;
    allowable_faulty = 16'h0F;
            
    #1001;
    test_mode = 0;
    operation = 0; 
    $display (" == MARCH C ARE RUNNING ==");
    #525000000; 
    $finish; 


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
              .address_0(address),
              .write_read_0(write_read),
              .wdata_0(wdata),
              .rdata_0(rdata),
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
        $display("MEMORY IS FAILED AT ADDRESS = : 0", address[8:0]);
    end
    else if (memtype[4:2] == 3'b001) begin       
        $display("MEMORY IS FAILED AT ADDRESS = : 0", address[9:0]);
    end
    else if (memtype[4:2] == 3'b010) begin       
        $display("MEMORY IS FAILED AT ADDRESS = : 0", address[10:0]);
    end
    else if (memtype[4:2] == 3'b011) begin       
        $display("MEMORY IS FAILED AT ADDRESS = : 0", address[11:0]);
    end
    else if (memtype[4:2] == 3'b100) begin       
        $display("MEMORY IS FAILED AT ADDRESS = : 0", address[12:0]);
    end
    else if (memtype[4:2] == 3'b101) begin       
        $display("MEMORY IS FAILED AT ADDRESS = : 0", address[13:0]);
    end
    else if (memtype[4:2] == 3'b110) begin       
        $display("MEMORY IS FAILED AT ADDRESS = : 0", address[14:0]);
    end
    else  begin       
        $display("MEMORY IS FAILED AT ADDRESS = : 0", address[15:0]);
    end
end

/*
initial begin
    $monitor ("time=0,clk=0,rst_n=0,test_mode=0,operation=0,error_exceed_ignore=0,allowable_faulty=%h,complete=0,force_terminate=0, address=%h, write_read=0, wdata=%h, rdata=%h \n",$time,clk,rst_n,test_mode,operation,error_exceed_ignore,allowable_faulty,complete,force_terminate, mbist_1.decoder_1.address, mbist_1.decoder_1.write_read, mbist_1.decoder_1.wdata, mbist_1.decoder_1.rdata);
end
*/


initial begin                            
    $vcdplusfile("t_testbench.vpd");   
    $vcdpluson();                       
end                                      
		
endmodule
