//`timescale 1ns/1ps
module apnpsf_controller (clk,
                          rst_n,
                          apnpsf_en,
                          memtype,
                          address,
                          counter,
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
                          finish);

parameter ADDR_WIDTH = 16; // parameter ADDR_WIDTH_111
parameter ADDR_WIDTH_110 = 15;
parameter ADDR_WIDTH_101 = 14;
parameter ADDR_WIDTH_100 = 13;
parameter ADDR_WIDTH_011 = 12;
parameter ADDR_WIDTH_010 = 11;
parameter ADDR_WIDTH_001 = 10;
parameter ADDR_WIDTH_000 = 9;


input clk;
input rst_n;
input apnpsf_en;

input [ADDR_WIDTH-1:0] address;
input [8:0] counter;
input [4:0] memtype;

output start,
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
       finish;
       
parameter INITIAL = 5'h00;
parameter START = 5'h12;
parameter G1_A1 = 5'h01;
parameter G1_A2 = 5'h02;
parameter G1_B1 = 5'h03;
parameter G1_B2 = 5'h04;
parameter G1_C1 = 5'h05;
parameter G1_C2 = 5'h06;
parameter G1_D1 = 5'h07;
parameter G1_D2 = 5'h08;
parameter G2_A1 = 5'h09;
parameter G2_A2 = 5'h0A;
parameter G2_B1 = 5'h0B;
parameter G2_B2 = 5'h0C;
parameter G2_C1 = 5'h0D;
parameter G2_C2 = 5'h0E;
parameter G2_D1 = 5'h0F;
parameter G2_D2 = 5'h10;
parameter FINISH = 5'h11;

wire clk;
wire rst_n;
wire apnpsf_en;
wire [ADDR_WIDTH-1:0] address;
wire [8:0] counter;
wire [4:0] memtype;

reg [4:0] apnpsf_state;
reg [4:0] next_apnpsf;
reg start, en1, en2, en3, en4, en5, en6, en7, en8, en9, en10, en11, en12, en13, en14, en15, en16, finish;

//APNPSF STATE MACHINE TO CONTROL
always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        apnpsf_state <= INITIAL;
    end
    else begin
        apnpsf_state <= next_apnpsf;
    end
end

