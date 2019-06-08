//`timescale 1ns/1ps
module marchc_datapath (clk, rst_n, start, en1, en2, en3, en4, en5, 
                    error_exceed_ignore, allowable_faulty, rdata,memtype,
                    address,
                    write_read,
                    wdata,
                    counter,
                    error,
                    force_terminate);
//DEFINE PARAMETER
parameter DATA_WIDTH =  64;
parameter ADDR_WIDTH =  16;

//DEFINE DATA
parameter DATA_0 = 64'h0000000000000000;
parameter DATA_1 = 64'hFFFFFFFFFFFFFFFF;

//DEFINE ERROR COUNTER START
parameter ERROR_COUNTER_RESET = 16'h0;
input clk,
      rst_n,
      start,
      en1,
      en2,
      en3,
      en4,
      en5,
      error_exceed_ignore;
input [ADDR_WIDTH-1:0] allowable_faulty;
input [DATA_WIDTH-1:0] rdata;
input [4:0] memtype;

output write_read;
output error;
output force_terminate;
output [ADDR_WIDTH-1:0] address;
output [DATA_WIDTH-1:0] wdata;
output [3:0] counter;

wire clk;
wire rst_n;
wire error_exceed_ignore;
wire start, en1, en2, en3, en4, en5;
wire [ADDR_WIDTH-1:0] allowable_faulty;
wire [DATA_WIDTH-1:0] rdata;
wire [ADDR_WIDTH-1:0] address;
wire force_terminate;
wire [4:0] memtype;


reg write_read;
reg error;
reg [DATA_WIDTH-1:0] wdata;
reg [3:0] counter;
reg [ADDR_WIDTH-1:0] address_1;
reg [ADDR_WIDTH-1:0] address_2;
reg [ADDR_WIDTH-1:0] address_3;
reg [ADDR_WIDTH-1:0] address_4;
reg [ADDR_WIDTH-1:0] error_counter;
reg start_1;
wire [ADDR_WIDTH-1:0]ADDRESS_0;
wire [ADDR_WIDTH-1:0]ADDRESS_1;

wire [DATA_WIDTH-1:0] wdata_cp;
reg [DATA_WIDTH-1:0] rdata_cp;
//Counter
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter <= 0;
    end
    else if ((counter == 4'b1001) | ((en5|start_1) & (counter == 4'b0100))) begin    //reset at cc 6th or cc 4th (when en5)
        counter <= 0;
    end
    else if (start_1|en1 | en2 | en3 | en4 | en5) begin
        counter <= counter + 1;
    end
    else begin
        counter <= 0;
    end
end
// DELAY 1 CLOCK FOR 'START' PULSE
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        start_1 <= 0;
    end
    else begin
        start_1 <= start;
    end
end

//**********MEMORY_CAPACITY_****************************************************
parameter ADDRESS_0_00000 = 16'b1111111000000000;//9bits
parameter ADDRESS_0_00100 = 16'b1111110000000000;//10bits
parameter ADDRESS_0_01000 = 16'b1111100000000000;//11bits
parameter ADDRESS_0_01100 = 16'b1111000000000000;//12bits
parameter ADDRESS_0_10000 = 16'b1110000000000000;//13bits
parameter ADDRESS_0_10100 = 16'b1100000000000000;//14bits
parameter ADDRESS_0_11000 = 16'b1000000000000000;//15bits
parameter ADDRESS_0_11100 = 16'b0000000000000000;//16bits

