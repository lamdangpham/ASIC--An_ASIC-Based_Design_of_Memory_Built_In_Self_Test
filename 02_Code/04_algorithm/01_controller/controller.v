//`timescale 1ns/1ps
module controller (clk,
                  rst_n,
                  test_mode,
                  operation,
                  marchc_complete, 
                  marchc_en, 
                  marcha_complete, 
                  marcha_en, 
                  apnpsf_complete, 
                  apnpsf_en, 
                  complete);
//-------------------------------
input clk;
input rst_n;
input test_mode;
input [2:0]operation;
input marchc_complete; 
input marcha_complete; 
input apnpsf_complete; 
//-------------------------------
output complete;
output marchc_en; 
output marcha_en; 
output apnpsf_en; 
//-------------------------------
parameter INITIAL = 3'b00;
parameter SET_UP = 3'b01;
parameter MARCHC = 3'b010; 
parameter MARCHA = 3'b100; 
parameter APNPSF = 3'b011; 
//-----------------------------
wire clk;
wire rst_n;
wire test_mode;
wire [2:0]operation;
wire marchc_complete; 
wire marcha_complete; 
wire apnpsf_complete; 
wire complete;

reg marchc_en; 
reg marcha_en; 
reg apnpsf_en; 
reg [2:0] state;
reg [2:0] next_state;
//------------------------------------------------
assign complete = marchc_complete|apnpsf_complete | marcha_complete;
//-------------------------------------------------
//STATE MACHINE TO CONTROL
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        state <= INITIAL;
    end
    else begin
        state <= next_state;
    end
end
//---------------------------------------------------
//STATE MACHINE FOR ALGORITHM
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        next_state <= INITIAL;
    end
    else begin
    case (state)
    
    INITIAL: begin
        if (test_mode) begin
            next_state <= SET_UP;
        end
        else begin
            next_state <= INITIAL;
        end
    end
    SET_UP: begin
        if (operation == 3'b000) begin
            next_state <= MARCHC;
        end
        else if (operation == 3'b001)begin
            next_state <= APNPSF;
        end
        else if (operation == 3'b010)begin
            next_state <= MARCHA;
        end
        else begin
            next_state <= MARCHC;
        end
    end
    MARCHC: begin
        if (marchc_complete) begin
            next_state <= INITIAL;
        end
        else begin
            next_state <= MARCHC;
        end
    end
    MARCHA: begin
        if (marcha_complete) begin
            next_state <= INITIAL;
        end
        else begin
            next_state <= MARCHA;
        end
    end
    APNPSF: begin
        if (apnpsf_complete) begin
            next_state <= INITIAL;
        end
        else begin
            next_state <= APNPSF;
        end
    end
    
    endcase
    end
end
//---------------------------------------------------------
//STATE MACHINE OUT
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin 
        apnpsf_en <= 1'b0;
        marcha_en <= 1'b0;
        marchc_en <= 1'b0;
    end
    else begin
    case (state)
    INITIAL: begin
        apnpsf_en <= 1'b0;
        marcha_en <= 1'b0;
        marchc_en <= 1'b0;
    end
    SET_UP: begin
        apnpsf_en <= 1'b0;
        marcha_en <= 1'b0;
        marchc_en <= 1'b0;
    end
    MARCHC: begin
        apnpsf_en <= 1'b0;
        marchc_en <= 1'b1;
        marcha_en <= 1'b0;
    end
    MARCHA: begin
        apnpsf_en <= 1'b0;
        marchc_en <= 1'b0;
        marcha_en <= 1'b1;
    end
    APNPSF: begin
        apnpsf_en <= 1'b1;
        marchc_en <= 1'b0;
        marcha_en <= 1'b0;
    end

    endcase
    end
end

endmodule
