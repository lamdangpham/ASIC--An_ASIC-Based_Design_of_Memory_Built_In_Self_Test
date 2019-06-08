//`timescale 1ns/1ps
module apnpsf_datapath (clk,
                        rst_n,
                        start,
                        en1,
                        en2,
                        en3,
                        en4,
                        en5,
                        en6,
                        en7,
                        en8,
                        en9,
                        en10,
                        en11,
                        en12,
                        en13,
                        en14,
                        en15,
                        en16,
                        error_exceed_ignore,
                        allowable_faulty, 
                        address,				
                        write_read,
                        wdata,
                        rdata,
                        counter,
                        error,
                        force_terminate,
                        memtype);
// DEFINE PARAMETER 
parameter DATA_WIDTH = 64;

parameter ADDR_WIDTH_000= 9;
parameter ADDR_WIDTH_001= 10;
parameter ADDR_WIDTH_010= 11;
parameter ADDR_WIDTH_011= 12;
parameter ADDR_WIDTH_100= 13;
parameter ADDR_WIDTH_101= 14;
parameter ADDR_WIDTH_110= 15;
parameter ADDR_WIDTH = 16; // parameter ADDR_WDITH_111 = 16;

// DEFINE DATA
parameter DATA_0 = 64'h0000000000000000;
parameter DATA_1 = 64'hFFFFFFFFFFFFFFFF;

input clk,
      rst_n,
      start,
      en1,
      en2,
      en3,
      en4,
      en5,
      en6,
      en7,
      en8,
      en9,
      en10,
      en11,
      en12,
      en13,
      en14,
      en15,
      en16,
      error_exceed_ignore;
input [ADDR_WIDTH-1:0] allowable_faulty;
input [DATA_WIDTH-1:0] rdata;
input [4:0] memtype;

	  
output write_read;
output error;
output force_terminate;
output [ADDR_WIDTH-1:0] address;
output [DATA_WIDTH-1:0] wdata;
output [8:0] counter;

wire clk;
wire rst_n;
wire error_exceed_ignore;
wire write_read;
wire force_terminate;
wire start, en1, en2, en3, en4, en5, en6, en7, en8, en9, en10, en11, en12, en13, en14, en15, en16;
wire [ADDR_WIDTH-1:0] allowable_faulty;
wire [ADDR_WIDTH-1:0] address;                  			
wire [DATA_WIDTH-1:0] wdata;
wire [DATA_WIDTH-1:0] rdata;     
wire [4:0]memtype;


reg error,
    write_read_1,
    write_read_2,
    delay_start;
reg [8:0] counter;
reg [ADDR_WIDTH-1:0] address_1;
reg [ADDR_WIDTH-1:0] address_2;
reg [DATA_WIDTH-1:0] wdata_1;
reg [DATA_WIDTH-1:0] wdata_2;
reg [ADDR_WIDTH-1:0] error_counter;
reg [DATA_WIDTH-1:0] rdata_cp;

reg [7:0] counter_1;

