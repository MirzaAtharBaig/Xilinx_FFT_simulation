
/*-- ----------------------------------------------
-- File Name: hdlverifier_capture_data.v
-- Created:   12-Feb-2019 13:57:45
-- Copyright  2019 MathWorks, Inc.
-- ----------------------------------------------*/

module hdlverifier_capture_data #(parameter DATA_WIDTH = 8,
                                            ADDR_WIDTH = 5)(
// Signals coming from user's design                              
    input clk,
    input clk_enable,
    input [DATA_WIDTH-1:0] data,
    input trigger,
    input [ADDR_WIDTH-1:0] trigger_pos,
    input [ADDR_WIDTH-1:0] window_size, // Real window size - 1
     
// Signals coming from JTAG controller, but in clk domain
    input reset,
    input run,
    input immediate,
    output flag_full,
    output has_clk,

// Signals interfacing with JTAG controller, but in tck domain
    input  tck,
    input  shift_out_state,
    input  shift_out_en,
    output shift_out_data
);

//localparam DEPTH = 2**ADDR_WIDTH;
localparam STATE_IDLE    = 3'd0,
           STATE_WTRIG   = 3'd1, // Wait for trigger
           STATE_CAPTURE_PRE = 3'd2, //fill data bedore trigger
           STATE_CAPTURE_POS = 3'd3, //fill data after trigger
           STATE_FULL    = 3'd4;
            
wire internal_trigger = trigger | immediate;
                
reg [ADDR_WIDTH-1:0] raddr;
reg [ADDR_WIDTH-1:0] waddr;
wire rd;
reg  wr;
wire [DATA_WIDTH-1:0] q;

reg [3:0] state_reg;
reg run_d1;
reg reg_full;
reg reg_clk;
reg [DATA_WIDTH-1:0] shift_reg;

reg [DATA_WIDTH-1:0] valid_count;

reg [15:0] bitcount;

reg [ADDR_WIDTH-1 : 0] pos_counter;
reg [ADDR_WIDTH-1 : 0] pre_counter;

reg capture_valid;

assign shift_out_data = shift_reg[0];

assign rd = 1'b1;

always@(*) begin
    wr <= (state_reg == STATE_CAPTURE_PRE && clk_enable) ? 1'b1:
                (state_reg == STATE_CAPTURE_POS && clk_enable) ? 1'b1:
                1'b0;
end
/*assign wr = (state_reg == STATE_CAPTURE_PRE && clk_enable) ? 1'b1:
                (state_reg == STATE_CAPTURE_POS && clk_enable) ? 1'b1:
                1'b0;*/
            
always@(posedge clk or posedge reset) begin
    if(reset) begin
        reg_full <= 1'b0;
        reg_clk  <= 1'b0;
    end
    else begin
        reg_full <= (state_reg ==  STATE_FULL);    
        reg_clk  <= 1'b1;
    end
end            

hdlverifier_synchronizer #(.WIDTH(1)) s1(
    .clk(tck),
    .data_in(reg_full),
    .data_out(flag_full)
);           
hdlverifier_synchronizer #(.WIDTH(1)) s2(
    .clk(tck),
    .data_in(reg_clk),
    .data_out(has_clk)
);  

always@(posedge clk) begin
    if(reset) begin
        state_reg <= STATE_IDLE;
        run_d1 <= 0;
          pos_counter <= 0;
          waddr <= 0;
    end
    else begin
        case(state_reg)
            STATE_IDLE: begin
                waddr <= 0;
                run_d1<= run;
                pos_counter <= 0;
                pre_counter <= 0;
                capture_valid  <= 1'b0;
                         
                if(!run_d1 && run)
                    state_reg <= STATE_CAPTURE_PRE;
                end
            STATE_CAPTURE_PRE: begin
                if(clk_enable) begin                          
                    waddr <= waddr + 1'b1;
                    
                    pre_counter <= pre_counter + 1'b1;
                    if(pre_counter >= trigger_pos) begin
                        capture_valid <= 1'b1;
                    end
                    
                    if(internal_trigger && capture_valid) begin                     
                        if(trigger_pos != 2**ADDR_WIDTH - 1'b1) begin
                            state_reg <= STATE_CAPTURE_POS;
                        end 
                        else begin
                            state_reg <= STATE_FULL;
                        end
                    end                    
                end
            end

            STATE_CAPTURE_POS: begin
                if(clk_enable) begin                    
                    waddr <= waddr + 1'b1;
                    if(pos_counter == 2**ADDR_WIDTH - trigger_pos - 2'b10)
                        state_reg <= STATE_FULL;
                    else
                        pos_counter <= pos_counter + 1'b1;                    
                end 
            end
                    
            STATE_FULL: begin
                if(!run) begin
                    state_reg <= STATE_IDLE;
                end
            end
            default: 
                state_reg <= STATE_IDLE;
        endcase
    end
end

always@(posedge tck or posedge reset) begin
    if(reset) begin
        bitcount <= 0;
        shift_reg <= 0;
    end
    else begin
        if(shift_out_state==1'b0) begin
                raddr <= waddr;
            bitcount <= 0;
            shift_reg <= 0;
        end
        else if(shift_out_en) begin
            if(bitcount == 0) begin
                     shift_reg <= {1'b0,shift_reg[DATA_WIDTH-1:1]};
                     bitcount <= bitcount + 1'b1;
            end
            else if(bitcount == 1) begin
                     bitcount <= bitcount + 1'b1; 
                shift_reg <= q;
            end
            else if(bitcount == DATA_WIDTH-1) begin
                bitcount <= 0;
                raddr <= raddr + 1'b1;
                     shift_reg <= {1'b0,shift_reg[DATA_WIDTH-1:1]};
                end
                else begin
                     bitcount <= bitcount + 1'b1; 
                     shift_reg <= {1'b0,shift_reg[DATA_WIDTH-1:1]};
            end
        end        
    end
end


hdlverifier_dcram #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) u_dcram(
    .wdata(data),
    .raddr(raddr),
    .waddr(waddr),
    .wr(wr),
    .rd(rd),
    .rclk(tck),
    .wclk(clk),
    .q(q));
    
 
endmodule