//APNPSF STATE MACHINE
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        next_apnpsf <= INITIAL;
    end
    else begin
    case (apnpsf_state)
   
    INITIAL: begin
        if (apnpsf_en & (~finish)) begin
            next_apnpsf <= START;
        end
        else begin
            next_apnpsf <= INITIAL;
        end
    end

    START: begin
        if ((&address[ADDR_WIDTH-1:0])& (memtype[4:2] ==3'b111)) begin    // begin when 1101
            next_apnpsf <= G1_A1;
        end
        else if ((&address[ADDR_WIDTH_110-1:0])& (memtype[4:2] ==3'b110)) begin    // begin when 1101
            next_apnpsf <= G1_A1;
        end
        else if ((&address[ADDR_WIDTH_101-1:0])& (memtype[4:2] ==3'b101)) begin    // begin when 1101
            next_apnpsf <= G1_A1;
        end
        else if ((&address[ADDR_WIDTH_100-1:0])& (memtype[4:2] ==3'b100)) begin    // begin when 1101
            next_apnpsf <= G1_A1;
        end
        else if ((&address[ADDR_WIDTH_011-1:0])& (memtype[4:2] ==3'b011)) begin    // begin when 1101
            next_apnpsf <= G1_A1;
        end
        else if ((&address[ADDR_WIDTH_010-1:0])& (memtype[4:2] ==3'b010)) begin    // begin when 1101
            next_apnpsf <= G1_A1;
        end
        else if ((&address[ADDR_WIDTH_001-1:0])& (memtype[4:2] ==3'b001)) begin    // begin when 1101
            next_apnpsf <= G1_A1;
        end
        else if ((&address[ADDR_WIDTH_000-1:0])& (memtype[4:2] ==3'b000)) begin    // begin when 1101
            next_apnpsf <= G1_A1;
        end
        else begin
            next_apnpsf <= START;
        end
    end

    G1_A1: begin
        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_A2;        
        end
        else if (((&address[ADDR_WIDTH_110-1:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_A2;        
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_A2;        
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_A2;        
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_A2;        
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_A2;        
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_A2;        
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_A2;        
        end
        else begin
            next_apnpsf <= G1_A1;
        end
    end 
     
    G1_A2: begin
        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_B1;        
        end
        else if (((&address[ADDR_WIDTH_110-1:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_B1;        
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_B1;        
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_B1;        
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_B1;        
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_B1;        
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_B1;        
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_B1;        
        end
        else begin
            next_apnpsf <= G1_A2;
        end
    end  
    
    G1_B1: begin
        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_B2;        
        end
        else if (((&address[ADDR_WIDTH_110-1:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_B2;        
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_B2;        
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_B2;        
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_B2;        
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_B2;        
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_B2;        
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G1_B2;        
        end
        else begin
            next_apnpsf <= G1_B1;
        end
    end
    
    G1_B2: begin
        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_C1;        
        end
        else if (((&address[ADDR_WIDTH_110-1:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_C1;        
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_C1;        
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_C1;        
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_C1;        
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_C1;        
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_C1;        
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G1_C1;        
        end
        else begin
            next_apnpsf <= G1_B2;
        end
    end
    
    G1_C1: begin
        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_C2;        
        end
        else if (((&address[ADDR_WIDTH_110-1:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_C2;        
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_C2;        
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_C2;        
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_C2;        
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_C2;        
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_C2;        
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_C2;        
        end
        else begin
            next_apnpsf <= G1_C1;
        end
    end
    
    G1_C2: begin
        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G1_D1;        
        end
        else if (((&address[ADDR_WIDTH_110-1:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G1_D1;        
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G1_D1;        
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G1_D1;        
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G1_D1;        
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G1_D1;        
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G1_D1;        
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G1_D1;        
        end
        else begin
            next_apnpsf <= G1_C2;
        end
    end
	  
    G1_D1: begin
        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_D2;        
        end
        else if (((&address[ADDR_WIDTH_110-1:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_D2;        
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_D2;        
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_D2;        
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_D2;        
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_D2;        
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_D2;        
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G1_D2;        
        end
        else begin
            next_apnpsf <= G1_D1;
        end
    end
		
    G1_D2: begin
        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_A1;        
        end
        else if (((&address[ADDR_WIDTH_110-1:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_A1;        
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_A1;        
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_A1;        
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_A1;        
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_A1;        
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_A1;        
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_A1;        
        end
        else begin
            next_apnpsf <= G1_D2;
        end
    end
		
    G2_A1: begin
        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_A2;        
        end
        else if (((&address[ADDR_WIDTH_110-1:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_A2;        
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_A2;        
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_A2;        
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_A2;        
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_A2;        
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_A2;        
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_A2;        
        end
        else begin
            next_apnpsf <= G2_A1;
        end
    end
 
    G2_A2: begin
        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_B1;        
        end
        else if (((&address[ADDR_WIDTH_110-1:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_B1;        
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_B1;        
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_B1;        
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_B1;        
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_B1;        
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_B1;        
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_B1;        
        end
        else begin
            next_apnpsf <= G2_A2;
        end
    end
  
    G2_B1: begin
        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_B2;        
        end
        else if (((&address[ADDR_WIDTH_110-1:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_B2;        
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_B2;        
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_B2;        
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_B2;        
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_B2;        
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_B2;        
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b00) & (counter > 9'h19E)) begin   // begin when 1100 & 8'h90
            next_apnpsf <= G2_B2;        
        end
        else begin
            next_apnpsf <= G2_B1;
        end
    end
  
    G2_B2: begin
        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_C1;        
        end
        else if (((&address[ADDR_WIDTH_110-1:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_C1;        
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_C1;        
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_C1;        
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_C1;        
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_C1;        
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_C1;        
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b10) & (counter > 9'h19E)) begin   // begin when 1110 & 8'h90
            next_apnpsf <= G2_C1;        
        end
        else begin
            next_apnpsf <= G2_B2;
        end
    end  

    G2_C1: begin

        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_C2;        
        end
        else if (((&address[ADDR_WIDTH_110:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_C2;        
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_C2;        
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_C2;        
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_C2;        
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_C2;        
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_C2;        
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_C2;        
        end
        else begin
            next_apnpsf <= G2_C1;
        end
    end  

    G2_C2: begin
        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_D1;        
        end
        else if (((&address[ADDR_WIDTH_110-1:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_D1;        
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_D1;        
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_D1;        
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_D1;        
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_D1;        
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_D1;        
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= G2_D1;        
        end
        else begin
            next_apnpsf <= G2_C2;
        end
    end
  
    G2_D1: begin
        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_D2;        
        end
        else if (((&address[ADDR_WIDTH_110-1:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_D2;        
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_D2;        
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_D2;        
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_D2;        
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_D2;        
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_D2;        
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b01) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= G2_D2;        
        end
        else begin
            next_apnpsf <= G2_D1;
        end
	  end
	  
    G2_D2: begin
        if (((&address[ADDR_WIDTH-1:2])&(memtype[4:2]==3'b111)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= FINISH;        
        end
        else if (((&address[ADDR_WIDTH_110-1:2])&(memtype[4:2]==3'b110)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1101 & 8'h90
            next_apnpsf <= FINISH;       
        end
        else if (((&address[ADDR_WIDTH_101-1:2])&(memtype[4:2]==3'b101)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= FINISH;       
        end
        else if (((&address[ADDR_WIDTH_100-1:2])&(memtype[4:2]==3'b100)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= FINISH;       
        end
        else if (((&address[ADDR_WIDTH_011-1:2])&(memtype[4:2]==3'b011)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= FINISH;       
        end
        else if (((&address[ADDR_WIDTH_010-1:2])&(memtype[4:2]==3'b010)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= FINISH;       
        end
        else if (((&address[ADDR_WIDTH_001-1:2])&(memtype[4:2]==3'b001)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= FINISH;       
        end
        else if (((&address[ADDR_WIDTH_000-1:2])&(memtype[4:2]==3'b000)) & (address[1:0] == 2'b11) & (counter > 9'h19E)) begin   // begin when 1111 & 8'h90
            next_apnpsf <= FINISH;       
        end
        else begin
            next_apnpsf <= G2_D2;
        end
    end

    FINISH: begin
        if (finish) begin
            next_apnpsf <= INITIAL;    
        end    
        else begin
            next_apnpsf <= FINISH;
        end
    end
    
    endcase
    end
end

//APNPSF STATE MACHINE OUT
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;
    end
    else begin
    case (apnpsf_state)
  	
    INITIAL: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;
    end

    START: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b1;
   	    finish <= 1'b0;
    end
  	
    G1_A1: begin
        en1 <= 1'b1;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
        en9 <= 1'b0;
        en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;
    end
  	
    G1_A2: begin
        en1 <= 1'b0;
        en2 <= 1'b1;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;	
   	    finish <= 1'b0;
    end
  	
    G1_B1: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b1;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;
    end
  	
    G1_B2: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b1;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;  	   
    end
	   
    G1_C1: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b1;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;   
    end

    G1_C2: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b1;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;
    end

    G1_D1: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b1;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;
    end

    G1_D2: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b1;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;
    end

    G2_A1: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b1;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;
    end

    G2_A2: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b1;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;
    end

    G2_B1: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b1;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;
    end

    G2_B2: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b1;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;
    end

    G2_C1: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b1;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;
    end

    G2_C2: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b1;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;
    end

    G2_D1: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b1;
   	    en16 <= 1'b0;
   	    start <= 1'b0;
   	    finish <= 1'b0;
    end

    G2_D2: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b1;
   	    start <= 1'b0;
   	    finish <= 1'b0;
    end

    FINISH: begin
        en1 <= 1'b0;
        en2 <= 1'b0;
        en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    en6 <= 1'b0;
   	    en7 <= 1'b0;
   	    en8 <= 1'b0;
   	    en9 <= 1'b0;
   	    en10 <= 1'b0;
   	    en11 <= 1'b0;
   	    en12 <= 1'b0;
   	    en13 <= 1'b0;
   	    en14 <= 1'b0;
   	    en15 <= 1'b0;
   	    en16 <= 1'b0;
        start <= 1'b0;
        finish <= 1'b1;
    end

    endcase
    end
end
    
endmodule