// counter
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter <= 0;
    end
    else if (counter == 9'h1A4) begin
        counter <= 0;
    end
    else if (en1 | en2 | en3 | en4 | en5 | en6 | en7 | en8 | en9 | en10 | en11 | en12 | en13 | en14 | en15 | en16) begin
        counter <= counter + 1;
    end
    else begin
        counter <= 0;
    end
end
//counter_1
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter_1 <= 0;
    end
    else if (counter_1 ==4) begin
        counter_1 <= 0;
    end
    else if (delay_start) begin
        counter_1 <= counter_1 + 1;
    end
    else begin
        counter_1 <= 0;
    end
end
//-------------------------MEMORY PROCESSING---------------------------------
//---PROCESSING FOR EXPANDING DATA WIDTH---------
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rdata_cp <= 0;
    end
    else begin
        if (memtype[1:0] == 2'b00) begin
            rdata_cp <= {wdata_2[DATA_WIDTH-1:8],rdata[7:0]};
        end
        else if (memtype[1:0]== 2'b01) begin
            rdata_cp <= {wdata_2[DATA_WIDTH-1:16],rdata[15:0]};
        end
        else if (memtype[1:0] == 2'b10) begin
            rdata_cp <= {wdata_2[DATA_WIDTH-1:32],rdata[31:0]};
        end
        else begin
            rdata_cp <= rdata;
        end
    end
end
//------------------------------------------------------------------------------

assign address = (start|delay_start) ? address_1 : (en1 | en2 | en3 | en4 | en5 | en6 | en7 | en8 | en9 | en10 | en11 | en12 | en13 | en14 | en15 | en16) ? address_2 : 16'h00;
assign wdata = (start) ? wdata_1 : (en1 | en2 | en3 | en4 | en5 | en6 | en7 | en8 | en9 | en10 | en11 | en12 | en13 | en14 | en15 | en16) ? wdata_2 : DATA_0;
assign write_read = (start|delay_start) ? write_read_1 : (en1 | en2 | en3 | en4 | en5 | en6 | en7 | en8 | en9 | en10 | en11 | en12 | en13 | en14 | en15 | en16) ? write_read_2 : 1'b0;

// delay_start
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        delay_start <= 0;
    end
    else if (start) begin
        delay_start <= start;
    end
    else begin
        delay_start <= 0;
    end
end

// data_1
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        wdata_1 <= 0;
        write_read_1 <= 0;
    end
    else if (start) begin
        write_read_1 <= 1;
        wdata_1 <= 0;
    end
    else begin
        wdata_1 <= 0;
        write_read_1 <= 0;
    end
end

// address_1
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        address_1 <= 0;
    end
    else if ((&address_1[ADDR_WIDTH_000-1:0]) & (counter_1 == 3) & (memtype[4:2] == 3'b000) ) begin
        address_1 <= 0;
    end
    else if ((&address_1[ADDR_WIDTH_001-1:0]) & (counter_1 == 3) & (memtype[4:2] == 3'b001) ) begin
        address_1 <= 0;
    end
    else if ((&address_1[ADDR_WIDTH_010-1:0]) & (counter_1 == 3) & (memtype[4:2] == 3'b010) ) begin
        address_1 <= 0;
    end
    else if ((&address_1[ADDR_WIDTH_011-1:0]) & (counter_1 == 3) & (memtype[4:2] == 3'b011) ) begin
        address_1 <= 0;
    end
    else if ((&address_1[ADDR_WIDTH_100-1:0]) & (counter_1 == 3) & (memtype[4:2] == 3'b100) ) begin
        address_1 <= 0;
    end
    else if ((&address_1[ADDR_WIDTH_101-1:0]) & (counter_1 == 3) & (memtype[4:2] == 3'b101) ) begin
        address_1 <= 0;
    end
    else if ((&address_1[ADDR_WIDTH_110-1:0]) & (counter_1 == 3) & (memtype[4:2] == 3'b110) ) begin
        address_1 <= 0;
    end
    else if ((&address_1[ADDR_WIDTH-1:0]) & (counter_1 == 3) & (memtype[4:2] == 3'b111) ) begin
        address_1 <= 0;
    end
    else if (delay_start & (counter_1 == 4)) begin
        address_1 <= address_1 + 1;
    end
    else begin
        address_1 <= address_1;
    end
end

// data_2 &  address_2     
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        address_2 <= 0;
        wdata_2 <= 0;
        write_read_2 <= 0;
        error <= 0;
        error_counter <= 0;
    end
    else if (counter == 9'h1A4) begin
        wdata_2 <= 0;
        write_read_2 <= 0;
        error <= 0; 
        if (&address[ADDR_WIDTH-1:2] & (memtype[4:2] == 3'b111)) begin
            address_2 <= 0;
        end
        else if (&address[ADDR_WIDTH_110-1:2] & (memtype[4:2] == 3'b110)) begin
            address_2 <= 0;
        end 
        else if (&address[ADDR_WIDTH_101-1:2] & (memtype[4:2] == 3'b101)) begin
            address_2 <= 0;
        end 
        else if (&address[ADDR_WIDTH_100-1:2] & (memtype[4:2] == 3'b100)) begin
            address_2 <= 0;
        end 
        else if (&address[ADDR_WIDTH_011-1:2] & (memtype[4:2] == 3'b011)) begin
            address_2 <= 0;
        end 
        else if (&address[ADDR_WIDTH_010-1:2] & (memtype[4:2] == 3'b010)) begin
            address_2 <= 0;
        end 
        else if (&address[ADDR_WIDTH_001-1:2] & (memtype[4:2] == 3'b001)) begin
            address_2 <= 0;
        end 
        else if (&address[ADDR_WIDTH_000-1:2] & (memtype[4:2] == 3'b000)) begin
            address_2 <= 0;
        end 
        else begin   
            address_2 <= address_2 + 4;
        end
    end
    else begin
    case (counter)

//0000
    9'h001: begin // write data with address
        write_read_2 <= 1;
        wdata_2 <= DATA_0;
        if (~|address_2) begin
            if (en1 | en3 | en9 | en11) begin
                address_2 <= address_2 - 1;
            end
            else if (en5 | en7 | en13 | en15) begin
                address_2 <= address_2;
            end
            else if (en2 | en4 | en10 | en12) begin
                address_2 <= address_2 + 1;
            end
            else begin
                address_2 <= address_2 + 2;
            end
        end
        else begin
            address_2 <= address_2 - 1;
        end
    end
    9'h006: begin //read data with address
        address_2 <= address_2 + 1;
        write_read_2 <= 0;
    end
    9'h00C: begin //compare
        error <= (rdata_cp !=  DATA_0);
    end

    9'h00D: begin // write data
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h8888888888888888;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h4444444444444444;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h2222222222222222;
        end
        else begin
            wdata_2 <= 64'h1111111111111111;
        end
    end

    9'h012: begin // read data
        write_read_2 <= 0;
    end

    9'h018: begin // compare
        error <= (rdata_cp != wdata_2);
    end

    9'h019: begin
        error_counter <= error_counter + error;
		    error <= 0;
    end

//0001
    9'h01B: begin
        write_read_2 <= 1;
        address_2 <= address_2 - 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h8888888888888888;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h4444444444444444;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h2222222222222222;
        end
        else begin
            wdata_2 <= 64'h1111111111111111;
        end
    end

    9'h020: begin
        address_2 <= address_2 + 1;
        write_read_2 <= 0;
    end

    9'h026: begin
        if (en1 | en4 | en13 | en16) begin
            error <= (rdata_cp != 64'h8888888888888888);
        end
        else if (en5 | en8 | en9 | en12) begin
            error <= (rdata_cp != 64'h4444444444444444);
        end
        else if (en2 | en3 | en14 | en15) begin
            error <= (rdata_cp != 64'h2222222222222222);
        end
        else begin
            error <= (rdata_cp != 64'h1111111111111111);
        end
    end

    9'h027: begin 
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        wdata_2 <= DATA_0;
    end

    9'h02C: begin
        write_read_2 <= 0;
    end

    9'h032: begin
        error <= (rdata_cp != DATA_0);
    end

    9'h033: begin
        error_counter <= error_counter + error;
        error <= 0;
    end      

//0011
    9'h035: begin
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h4444444444444444;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h2222222222222222;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h1111111111111111;
        end
        else begin
            wdata_2 <= 64'h0808080808080808;
        end
    end

    9'h03A: begin
        write_read_2 <= 0;
    end

    9'h040: begin
        if (en1 | en4 | en13 | en16) begin
            error <= (rdata_cp != 64'h4444444444444444);
        end
        else if (en5 | en8 | en9 | en12) begin
            error <= (rdata_cp != 64'h2222222222222222);
        end
        else if (en2 | en3 | en14 | en15) begin
            error <= (rdata_cp != 64'h1111111111111111);
        end
        else begin
            error <= (rdata_cp != 64'h0808080808080808);
        end
    end

    9'h041: begin 
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'hCCCCCCCCCCCCCCCC;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h6666666666666666;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h3333333333333333;
        end
        else begin
            wdata_2 <= 64'h1818181818181818;
        end
    end

    9'h046: begin
        write_read_2 <= 0;
    end

    9'h04C: begin
        error <= (rdata_cp != wdata_2);
    end

    9'h04D: begin
        error_counter <= error_counter + error;
        error <= 0;
    end

//0010
    9'h04F: begin // write
        write_read_2 <= 1;
        address_2 <= address_2 - 1;
        wdata_2 <= DATA_0;
    end

    9'h054: begin //read
        write_read_2 <= 0;
        address_2 <= address_2 + 1;

        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'hCCCCCCCCCCCCCCCC;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h6666666666666666;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= (64'h3333333333333333);
        end
        else begin
            wdata_2 <= (64'h1818181818181818);
        end

    end

    9'h05A: begin // compare
        if (en1 | en4 | en13 | en16) begin
            error <= (rdata_cp != 64'hCCCCCCCCCCCCCCCC);
        end
        else if (en5 | en8 | en9 | en12) begin
            error <= (rdata_cp != 64'h6666666666666666);
        end
        else if (en2 | en3 | en14 | en15) begin
            error <= (rdata_cp != 64'h3333333333333333);
        end
        else begin
            error <= (rdata_cp != 64'h1818181818181818);
        end
    end

    9'h05B: begin // write
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h4444444444444444;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h2222222222222222;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h1111111111111111;
        end
        else begin
            wdata_2 <= 64'h0808080808080808;
        end
    end 

    9'h060: begin // read
        write_read_2 <= 0;
    end

    9'h066: begin // compare
        error <= (rdata_cp != wdata_2);
    end

    9'h067: begin
        error_counter <= error_counter + error;
        error <= 0;
    end

//0110
    9'h069: begin // write
        write_read_2 <= 1;
        address_2 <= address_2 + 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h8888888888888888;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h4444444444444444;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h2222222222222222;
        end
        else begin
            wdata_2 <= 64'h1111111111111111;
        end
    end

    9'h06E: begin // read
        write_read_2 <= 0;
        address_2 <= address_2 - 1;

        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= (64'h4444444444444444);
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= (64'h2222222222222222);
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= (64'h1111111111111111);
        end
        else begin
            wdata_2 <= (64'h0808080808080808);
        end


    end

    9'h074: begin // compare
        if (en1 | en4 | en13 | en16) begin
            error <= (rdata_cp != 64'h4444444444444444);
        end
        else if (en5 | en8 | en9 | en12) begin
            error <= (rdata_cp != 64'h2222222222222222);
        end
        else if (en2 | en3 | en14 | en15) begin
            error <= (rdata_cp != 64'h1111111111111111);
        end
        else begin
            error <= (rdata_cp != 64'h0808080808080808);
        end
    end

    9'h075: begin // write
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'hCCCCCCCCCCCCCCCC;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h6666666666666666;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h3333333333333333;
        end
        else begin
            wdata_2 <= 64'h1818181818181818;
        end
    end

    9'h07A: begin // read
        write_read_2 <= 0;
    end

    9'h080: begin // compare
        error <= (rdata_cp != wdata_2);
    end

    9'h081: begin
        error_counter <= error_counter + error;
        error <= 0;
    end

//0111
    9'h083: begin // write
        write_read_2 <= 1;
        address_2 <= address_2 - 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h8888888888888888;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h4444444444444444;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h2222222222222222;
        end
        else begin
            wdata_2 <= 64'h1111111111111111;
        end
    end

    9'h088: begin // read
        write_read_2 <= 0;
        address_2 <= address_2 + 1; 
   
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= (64'hCCCCCCCCCCCCCCCC);
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= (64'h6666666666666666);
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= (64'h3333333333333333);
        end
        else begin
            wdata_2 <= (64'h1818181818181818);
        end
 
    end

    9'h08E: begin // compare
        if (en1 | en4 | en13 | en16) begin
            error <= (rdata_cp != 64'hCCCCCCCCCCCCCCCC);
        end
        else if (en5 | en8 | en9 | en12) begin
            error <= (rdata_cp != 64'h6666666666666666);
        end
        else if (en2 | en3 | en14 | en15) begin
            error <= (rdata_cp != 64'h3333333333333333);
        end
        else begin
            error <= (rdata_cp != 64'h1818181818181818);
        end
    end

    9'h08F: begin //  write
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h4444444444444444;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h2222222222222222;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h1111111111111111;
        end
        else begin
            wdata_2 <= 64'h0808080808080808;
        end	
    end 

    9'h094: begin
        write_read_2 <= 0;
    end

    9'h09A: begin
        error <= (rdata_cp != wdata_2);
    end

    9'h09B: begin
        error_counter <= error_counter + error;
        error <= 0;
    end

//0101
    9'h09D: begin
        write_read_2 <= 1;
        wdata_2 <= DATA_0;
    end

    9'h0A2: begin
        write_read_2 <= 0;
    end

    9'h0A8: begin
        error <= (rdata_cp != wdata_2);
    end

    9'h0A9: begin 
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h8888888888888888;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h4444444444444444;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h2222222222222222;
        end
        else begin
            wdata_2 <= 64'h1111111111111111;
        end
    end

    9'h0AE: begin
        write_read_2 <= 0;
    end

    9'h0B4: begin
        error <= (rdata_cp != wdata_2);
    end

    9'h0B5: begin
        error_counter <= error_counter + error;
        error <= 0;
    end

//0100
    9'h0B7: begin
        write_read_2 <= 1;
        address_2 <= address_2 - 1;
        wdata_2 <= DATA_0;
    end

    9'h0BC: begin
        write_read_2 <= 0;
        address_2 <= address_2 + 1;
    
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= ( 64'h8888888888888888);
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= ( 64'h4444444444444444);
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= ( 64'h2222222222222222);
        end
        else begin
            wdata_2 <= ( 64'h1111111111111111);
        end

    end

    9'h0C2: begin
        if (en1 | en4 | en13 | en16) begin
            error <= (rdata_cp != 64'h8888888888888888);
        end
        else if (en5 | en8 | en9 | en12) begin
            error <= (rdata_cp != 64'h4444444444444444);
        end
        else if (en2 | en3 | en14 | en15) begin
            error <= (rdata_cp != 64'h2222222222222222);
        end
        else begin
            error <= (rdata_cp != 64'h1111111111111111);
        end
    end

    9'h0C3: begin 
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        wdata_2 <= DATA_0;
    end

    9'h0C8: begin
        write_read_2 <= 0;
    end

    9'h0CE: begin
        error <= (rdata_cp != wdata_2);
    end

    9'h0CF: begin
        error_counter <= error_counter + error;
        error <= 0;
    end

//1100
    9'h0D1: begin
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h1010101010101010;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h8888888888888888;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h4444444444444444;
        end
        else begin
            wdata_2 <= 64'h2222222222222222;
        end
    end

    9'h0D6: begin
        write_read_2 <= 0;
    end

    9'h0DC: begin
        error <= (rdata_cp != wdata_2);    
    end

    9'h0DD: begin
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h9898989898989898;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'hCCCCCCCCCCCCCCCC;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h6666666666666666;
        end
        else begin
            wdata_2 <= 64'h3333333333333333;
        end
    end

    9'h0E2: begin
        write_read_2 <= 0;
    end

    9'h0E8: begin
        error <= (rdata_cp != wdata_2);
    end

    9'h0E9: begin
        error_counter <= error_counter + error;
        error <= 0;
    end

//1101
    9'h0EB: begin
        write_read_2 <= 1;
        address_2 <= address_2 - 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h8888888888888888;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h4444444444444444;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h2222222222222222;
        end
        else begin
            wdata_2 <= 64'h1111111111111111;
        end
    end

    9'h0F0: begin
        write_read_2 <= 0;
        address_2 <= address_2 + 1;

        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= ( 64'h9898989898989898);
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= ( 64'hCCCCCCCCCCCCCCCC);
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= ( 64'h6666666666666666);
        end
        else begin
            wdata_2 <= ( 64'h3333333333333333);
        end   

    end

    9'h0F6: begin
        if (en1 | en4 | en13 | en16) begin
            error <= (rdata_cp != 64'h9898989898989898);
        end
        else if (en5 | en8 | en9 | en12) begin
            error <= (rdata_cp != 64'hCCCCCCCCCCCCCCCC);
        end
        else if (en2 | en3 | en14 | en15) begin
            error <= (rdata_cp != 64'h6666666666666666);
        end
        else begin
            error <= (rdata_cp != 64'h3333333333333333);
        end   
    end

    9'h0F7: begin 
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h1010101010101010;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h8888888888888888;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h4444444444444444;
        end
        else begin
            wdata_2 <= 64'h2222222222222222;
        end
    end

    9'h0FC: begin
        write_read_2 <= 0;
    end

    9'h102: begin
        error <= (rdata_cp != wdata_2);
    end

    9'h103: begin
        error_counter <= error_counter + error;
        error <= 0;
    end

//1111
    9'h105: begin
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h5454545454545454;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'hAAAAAAAAAAAAAAAA;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h5555555555555555;
        end
        else begin
            wdata_2 <= 64'h2A2A2A2A2A2A2A2A;
        end
    end

    9'h10A: begin
        write_read_2 <= 0;
    end

    9'h110: begin
        error <= (rdata_cp != wdata_2);  
    end

    9'h111: begin 
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'hDCDCDCDCDCDCDCDC;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'hEEEEEEEEEEEEEEEE;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h7777777777777777;
        end
        else begin
            wdata_2 <= 64'h3B3B3B3B3B3B3B3B;
        end
    end

    9'h116: begin
        write_read_2 <= 0;
    end

    9'h11C: begin
        error <= (rdata_cp != wdata_2);
    end

    9'h11D: begin
        error_counter <= error_counter + error;
        error <= 0;
    end

//1110
    9'h11F: begin
        write_read_2 <= 1;
        address_2 <= address_2 - 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h8888888888888888;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h4444444444444444;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h2222222222222222;
        end
        else begin
            wdata_2 <= 64'h1111111111111111;
        end
    end

    9'h124: begin
        write_read_2 <= 0;
        address_2 <= address_2 + 1;


        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= ( 64'hDCDCDCDCDCDCDCDC);
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= ( 64'hEEEEEEEEEEEEEEEE);
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= ( 64'h7777777777777777);
        end
        else begin
            wdata_2 <= ( 64'h3B3B3B3B3B3B3B3B);
        end    

    end

    9'h12A: begin
        if (en1 | en4 | en13 | en16) begin
            error <= (rdata_cp != 64'hDCDCDCDCDCDCDCDC);
        end
        else if (en5 | en8 | en9 | en12) begin
            error <= (rdata_cp != 64'hEEEEEEEEEEEEEEEE);
        end
        else if (en2 | en3 | en14 | en15) begin
            error <= (rdata_cp != 64'h7777777777777777);
        end
        else begin
            error <= (rdata_cp != 64'h3B3B3B3B3B3B3B3B);
        end    
    end

    9'h12B: begin 
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h5454545454545454;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'hAAAAAAAAAAAAAAAA;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h5555555555555555;
        end
        else begin
            wdata_2 <= 64'h2A2A2A2A2A2A2A2A;
        end
    end

    9'h130: begin
        write_read_2 <= 0;
    end

    9'h136: begin
        error <= (rdata_cp != wdata_2);
    end

    9'h137: begin
        error_counter <= error_counter + error;
        error <= 0;
    end

//1010
    9'h139: begin
        write_read_2 <= 1;
        address_2 <= address_2 + 1;
        wdata_2 <= DATA_0;
    end

    9'h13E: begin
        write_read_2 <= 0;
        address_2 <= address_2 - 1;

        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= ( 64'h5454545454545454);
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= ( 64'hAAAAAAAAAAAAAAAA);
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= ( 64'h5555555555555555);
        end
        else begin
            wdata_2 <= ( 64'h2A2A2A2A2A2A2A2A);
        end    

    end

    9'h144: begin
        if (en1 | en4 | en13 | en16) begin
            error <= (rdata_cp != 64'h5454545454545454);
        end
        else if (en5 | en8 | en9 | en12) begin
            error <= (rdata_cp != 64'hAAAAAAAAAAAAAAAA);
        end
        else if (en2 | en3 | en14 | en15) begin
            error <= (rdata_cp != 64'h5555555555555555);
        end
        else begin
            error <= (rdata_cp != 64'h2A2A2A2A2A2A2A2A);
        end    
    end

    9'h145: begin 
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'hDADADADADADADADA;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'hEEEEEEEEEEEEEEEE;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h7777777777777777;
        end
        else begin
            wdata_2 <= 64'h3B3B3B3B3B3B3B3B;
        end
    end

    9'h14A: begin
        write_read_2 <= 0;
    end

    9'h150: begin
        error <= (rdata_cp != wdata_2);
    end

    9'h151: begin
        error_counter <= error_counter + error;
        error <= 0;
    end

//1011
    9'h153: begin
        write_read_2 <= 1;
        address_2 <= address_2 - 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h8888888888888888;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h4444444444444444;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h2222222222222222;
        end
        else begin
            wdata_2 <= 64'h1111111111111111;
        end
    end

    9'h158: begin
        write_read_2 <= 0;
        address_2 <= address_2 + 1;
   
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= ( 64'hDADADADADADADADA);
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= ( 64'hEEEEEEEEEEEEEEEE);
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= ( 64'h7777777777777777);
        end
        else begin
            wdata_2 <= ( 64'h3B3B3B3B3B3B3B3B);
        end    

     end

    9'h15E: begin
        if (en1 | en4 | en13 | en16) begin
            error <= (rdata_cp != 64'hDADADADADADADADA);
        end
        else if (en5 | en8 | en9 | en12) begin
            error <= (rdata_cp != 64'hEEEEEEEEEEEEEEEE);
        end
        else if (en2 | en3 | en14 | en15) begin
            error <= (rdata_cp != 64'h7777777777777777);
        end
        else begin
            error <= (rdata_cp != 64'h3B3B3B3B3B3B3B3B);
        end    
    end

    9'h15F: begin 
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h5454545454545454;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'hAAAAAAAAAAAAAAAA;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h5555555555555555;
        end
        else begin
            wdata_2 <= 64'h2A2A2A2A2A2A2A2A;
        end
    end

    9'h164: begin
        write_read_2 <= 0;
    end

    9'h16A: begin
        error <= (rdata_cp != wdata_2);
    end

    9'h16B: begin
        error_counter <= error_counter + error;
        error <= 0;
    end

//1001
    9'h16D: begin
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h1010101010101010;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h8888888888888888;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h4444444444444444;
        end
        else begin
            wdata_2 <= 64'h2222222222222222;
        end
    end

    9'h172: begin
        write_read_2 <= 0;
    end

    9'h178: begin
        error <= (rdata_cp != wdata_2);  
    end

    9'h179: begin 
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h9898989898989898;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'hCCCCCCCCCCCCCCCC;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h6666666666666666;
        end
        else begin
            wdata_2 <= 64'h3333333333333333;
        end
    end

    9'h17E: begin
        write_read_2 <= 0;
    end

    9'h184: begin
        error <= (rdata_cp != wdata_2);
    end

    9'h185: begin
        error_counter <= error_counter + error;
        error <= 0;
    end

//1000
    9'h187: begin
        write_read_2 <= 1;
        address_2 <= address_2 - 1;
        wdata_2 <= DATA_0;
    end

    9'h18C: begin
        write_read_2 <= 0;
        address_2 <= address_2  + 1;


        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= ( 64'h9898989898989898);
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= ( 64'hCCCCCCCCCCCCCCCC);
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= ( 64'h6666666666666666);
        end
        else begin
            wdata_2 <= ( 64'h3333333333333333);
        end   

    end

    9'h192: begin
        if (en1 | en4 | en13 | en16) begin
            error <= (rdata_cp != 64'h9898989898989898);
        end
        else if (en5 | en8 | en9 | en12) begin
            error <= (rdata_cp != 64'hCCCCCCCCCCCCCCCC);
        end
        else if (en2 | en3 | en14 | en15) begin
            error <= (rdata_cp != 64'h6666666666666666);
        end
        else begin
            error <= (rdata_cp != 64'h3333333333333333);
        end   
    end

    9'h193: begin 
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        if (en1 | en4 | en13 | en16) begin
            wdata_2 <= 64'h1010101010101010;
        end
        else if (en5 | en8 | en9 | en12) begin
            wdata_2 <= 64'h8888888888888888;
        end
        else if (en2 | en3 | en14 | en15) begin
            wdata_2 <= 64'h4444444444444444;
        end
        else begin
            wdata_2 <= 64'h2222222222222222;
        end
    end

    9'h198: begin
        write_read_2 <= 0;
    end

    9'h19E: begin
        error <= (rdata_cp != wdata_2);
    end

    9'h19F: begin
        error_counter <= error_counter + error;
        error <= 0;
        write_read_2 <= 1;
        wdata_2 <= DATA_0;
    end

    9'h1A4: begin
        write_read_2 <= 0;
    end
	
    endcase
    end
end

assign force_terminate = ((~error_exceed_ignore) & (error_counter > allowable_faulty)) ? 1'b1 : 1'b0;
   
endmodule
