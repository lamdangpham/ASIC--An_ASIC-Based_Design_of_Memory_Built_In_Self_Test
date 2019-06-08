//`timescale 1ns/1ps
module controller (clk,
                  rst_n,
                  test_mode,
                  operation,
//DECLEARE_MARCHC
//DECLEARE_MARCHA
//DECLEARE_APNPSF
                  complete);
//-------------------------------
input clk;
input rst_n;
input test_mode;
input [2:0]operation;
//COMPLETE_MARCHC_INPUT
//COMPLETE_MARCHA_INPUT
//COMPLETE_APNPSF_INPUT
//-------------------------------
output complete;
//ENABLE_MARCHC_OUTPUT
//ENABLE_MARCHA_OUTPUT
//ENABLE_APNPSF_OUTPUT
//-------------------------------
parameter INITIAL = 3'b00;
parameter SET_UP = 3'b01;
//PARAMETER_MARCHC
//PARAMETER_MARCHA
//PARAMETER_APNPSF
//-----------------------------
wire clk;
wire rst_n;
wire test_mode;
wire [2:0]operation;
//COMPLETE_MARCHC_WIRE
//COMPLETE_MARCHA_WIRE
//COMPLETE_APNPSF_WIRE
wire complete;

//ENABLE_MARCHC_REG
//ENABLE_MARCHA_REG
//ENABLE_APNPSF_REG
reg [2:0] state;
reg [2:0] next_state;
//------------------------------------------------
//ASSIGN_COMPLETE
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
//ASSIGN_SET_UP_STATE_ALGORITHM
//ASSIGN_MARCHC_STATE_ALGORITHM    
//ASSIGN_MARCHA_STATE_ALGORITHM    
//ASSIGN_APNPSF_STATE_ALGORITHM
    
    endcase
    end
end
//---------------------------------------------------------
//STATE MACHINE OUT
always @(posedge clk or negedge rst_n) begin
//ASSIGN_RESET_STATE_OUTPUT
    else begin
    case (state)
//ASSIGN_INITIAL_STATE_OUTPUT    
//ASSIGN_SET_UP_STATE_OUTPUT
//ASSIGN_MARCHC_STATE_OUTPUT  
//ASSIGN_MARCHA_STATE_OUTPUT  
//ASSIGN_APNPSF_STATE_OUTPUT  

    endcase
    end
end

endmodule
