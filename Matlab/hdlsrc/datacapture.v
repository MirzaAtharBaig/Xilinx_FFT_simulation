
/*-- ----------------------------------------------
-- File Name: datacapture.v
-- Created:   12-Feb-2019 13:57:46
-- Copyright  2019 MathWorks, Inc.
-- ----------------------------------------------*/

module datacapture (
      clk,
      clk_enable,
      xfft_0_m_axis_data_tlast,
      xfft_0_event_data_in_channel_halt,
      xfft_0_m_axis_data_tdata,
      xfft_0_event_status_channel_halt,
      xfft_0_s_axis_data_tready,
      xfft_0_m_axis_data_tuser,
      xfft_0_event_frame_started,
      xfft_0_s_axis_config_tready,
      xfft_0_event_tlast_missing,
      dds_compiler_0_m_axis_data_tdata,
      xfft_0_m_axis_data_tvalid,
      m_axis_data_tdata,
      xfft_0_event_tlast_unexpected,
      xfft_0_event_data_out_channel_halt
);


      input     clk;
      input     clk_enable;
      input     xfft_0_m_axis_data_tlast;
      input     xfft_0_event_data_in_channel_halt;
      input    [15 : 0] xfft_0_m_axis_data_tdata;
      input     xfft_0_event_status_channel_halt;
      input     xfft_0_s_axis_data_tready;
      input    [15 : 0] xfft_0_m_axis_data_tuser;
      input     xfft_0_event_frame_started;
      input     xfft_0_s_axis_config_tready;
      input     xfft_0_event_tlast_missing;
      input    [7 : 0] dds_compiler_0_m_axis_data_tdata;
      input     xfft_0_m_axis_data_tvalid;
      input    [15 : 0] m_axis_data_tdata;
      input     xfft_0_event_tlast_unexpected;
      input     xfft_0_event_data_out_channel_halt;

  wire[71 : 0] all_data; // std72
  wire[5 : 0] pad_zero; // std6
  wire[100 : 0] trigger_setting; // std101
  wire trigger_1; // boolean
  wire start_flag; // boolean
  wire[100 : 0] trigger_setting_cond1; // std101
  wire[13 : 0] trigger_stage1; // std14
  wire[13 : 0] trigger_enable; // std14
  wire trigger_out1; // boolean
  wire[15 : 0] trigger_setting1; // std16
  wire trigger_out2; // boolean
  wire[2 : 0] trigger_setting2; // std3
  wire trigger_out3; // boolean
  wire[2 : 0] trigger_setting3; // std3
  wire trigger_out4; // boolean
  wire[2 : 0] trigger_setting4; // std3
  wire trigger_out5; // boolean
  wire[2 : 0] trigger_setting5; // std3
  wire trigger_out6; // boolean
  wire[2 : 0] trigger_setting6; // std3
  wire trigger_out7; // boolean
  wire[2 : 0] trigger_setting7; // std3
  wire trigger_out8; // boolean
  wire[2 : 0] trigger_setting8; // std3
  wire trigger_out9; // boolean
  wire[2 : 0] trigger_setting9; // std3
  wire trigger_out10; // boolean
  wire[15 : 0] trigger_setting10; // std16
  wire trigger_out11; // boolean
  wire[15 : 0] trigger_setting11; // std16
  wire trigger_out12; // boolean
  wire[2 : 0] trigger_setting12; // std3
  wire trigger_out13; // boolean
  wire[2 : 0] trigger_setting13; // std3
  wire trigger_out14; // boolean
  wire[7 : 0] trigger_setting14; // std8
  wire trigger_combine_rule; // boolean
hdlverifier_capture_core #(.DATA_WIDTH(72),.ADDR_WIDTH(11),.TRIG_WIDTH(101),.JTAG_ID(2)) u_hdlverifier_capture_core (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .start                (start_flag),
        .data                 (all_data),
        .trigger              (trigger_1),
        .trigger_setting      (trigger_setting)
);

hdlverifier_capture_trigger_condition u_hdlverifier_capture_trigger_condition (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .trigger              (trigger_1),
        .trigger_setting      (trigger_setting_cond1),
        .xfft_0_m_axis_data_tlast (xfft_0_m_axis_data_tlast),
        .xfft_0_event_data_in_channel_halt (xfft_0_event_data_in_channel_halt),
        .xfft_0_m_axis_data_tdata (xfft_0_m_axis_data_tdata),
        .xfft_0_event_status_channel_halt (xfft_0_event_status_channel_halt),
        .xfft_0_s_axis_data_tready (xfft_0_s_axis_data_tready),
        .xfft_0_m_axis_data_tuser (xfft_0_m_axis_data_tuser),
        .xfft_0_event_frame_started (xfft_0_event_frame_started),
        .xfft_0_s_axis_config_tready (xfft_0_s_axis_config_tready),
        .xfft_0_event_tlast_missing (xfft_0_event_tlast_missing),
        .dds_compiler_0_m_axis_data_tdata (dds_compiler_0_m_axis_data_tdata),
        .xfft_0_m_axis_data_tvalid (xfft_0_m_axis_data_tvalid),
        .m_axis_data_tdata    (m_axis_data_tdata),
        .xfft_0_event_tlast_unexpected (xfft_0_event_tlast_unexpected),
        .xfft_0_event_data_out_channel_halt (xfft_0_event_data_out_channel_halt)
);

assign all_data = {pad_zero,dds_compiler_0_m_axis_data_tdata,xfft_0_m_axis_data_tlast,xfft_0_m_axis_data_tvalid,xfft_0_m_axis_data_tuser,xfft_0_m_axis_data_tdata,xfft_0_event_frame_started,xfft_0_event_tlast_unexpected,xfft_0_event_tlast_missing,xfft_0_event_status_channel_halt,xfft_0_event_data_in_channel_halt,xfft_0_event_data_out_channel_halt,xfft_0_s_axis_data_tready,xfft_0_s_axis_config_tready,m_axis_data_tdata};
assign pad_zero = 6'b000000;
assign trigger_setting_cond1 = trigger_setting[100 : 0];

endmodule
