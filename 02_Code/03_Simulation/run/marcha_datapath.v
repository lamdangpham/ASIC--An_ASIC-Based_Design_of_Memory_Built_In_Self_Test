module marcha_datapath (clk, rst_n, start, en1, en2, en3, en4, 
                    error_exceed_ignore, allowable_faulty, rdata, memtype,
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
input clk;
input rst_n;
input start;
input en1;
input en2;
input en3;
input en4;
input error_exceed_ignore;
input [ADDR_WIDTH-1:0] allowable_faulty;
input [DATA_WIDTH-1:0] rdata;
input [4:0] memtype;

output write_read;
output error;
output force_terminate;
output [ADDR_WIDTH-1:0] address;
output [DATA_WIDTH-1:0] wdata;
output [4:0] counter;

wire clk;
wire rst_n;
wire error_exceed_ignore;
wire start, en1, en2, en3, en4;
wire [ADDR_WIDTH-1:0] allowable_faulty;
wire [DATA_WIDTH-1:0] rdata;
wire [ADDR_WIDTH-1:0] address;
wire force_terminate;
wire [4:0] memtype;

reg write_read;
reg error;
reg [ADDR_WIDTH-1:0] address_1;
reg [ADDR_WIDTH-1:0] address_2;
reg [ADDR_WIDTH-1:0] address_3;
reg [ADDR_WIDTH-1:0] error_counter;
reg start_1;
reg [4:0] counter;
reg [DATA_WIDTH-1:0] wdata;
wire [ADDR_WIDTH-1:0]ADDRESS_0;
wire [ADDR_WIDTH-1:0]ADDRESS_1;

wire [DATA_WIDTH-1:0] wdata_cp;
reg [DATA_WIDTH-1:0] rdata_cp;
//Counter
wire [5:0] pre_counter;
assign pre_counter = counter;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        counter <= 0;
    end
    else if ((counter == 5'b10000) | (start_1 & (counter == 5'b00100)) | ((en2|en4) & (counter == 5'b01100))) begin
        counter <= 0;
    end
    else if (start_1 | en1 | en2 | en3 | en4) begin
        counter <= counter + 1;
    end
    else begin
        counter <= pre_counter;
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
parameter ADDRESS_0_00000 = 16'b1111111000000000;//2bits
parameter ADDRESS_0_00100 = 16'b1111110000000000;//4bits
parameter ADDRESS_0_01000 = 16'b1111100000000000;//6bits
parameter ADDRESS_0_01100 = 16'b1111000000000000;//8bits
parameter ADDRESS_0_10000 = 16'b1110000000000000;//10bits
parameter ADDRESS_0_10100 = 16'b1100000000000000;//12bits
parameter ADDRESS_0_11000 = 16'b1000000000000000;//14bits
parameter ADDRESS_0_11100 = 16'b0000000000000000;//16bits

parameter ADDRESS_1_00000 = 16'b0000000111111111;//2bits
parameter ADDRESS_1_00100 = 16'b0000001111111111;//4bits
parameter ADDRESS_1_01000 = 16'b0000011111111111;//6bits
parameter ADDRESS_1_01100 = 16'b0000111111111111;//8bits
parameter ADDRESS_1_10000 = 16'b0001111111111111;//10bits
parameter ADDRESS_1_10100 = 16'b0011111111111111;//12bits
parameter ADDRESS_1_11000 = 16'b0111111111111111;//14bits
parameter ADDRESS_1_11100 = 16'b1111111111111111;//16bits
//**********************************MEMORY/PROCESSING*********************************

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
        address_1 <= ADDRESS_1;
    end
    else if (start_1 & (counter == 5'b00100)) begin
        if (~|address_1) begin
            address_1 <= ADDRESS_1;
        end
        else begin
            address_1 <= address_1 - 1;  
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
    else if ((&address_2) & (counter == 5'b10000)) begin
         address_2 <= ADDRESS_0;
    end
    else if ((en1  & (counter == 5'b10000)) | (en2 & (counter == 5'b01100))) begin
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
    else if ((~|address_3) & (counter == 5'b01111)) begin
        address_3 <= ADDRESS_1;
    end
    else if ((en3 & (counter == 5'b01111)) | (en4 & (counter == 5'b01100))) begin
        address_3 <= address_3 - 1;    // decrease at cc 6th
    end
    else begin
        address_3 <= address_3;
    end
end

assign address = (start_1) ? address_1 : (en1 | en2) ? address_2 : (en3 | en4) ? address_3 :ADDRESS_0;

//WRITE DATA
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        wdata <= DATA_0;
    end
    else begin
        if (en1) begin 
            if (counter== 5'b10000) begin
                wdata <= DATA_0;
            end
            else if (counter == 5'b00101) begin
                wdata <= DATA_1;
            end
            else if (counter == 5'b01000) begin
                wdata <= DATA_0;
            end
            else if (counter == 5'b01011) begin
                wdata <= DATA_1;
            end
            else begin
                wdata <= wdata;
            end
        end

        else if (en2) begin 
               if (counter== 5'b10000) begin // delay clock
                wdata <= DATA_1;
               end
             //  if ((counter==5'b00001)) begin
             //   wdata <= DATA_1;  
             //  end 
               else if (counter == 5'b00101) begin
                wdata <= DATA_0;
               end
               else if (counter == 5'b01000) begin
                wdata <= DATA_1;
               end
               else begin
                wdata <= wdata;
               end
        end

        else if (en3) begin
               if (counter== 5'b01111) begin
                wdata <= DATA_1;
               end
               else if (counter == 5'b00101) begin
                wdata <= DATA_0;
               end
               else if (counter == 5'b01000) begin
                wdata <= DATA_1;
               end
               else if (counter == 5'b01011) begin
                wdata <= DATA_0;
               end
               else begin
                wdata <= wdata;
               end
        end

        else if (en4) begin // adjust the data for comparision and suitable with write_read signal
               if (counter== 5'b10000) begin // delay clock
                wdata <= DATA_0;
               end
               else if (counter == 5'b00101) begin
                wdata <= DATA_1;
               end
               else if (counter == 5'b01000) begin
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
        if (((counter == 5'b00101) & (!write_read) & (en1|en2|en3)) | (en4&(counter == 5'b00101)&(!write_read))) begin
            error <= |(rdata_cp^ wdata_cp);    //compare at cc 3rd
            error_counter <= error + error_counter;
        end
        else begin
            error <= 0;
            error_counter <= error_counter;
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
        else if ((start_1 & start & !en1)|((en1)&((counter == 5'b00101)|(counter == 5'b00110) | (counter == 5'b00111) | (counter == 5'b01000) | (counter == 5'b01001) | (counter == 5'b01010) | (counter == 5'b01011) | (counter == 5'b01100) | (counter == 5'b01101) | (counter == 5'b01110)|(counter==5'b01111))) | ((en2|en4)&((counter == 5'b00101)|(counter == 5'b00110)|(counter == 5'b00111)|(counter == 5'b01000)|(counter == 5'b01001)|(counter == 5'b01010)|(counter == 5'b01011)))|(en3&((counter==5'b00101)|(counter==5'b00110)|(counter==5'b00111)|(counter==5'b01000)|(counter==5'b01001)|(counter==5'b01010)|(counter==5'b01011)|(counter==5'b01100)|(counter==5'b01101)|(counter==5'b01110)))) begin
            write_read <= 1'b1;   //write_enable at cc 5th, write at cc 6th
        end
        else begin
            write_read <= 1'b0;   //read_enable at cc 1st, read at cc 2nd
        end
    end
end

assign force_terminate = ((~error_exceed_ignore) & (error_counter > allowable_faulty)) ? 1'b1 : 1'b0;
   
endmodule
