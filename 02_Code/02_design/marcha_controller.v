module marcha_controller (clk, rst_n, marcha_en, address, counter,
               start,
               en1,
               en2,
               en3,
               en4,
               finish);

//DEFINE PARAMETER
parameter ADDR_WIDTH = 16;

input clk;
input rst_n;
input marcha_en;
input [ADDR_WIDTH-1:0] address;
input [4:0] counter; 

output start;
output en1;
output en2;
output en3;
output en4;
output finish;

parameter RESET    = 4'b0000;
parameter INITIAL  = 4'b0001;
parameter MARCHC_0 = 4'b0010;
parameter MARCHC_1 = 4'b0011;
parameter MARCHC_2 = 4'b0100;
parameter MARCHC_3 = 4'b0101;
parameter MARCHC_4 = 4'b0110;
parameter FINISH   = 4'b0111;

wire clk;
wire rst_n;
wire marcha_en;
wire [ADDR_WIDTH-1:0] address;
wire [4:0] counter;

reg start;
reg en1;
reg en2;
reg en3;
reg en4;
reg finish;
wire [3:0] marcha_state;
reg [3:0] next_marcha;

//MARCHA STATE MACHINE TO CONTROL
/*always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        marchA_state <= RESET;
    end
    else begin
        marchA_state <= next_marchA;
    end
end*/
assign marcha_state = next_marcha;

//MARCHA STATE MACHINE
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        next_marcha <= RESET;
    end
    else begin
        case (marcha_state)

        RESET: begin
            if (marcha_en) begin
                next_marcha <= INITIAL;
            end
            else begin
                next_marcha <= RESET;
            end
        end

        INITIAL: begin
            if (marcha_en & (~finish)) begin
                next_marcha <= MARCHC_0;
            end
            else begin
                next_marcha <= INITIAL;
            end
        end

        MARCHC_0: begin
            if ((~|address) & (counter == 5'b00100)) begin    // enable at FFh at cc 4th
                next_marcha <= MARCHC_1;        
            end
            else begin
                if (next_marcha == MARCHC_1) begin
                    next_marcha <= MARCHC_1;
                end
                else begin    
                    next_marcha <= MARCHC_0;
                end
	           end
        end
      
        MARCHC_1: begin
            if ((&address) & (counter == 5'b01110)) begin    // enable at FFh at cc 14th & 15th
                next_marcha <= MARCHC_2;
            end
            else begin
                next_marcha <= MARCHC_1;
            end
        end
      
        MARCHC_2: begin
            if ((&address) & ((counter == 5'b01100) | (counter == 5'b01011))) begin    // enable at FFh at cc 14th & 15th
                next_marcha <= MARCHC_3;
            end
            else begin
                next_marcha <= MARCHC_2;
            end
         end
    
        MARCHC_3: begin
            if ((~|address) & (counter == 5'b01110)) begin   // enable at 00h at cc 14th & 15th
                next_marcha <= MARCHC_4;
            end
            else begin
                next_marcha <= MARCHC_3;
            end
        end
    
        MARCHC_4: begin
            if ((~|address) & ((counter == 5'b01100) | (counter == 5'b01011))) begin   // enable at 00h at cc 11th & 12th
                next_marcha <= FINISH;
            end
            else begin 
                next_marcha <= MARCHC_4;
            end
        end
      
        FINISH: begin
            if (finish) begin
                 next_marcha <= INITIAL;
	          end
	          else begin
	               next_marcha <= FINISH;
	          end
        end

        default: begin
            next_marcha <= INITIAL;
        end
        endcase
    end
end

//MARCHA STATE MACHINE OUT
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        start <= 1'b0;
        en1 <= 1'b0;
        en2 <= 1'b0;
   	    en3 <= 1'b0;
   	    en4 <= 1'b0;
        finish <= 1'b0;
    end
    else begin
    case (marcha_state)
  	
    INITIAL: begin
        start <= 1'b0;
        en1 <= 1'b0;
        en2 <= 1'b0;
   	    en3 <= 1'b0;
   	    en4 <= 1'b0;
    end

    MARCHC_0: begin
        start <= 1'b1;
        en1 <= 1'b0;
        en2 <= 1'b0;
   	    en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    finish <= 1'b0;
    end
  	
    MARCHC_1: begin
        start <= 1'b0;
        en1 <= 1'b1;
        en2 <= 1'b0;
   	    en3 <= 1'b0;
   	    en4 <= 1'b0;
   	    finish <= 1'b0;
    end
  	
    MARCHC_2: begin
        start <= 1'b0;
        en1 <= 1'b0;
        en2 <= 1'b1;
   	    en3 <= 1'b0;
   	    en4 <= 1'b0;
  	    finish <= 1'b0;
    end
  	
    MARCHC_3: begin
        start <= 1'b0;
        en1 <= 1'b0;
        en2 <= 1'b0;
   	    en3 <= 1'b1;
   	    en4 <= 1'b0;
   	    finish <= 1'b0;
 	   end
  	
    MARCHC_4: begin
        start <= 1'b0;
        en1 <= 1'b0;
        en2 <= 1'b0;
   	    en3 <= 1'b0;
   	    en4 <= 1'b1;
   	    finish <= 1'b0;
    end
  	
    FINISH: begin
        start <= 1'b0;
        en1 <= 1'b0;
        en2 <= 1'b0;
   	    en3 <= 1'b0;
   	    en4 <= 1'b0;
  	    finish <= 1'b1;
    end
  	
    endcase
    end
end

endmodule
