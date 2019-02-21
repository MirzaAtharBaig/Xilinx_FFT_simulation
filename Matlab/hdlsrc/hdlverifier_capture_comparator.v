
/*-- ----------------------------------------------
-- File Name: hdlverifier_capture_comparator.v
-- Created:   12-Feb-2019 13:57:46
-- Copyright  2019 MathWorks, Inc.
-- ----------------------------------------------*/


module hdlverifier_capture_comparator #(parameter WIDTH = 8) (
    input clk,
    input clk_enable,
    input [WIDTH-1:0] data,
    input [WIDTH-1:0] trigger_setting,
    output reg trigger);
    
    
    always@(posedge clk) begin
        if(clk_enable) begin
                trigger <=  (data == trigger_setting);
        end
    end
    
endmodule