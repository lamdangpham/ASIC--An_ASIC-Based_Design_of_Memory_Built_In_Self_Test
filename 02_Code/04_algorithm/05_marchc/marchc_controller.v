//`timescale 1ns/1ps
module marchc_controller (clk, rst_n, marchc_en, address,counter,
               start,
               en1,
               en2,
               en3,
               en4,
               en5,
               finish);


//DEFINE PARAMETER
parameter ADDR_WIDTH = 16;

input clk;
input rst_n;
input marchc_en;
input [ADDR_WIDTH-1:0] address;
input [3:0] counter; 

output start;
output en1;
output en2;
output en3;
output en4;
output en5;
output finish;

parameter RESET = 4'b0000;
parameter INITIAL = 4'b0001;
parameter MARCHC_0 = 4'b0010;
parameter MARCHC_1 = 4'b0011;
parameter MARCHC_2 = 4'b0100;
parameter MARCHC_3 = 4'b0101;
parameter MARCHC_4 = 4'b0110;
parameter MARCHC_5 = 4'b0111;
parameter FINISH = 4'b1000;

wire clk;
wire rst_n;
wire marchc_en;
wire [ADDR_WIDTH-1:0] address;
wire [3:0] counter;

reg start, en1, en2, en3, en4, en5, finish;
reg [3:0] marchc_state;
reg [3:0] next_marchc;

//MARCHC STATE MACHINE TO CONTROL
always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        marchc_state <= RESET;
    end
    else begin
        marchc_state <= next_marchc;
    end
end

//MARCHC STATE MACHINE
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        next_marchc <= RESET;
    end
    else begin
        case (marchc_state)

        RESET: begin
            if (marchc_en) begin
                next_marchc <= INITIAL;
            end
            else begin
                next_marchc <= RESET;
            end
        end

        INITIAL: begin
            if (marchc_en & (~finish)) begin
                next_marchc <= MARCHC_0;
            end
            else begin
                next_marchc <= INITIAL;
            end
        end

        MARCHC_0: begin
            if ((&address)& (counter == 4'b0100)) begin    // enable at FFh at cc 4th & 5th
                next_marchc <= MARCHC_1;        
            end
            else begin
                if (next_marchc == MARCHC_1) begin
                    next_marchc <= MARCHC_1;
                end
                else begin    
                    next_marchc <= MARCHC_0;
                end
	           end
        end
      
        MARCHC_1: begin
            if ((&address) & ((counter == 4'b0111) | (counter == 4'b1000))) begin    // enable at FFh at cc 4th & 5th
                next_marchc <= MARCHC_2;
            end
            else begin
                next_marchc <= MARCHC_1;
            end
        end
      
        MARCHC_2: begin
            if ((&address) & ((counter == 4'b0111) | (counter == 4'b1000))) begin    // enable at FFh at cc 4th & 5th
                next_marchc <= MARCHC_3;
            end
            else begin
                next_marchc <= MARCHC_2;
            end
         end
      
        MARCHC_3: begin
            if ((~|address) & ((counter == 4'b0111) | (counter == 4'b1000))) begin    // enable at 00h at cc 4th & 5th
                next_marchc <= MARCHC_4;
            end
            else begin
                next_marchc <= MARCHC_3;
            end
        end
    
        MARCHC_4: begin
            if ((~|address) & ((counter == 4'b0111) | (counter == 4'b1000))) begin    // enable at 00h at cc 4th & 5th
                next_marchc <= MARCHC_5;
            end
            else begin 
                next_marchc <= MARCHC_4;
            end
        end
      
        MARCHC_5: begin
            if ((&address) & (counter > 4'b0000)) begin    // enable at FFh at cc 2nd & 3rd
                next_marchc <= FINISH;
            end
            else begin 
                next_marchc <= MARCHC_5;
            end
        end
    	
        FINISH: begin
            if (finish) begin
                 next_marchc <= INITIAL;
	          end
	          else begin
	               next_marchc <= FINISH;
	          end
        end

        default: begin
            next_marchc <= INITIAL;
        end
        endcase
    end
end

//MARCHC STATE MACHINE OUT
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        start <= 1'b0;
        en1 <= 1'b0;
        en2 <= 1'b0;
   	    en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    finish <= 1'b0;
    end
    else begin
    case (marchc_state)
  	
    INITIAL: begin
        start <= 1'b0;
        en1 <= 1'b0;
        en2 <= 1'b0;
   	    en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	   // finish <= 1'b0;
    end

    MARCHC_0: begin
        start <= 1'b1;
        en1 <= 1'b0;
        en2 <= 1'b0;
   	    en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    finish <= 1'b0;
    end
  	
    MARCHC_1: begin
        start <= 1'b0;
        en1 <= 1'b1;
        en2 <= 1'b0;
   	    en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    finish <= 1'b0;
    end
  	
    MARCHC_2: begin
        start <= 1'b0;
        en1 <= 1'b0;
        en2 <= 1'b1;
   	    en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    finish <= 1'b0;
    end
  	
    MARCHC_3: begin
        start <= 1'b0;
        en1 <= 1'b0;
        en2 <= 1'b0;
   	    en3 <= 1'b1;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    finish <= 1'b0;
 	   end
  	
    MARCHC_4: begin
        start <= 1'b0;
        en1 <= 1'b0;
        en2 <= 1'b0;
   	    en3 <= 1'b0;
   	    en4 <= 1'b1;
   	    en5 <= 1'b0;
   	    finish <= 1'b0;
    end
  	
    MARCHC_5: begin
        start <= 1'b0;
        en1 <= 1'b0;
        en2 <= 1'b0;
   	    en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b1;
   	    finish <= 1'b0;
    end
  	
    FINISH: begin
        start <= 1'b0;
        en1 <= 1'b0;
        en2 <= 1'b0;
   	    en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    en5 <= 1'b0;
   	    finish <= 1'b1;
    end
  	
    endcase
    end
end

endmodule
