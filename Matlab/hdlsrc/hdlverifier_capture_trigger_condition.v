
/*-- ----------------------------------------------
-- File Name: hdlverifier_capture_trigger_condition.v
-- Created:   12-Feb-2019 13:57:46
-- Copyright  2019 MathWorks, Inc.
-- ----------------------------------------------*/

module hdlverifier_capture_trigger_condition (
      clk,
      clk_enable,
      trigger_setting,
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
      xfft_0_event_data_out_channel_halt,
      trigger
);


      input     clk;
      input     clk_enable;
      input    [100 : 0] trigger_setting;
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
      output    trigger;

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
hdlverifier_capture_comparator #(.WIDTH(16)) u_hdlverifier_capture_comparator (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .data                 (m_axis_data_tdata),
        .trigger              (trigger_out1),
        .trigger_setting      (trigger_setting1)
);

hdlverifier_capture_comparator_1bit u_hdlverifier_capture_comparator_1bit (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .data                 (xfft_0_s_axis_config_tready),
        .trigger              (trigger_out2),
        .trigger_mode         (trigger_setting2)
);

hdlverifier_capture_comparator_1bit u_hdlverifier_capture_comparator_1bit_inst1 (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .data                 (xfft_0_s_axis_data_tready),
        .trigger              (trigger_out3),
        .trigger_mode         (trigger_setting3)
);

hdlverifier_capture_comparator_1bit u_hdlverifier_capture_comparator_1bit_inst2 (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .data                 (xfft_0_event_data_out_channel_halt),
        .trigger              (trigger_out4),
        .trigger_mode         (trigger_setting4)
);

hdlverifier_capture_comparator_1bit u_hdlverifier_capture_comparator_1bit_inst3 (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .data                 (xfft_0_event_data_in_channel_halt),
        .trigger              (trigger_out5),
        .trigger_mode         (trigger_setting5)
);

hdlverifier_capture_comparator_1bit u_hdlverifier_capture_comparator_1bit_inst4 (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .data                 (xfft_0_event_status_channel_halt),
        .trigger              (trigger_out6),
        .trigger_mode         (trigger_setting6)
);

hdlverifier_capture_comparator_1bit u_hdlverifier_capture_comparator_1bit_inst5 (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .data                 (xfft_0_event_tlast_missing),
        .trigger              (trigger_out7),
        .trigger_mode         (trigger_setting7)
);

hdlverifier_capture_comparator_1bit u_hdlverifier_capture_comparator_1bit_inst6 (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .data                 (xfft_0_event_tlast_unexpected),
        .trigger              (trigger_out8),
        .trigger_mode         (trigger_setting8)
);

hdlverifier_capture_comparator_1bit u_hdlverifier_capture_comparator_1bit_inst7 (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .data                 (xfft_0_event_frame_started),
        .trigger              (trigger_out9),
        .trigger_mode         (trigger_setting9)
);

hdlverifier_capture_comparator #(.WIDTH(16)) u_hdlverifier_capture_comparator_inst1 (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .data                 (xfft_0_m_axis_data_tdata),
        .trigger              (trigger_out10),
        .trigger_setting      (trigger_setting10)
);

hdlverifier_capture_comparator #(.WIDTH(16)) u_hdlverifier_capture_comparator_inst2 (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .data                 (xfft_0_m_axis_data_tuser),
        .trigger              (trigger_out11),
        .trigger_setting      (trigger_setting11)
);

hdlverifier_capture_comparator_1bit u_hdlverifier_capture_comparator_1bit_inst8 (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .data                 (xfft_0_m_axis_data_tvalid),
        .trigger              (trigger_out12),
        .trigger_mode         (trigger_setting12)
);

hdlverifier_capture_comparator_1bit u_hdlverifier_capture_comparator_1bit_inst9 (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .data                 (xfft_0_m_axis_data_tlast),
        .trigger              (trigger_out13),
        .trigger_mode         (trigger_setting13)
);

hdlverifier_capture_comparator #(.WIDTH(8)) u_hdlverifier_capture_comparator_inst3 (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .data                 (dds_compiler_0_m_axis_data_tdata),
        .trigger              (trigger_out14),
        .trigger_setting      (trigger_setting14)
);

hdlverifier_capture_trigger_combine #(.WIDTH(14)) u_hdlverifier_capture_trigger_combine (
        .clk                  (clk),
        .clk_enable           (clk_enable),
        .trigger_in           (trigger_stage1),
        .trigger_enable       (trigger_enable),
        .trigger_out          (trigger),
        .trigger_combination_rule (trigger_combine_rule)
);

assign trigger_stage1 = {trigger_out1,trigger_out2,trigger_out3,trigger_out4,trigger_out5,trigger_out6,trigger_out7,trigger_out8,trigger_out9,trigger_out10,trigger_out11,trigger_out12,trigger_out13,trigger_out14};
assign trigger_enable = trigger_setting[99 : 86];
assign trigger_setting1 = trigger_setting[15 : 0];
assign trigger_setting2 = trigger_setting[18 : 16];
assign trigger_setting3 = trigger_setting[21 : 19];
assign trigger_setting4 = trigger_setting[24 : 22];
assign trigger_setting5 = trigger_setting[27 : 25];
assign trigger_setting6 = trigger_setting[30 : 28];
assign trigger_setting7 = trigger_setting[33 : 31];
assign trigger_setting8 = trigger_setting[36 : 34];
assign trigger_setting9 = trigger_setting[39 : 37];
assign trigger_setting10 = trigger_setting[55 : 40];
assign trigger_setting11 = trigger_setting[71 : 56];
assign trigger_setting12 = trigger_setting[74 : 72];
assign trigger_setting13 = trigger_setting[77 : 75];
assign trigger_setting14 = trigger_setting[85 : 78];
assign trigger_combine_rule = trigger_setting[100];

endmodule