parameter ADDRESS_1_00000 = 16'b0000000111111111;//9bits
parameter ADDRESS_1_00100 = 16'b0000001111111111;//10bits
parameter ADDRESS_1_01000 = 16'b0000011111111111;//11bits
parameter ADDRESS_1_01100 = 16'b0000111111111111;//12bits
parameter ADDRESS_1_10000 = 16'b0001111111111111;//13bits
parameter ADDRESS_1_10100 = 16'b0011111111111111;//14bits
parameter ADDRESS_1_11000 = 16'b0111111111111111;//15bits
parameter ADDRESS_1_11100 = 16'b1111111111111111;//16bits
//**********************************MEMORY/PROCESSING*********************************
// PROCESS FOR IDCODE OF ADDRESS
//always @ (memtype) begin
//    if (memtype[3:2] == 2'b01) begin
//        ADDRESS_0 <= ADDRESS_0_0100;
//        ADDRESS_1 <= ADDRESS_1_0100;
//    end 
//    else if (memtype[3:2] == 2'b10) begin
//        ADDRESS_0 <= ADDRESS_0_1000;
//        ADDRESS_1 <= ADDRESS_1_1000;
//    end 
//    else begin
//       ADDRESS_0 <= ADDRESS_0_1100;
//     ADDRESS_1 <= ADDRESS_1_1100;
//    end 
//end
assign ADDRESS_1 = (memtype[4:2]==3'b000)? ADDRESS_1_00000:(memtype[4:2]==3'b001)? ADDRESS_1_00100: (memtype[4:2]==3'b010)? ADDRESS_1_01000:(memtype[4:2]==3'b011)? ADDRESS_1_01100:(memtype[4:2]==3'b100)? ADDRESS_1_10000:(memtype[4:2]==3'b101)? ADDRESS_1_10100:(memtype[4:2]==3'b110)? ADDRESS_1_11000:ADDRESS_1_11100;

assign ADDRESS_0 = (memtype[4:2]==3'b000)? ADDRESS_0_00000:(memtype[4:2]==3'b001)? ADDRESS_0_00100: (memtype[4:2]==3'b010)? ADDRESS_0_01000:(memtype[4:2]==3'b011)? ADDRESS_0_01100:(memtype[4:2]==3'b100)? ADDRESS_0_10000:(memtype[4:2]==3'b101)? ADDRESS_0_10100:(memtype[4:2]==3'b110)? ADDRESS_0_11000:ADDRESS_0_11100;

//----------------------------------------------                                                        
assign wdata_cp = wdata;
// PROCESS FOR IDCODE OF ADDRESS                                                                        
always @ (posedge clk or negedge rst_n) begin
    if (rst_n == 0) begin
        rdata_cp <= 0;
    end
    else begin                                                               
        if (memtype[1:0] == 2'b00) begin                                                                
            rdata_cp <= {wdata[DATA_WIDTH-1:8],rdata[7:0]};                                             
        end                                                                                             
        else if (memtype[1:0] == 2'b01) begin                                                           
            rdata_cp <= {wdata[DATA_WIDTH-1:16],rdata[15:0]};                                           
        end                                                                                             
        else if (memtype[1:0] == 2'b10) begin
            rdata_cp <= {wdata[DATA_WIDTH-1:32],rdata[31:0]};
        end
        else begin
            rdata_cp <= rdata[DATA_WIDTH-1:0];
        end
    end
end
//
//*****************************************************************************************************
//ADDRESS
always @(posedge clk or negedge rst_n ) begin
    if (!rst_n)begin
        address_1 <= ADDRESS_0;
    end
    else if (start_1 & (counter == 4'b0100)) begin
        if (&address_1) begin
            address_1 <= ADDRESS_0;
        end
        else begin
            address_1 <= address_1 + 1;  
        end
    end
    else begin
        address_1 <= address_1;
    end
end 

always @(posedge clk or negedge rst_n ) begin
    if (!rst_n) begin
         address_2 <= ADDRESS_0;
    end
    else if ((&address_2) & (counter == 4'b1001)) begin
         address_2 <= ADDRESS_0;
    end
    else if ((en1 | en2 ) & (counter == 4'b1001)) begin
         address_2 <= address_2 + 1;    // increase at cc 6th
    end
    else begin
         address_2 <= address_2;
    end
end

always @(posedge clk or negedge rst_n ) begin
    if (!rst_n) begin
        address_3 <= ADDRESS_1;
    end
    else if ((~|address_3) & (counter == 4'b1001)) begin
        address_3 <= ADDRESS_1;
    end
    else if ((en3 | en4 ) & (counter == 4'b1001)) begin
        address_3 <= address_3 - 1;    // decrease at cc 6th
    end
    else begin
        address_3 <= address_3;
    end
end

always @(posedge clk or negedge rst_n ) begin
    if (!rst_n) begin
        address_4 <= ADDRESS_0;
    end
    else if ((&address_4) & (counter == 4'b0100)) begin
        address_4 <= ADDRESS_0;
    end
    else if (en5 & (counter == 4'b0100)) begin // need 4cycle for read data of final march state
        address_4 <= address_4 + 1;    // increase at cc 4th
    end
    else begin
        address_4 <= address_4;
    end
end

assign address = (start_1) ? address_1 : (en1 | en2) ? address_2 : (en3 | en4) ? address_3 : (en5) ? address_4 :ADDRESS_0;

//WRITE DATA
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        wdata <= DATA_0;
    end
    else begin
        if (en1 | en3) begin // adjust the data for comparision and suitable with write_read signal
            if (counter== 4'b1001) begin
                wdata <= DATA_0;
            end
            else if (counter == 4'b0101) begin
                wdata <= DATA_1;
            end
            else begin
                wdata <= wdata;
            end
        end

        else if (en2 | en4) begin // adjust the data for comparision and suitable with write_read signal
            if (counter== 4'b0000) begin // delay clock
                wdata <= DATA_1;
            end
            else if (counter == 4'b0101) begin
                wdata <= DATA_0;
            end
            else begin
                wdata <= wdata;
            end
        end
        else begin
            wdata <= DATA_0;
        end
    end
end

// ENABLE COMPARE
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        error_counter <= ERROR_COUNTER_RESET;
        error <= 0;
    end
    else begin
        if ((counter == 4'b0101) & (!write_read)) begin
            error <= |(rdata_cp^ wdata_cp);    //compare at cc 3rd
            error_counter <= error + error_counter;
        end
    end
end  
// ENABLE WRITE, READ
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        write_read <= 1'b0;
    end
    else begin 
        if ( start & !en1 & (counter==0)) begin
            write_read <= 1'b0;
        end
        else if (((start_1 & start & !en1))| (~en5 & (counter == 4'b0101)) | (counter == 4'b0110)|(counter == 4'b0111)|(counter == 4'b1000)) begin
            write_read <= 1'b1;   //write_enable at cc 5th, write at cc 6th
        end
        else begin
            write_read <= 1'b0;   //read_enable at cc 1st, read at cc 2nd
        end
    end
end

assign force_terminate = ((~error_exceed_ignore) & (error_counter > allowable_faulty)) ? 1'b1 : 1'b0;
   
endmodule
