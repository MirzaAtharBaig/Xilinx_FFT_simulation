
/*-- ----------------------------------------------
-- File Name: hdlverifier_capture_core.v
-- Created:   12-Feb-2019 13:57:45
-- Copyright  2019 MathWorks, Inc.
-- ----------------------------------------------*/


module hdlverifier_capture_core
    #(parameter DATA_WIDTH = 8,
                ADDR_WIDTH = 4,
                TRIG_WIDTH = 22,
                JTAG_ID=2)
(
    input  [DATA_WIDTH-1:0] data,
    output [TRIG_WIDTH-1:0] trigger_setting,
    output start,
    input trigger,
    input clk_enable,
    input clk
);

localparam [7:0] MAJOR_VER = 8'b1;
localparam [3:0] MINOR_VER = 4'b0;
localparam [3:0] APP_TYPE  = 4'b0; // Application type
localparam [4:0] ADDR_WPOW = ADDR_WIDTH;
localparam [10:0] DATA_WIDTH_BYTE = DATA_WIDTH/8;
localparam [31:0] CAPTURE_IP_ID0 = {DATA_WIDTH_BYTE, ADDR_WPOW, APP_TYPE, MAJOR_VER, MINOR_VER};


wire reset_tck;
reg  reset_clk;
wire tck;
wire [31:0] reg_rdata;
wire [31:0] reg_wdata;
wire reg_write;
wire [4:0]  reg_addr;
wire [31:0] user_data_out0;
wire [31:0] user_data_out1;
wire [31:0] user_data_out2;
wire [31:0] user_data_out3;
wire flag_full, has_clk;
wire shift_out_state;
wire shift_out_en;
wire shift_out_data;
wire shift_in_state;
wire shift_in_en;
wire shift_in_data; 
wire [ADDR_WIDTH-1:0] trigger_pos;
wire [ADDR_WIDTH-1:0] window_size;
wire [31:0] status_register;
reg [DATA_WIDTH-1:0] data_d1;
reg [DATA_WIDTH-1:0] data_d2;

reg reset_reg;
reg [19:0] trig_shift_counter;

reg [TRIG_WIDTH-1:0] trigger_shifter;
always@(posedge tck) begin
	if(shift_in_state == 1'b0) begin
		trig_shift_counter <= 0;
	end	
	if(shift_in_state && shift_in_en && trig_shift_counter<TRIG_WIDTH) begin
		trigger_shifter <= {trigger_shifter[TRIG_WIDTH-2:0], shift_in_data};
		trig_shift_counter <= trig_shift_counter + 1'b1;
	end
end

hdlverifier_synchronizer #(.WIDTH(TRIG_WIDTH)) sync_trigger(
	.data_in(trigger_shifter),
	.data_out(trigger_setting),
	.clk(clk));


hdlverifier_jtag_core #(.JTAG_ID(JTAG_ID)) u_jtag_core
(
    .tck(tck),
    .reset(reset_tck),
    .reg_rdata(reg_rdata),
    .reg_addr(reg_addr),
    .reg_wdata(reg_wdata),
    .reg_write(reg_write),
    .shift_out_state(shift_out_state),
    .shift_out_en(shift_out_en),
    .shift_out_data(shift_out_data),
    .shift_in_state(shift_in_state),
    .shift_in_en(shift_in_en),
    .shift_in_data(shift_in_data)   	 
);

always @ (posedge clk or posedge reset_tck) begin
    if (reset_tck) begin
        reset_reg <= 1'b1;
        reset_clk <= 1'b1;
    end 
    else begin
        reset_reg <= 1'b0;
        reset_clk <= reset_reg;
    end
end

hdlverifier_jtag_register register_manager(
    .tck(tck),
    .reset(reset_tck),
    .addr(reg_addr),
    .wdata(reg_wdata),
    .write(reg_write),
    .rdata(reg_rdata),
    .clk(clk),
    .user_data_in0(CAPTURE_IP_ID0),
    .user_data_in1(32'h200),
    .user_data_in2(status_register),
    .user_data_in3(32'hF00F),
    .user_data_out0(user_data_out0),
    .user_data_out1(user_data_out1),
    .user_data_out2(user_data_out2),
    .user_data_out3(user_data_out3));

assign status_register = {30'b0, has_clk, flag_full};

hdlverifier_synchronizer #(ADDR_WIDTH) u_sync_trig_pos(
    .data_in(user_data_out0[ADDR_WIDTH+3:4]),
    .data_out(trigger_pos),
    .clk(clk));
    
assign start = user_data_out0[0];
assign window_size = user_data_out1[ADDR_WIDTH-1:0];

// Delay input by two clock cycles to compensate delay
always@(posedge clk) begin
    if(clk_enable) begin
        data_d1 <= data;
        data_d2 <= data_d1;
    end
end

hdlverifier_capture_data #(.DATA_WIDTH(DATA_WIDTH),
                           .ADDR_WIDTH(ADDR_WIDTH)) 
u_capture(
    .clk(clk),
    .clk_enable(clk_enable),
    .data(data_d2),
    .trigger_pos(trigger_pos),
    .trigger(trigger),
    .window_size(window_size),
    .tck(tck),
    .reset(reset_clk),
    .run(user_data_out0[0]),
    .immediate(user_data_out0[1]),
    .has_clk(has_clk),
    .flag_full(flag_full),
    .shift_out_state(shift_out_state),
    .shift_out_en(shift_out_en),
    .shift_out_data(shift_out_data));

endmodule