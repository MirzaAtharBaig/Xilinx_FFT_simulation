
/*-- ----------------------------------------------
-- File Name: hdlverifier_capture_comparator_1bit.v
-- Created:   12-Feb-2019 13:57:46
-- Copyright  2019 MathWorks, Inc.
-- ----------------------------------------------*/


module hdlverifier_capture_comparator_1bit (
    input clk,
    input clk_enable,
    input data,
    input [2:0] trigger_mode,
    output reg trigger);
    
    reg trigger_condition;
    reg data_d1;
    always@(*) begin
        if (trigger_mode == 3'b000 && !data)
            trigger_condition <= 1'b1;
        else if (trigger_mode == 3'b001 &&  data)
            trigger_condition <= 1'b1;
        else if (trigger_mode == 3'b010 && !data_d1 && data)
            trigger_condition <= 1'b1;
        else if (trigger_mode == 3'b011 && data_d1 && !data)
            trigger_condition <= 1'b1;
        else if (trigger_mode == 3'b100 && (data_d1 ^ data))
            trigger_condition <= 1'b1;
        else
            trigger_condition <= 1'b0;
    end
    
    always@(posedge clk) begin
        if(clk_enable) begin
            data_d1 <= data;
            trigger <= trigger_condition;
        end
    end
    
endmodule