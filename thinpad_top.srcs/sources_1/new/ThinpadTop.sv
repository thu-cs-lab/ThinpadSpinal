// Generator : SpinalHDL v1.10.1    git head : 2527c7c6b0fb0f95e5e1a5722a0be732b364ce43
// Component : ThinpadTop
// Git hash  : ebf3e2e4d154ccb1a099e8a1bd2b2aa33a5488a2

`timescale 1ns/1ps

module ThinpadTop (
  input  wire          clk50M,
  input  wire          clk11M0592,
  input  wire          clockBtn,
  input  wire          resetBtn,
  input  wire [3:0]    touchBtn,
  input  wire [31:0]   dipSw,
  output wire [15:0]   leds,
  output wire [7:0]    dpy0,
  output wire [7:0]    dpy1,
  output wire          uartControlled_rdn,
  output wire          uartControlled_wrn,
  input  wire          uartControlled_dataReady,
  input  wire          uartControlled_tbre,
  input  wire          uartControlled_tsre,
  output wire [19:0]   baseRam_addr,
  output wire [3:0]    baseRam_beN,
  output wire          baseRam_ceN,
  output wire          baseRam_oeN,
  output wire          baseRam_weN,
  output wire [19:0]   extRam_addr,
  output wire [3:0]    extRam_beN,
  output wire          extRam_ceN,
  output wire          extRam_oeN,
  output wire          extRam_weN,
  output wire          uartRaw_txd,
  input  wire          uartRaw_rxd,
  output wire [22:0]   flash_a,
  output wire          flash_rpN,
  output wire          flash_vpen,
  output wire          flash_ceN,
  output wire          flash_oeN,
  output wire          flash_weN,
  output wire          flash_byteN,
  output wire          sl811_a0,
  output wire          sl811_wrN,
  output wire          sl811_rdN,
  output wire          sl811_csN,
  output wire          sl811_rstN,
  output wire          sl811_dAckN,
  input  wire          sl811_dRqN,
  input  wire          sl811_intRq,
  output wire          dm9k_cmd,
  output wire          dm9k_iowN,
  output wire          dm9k_iorN,
  output wire          dm9k_csN,
  output wire          dm9k_pwrstN,
  input  wire          dm9k_int,
  output wire          video_vSync,
  output wire          video_hSync,
  output wire          video_colorEn,
  output wire [2:0]    video_color_r,
  output wire [2:0]    video_color_g,
  output wire [1:0]    video_color_b,
  output wire          videoClk,
  inout  wire [31:0]   uartAndBaseRamData,
  inout  wire [31:0]   extRam_data,
  inout  wire [15:0]   flash_d,
  inout  wire [15:0]   usbAndNetworkData
);
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;

  wire       [3:0]    seg7Lut_2_io_iDig;
  wire       [3:0]    seg7Lut_3_io_iDig;
  wire       [2:0]    uartRawCtrl_io_config_frame_dataLength;
  wire       [0:0]    uartRawCtrl_io_config_frame_stop;
  wire       [1:0]    uartRawCtrl_io_config_frame_parity;
  wire       [19:0]   uartRawCtrl_io_config_clockDivider;
  wire                uartRawCtrl_io_writeBreak;
  wire       [7:0]    seg7Lut_2_io_oSeg;
  wire       [7:0]    seg7Lut_3_io_oSeg;
  wire                uartRawCtrl_io_write_ready;
  wire                uartRawCtrl_io_read_valid;
  wire       [7:0]    uartRawCtrl_io_read_payload;
  wire                uartRawCtrl_io_uart_txd;
  wire                vga800x600at75_io_hSync;
  wire                vga800x600at75_io_vSync;
  wire       [11:0]   vga800x600at75_io_hData;
  wire       [11:0]   vga800x600at75_io_vData;
  wire                vga800x600at75_io_colorEn;
  reg                 _zz_usbAndNetworkData;
  reg                 _zz_usbAndNetworkData_1;
  reg                 _zz_usbAndNetworkData_2;
  reg                 _zz_usbAndNetworkData_3;
  reg                 _zz_usbAndNetworkData_4;
  reg                 _zz_usbAndNetworkData_5;
  reg                 _zz_usbAndNetworkData_6;
  reg                 _zz_usbAndNetworkData_7;
  reg                 _zz_usbAndNetworkData_8;
  reg                 _zz_usbAndNetworkData_9;
  reg                 _zz_usbAndNetworkData_10;
  reg                 _zz_usbAndNetworkData_11;
  reg                 _zz_usbAndNetworkData_12;
  reg                 _zz_usbAndNetworkData_13;
  reg                 _zz_usbAndNetworkData_14;
  reg                 _zz_usbAndNetworkData_15;
  reg                 _zz_flash_d;
  reg                 _zz_flash_d_1;
  reg                 _zz_flash_d_2;
  reg                 _zz_flash_d_3;
  reg                 _zz_flash_d_4;
  reg                 _zz_flash_d_5;
  reg                 _zz_flash_d_6;
  reg                 _zz_flash_d_7;
  reg                 _zz_flash_d_8;
  reg                 _zz_flash_d_9;
  reg                 _zz_flash_d_10;
  reg                 _zz_flash_d_11;
  reg                 _zz_flash_d_12;
  reg                 _zz_flash_d_13;
  reg                 _zz_flash_d_14;
  reg                 _zz_flash_d_15;
  reg                 _zz_extRam_data;
  reg                 _zz_extRam_data_1;
  reg                 _zz_extRam_data_2;
  reg                 _zz_extRam_data_3;
  reg                 _zz_extRam_data_4;
  reg                 _zz_extRam_data_5;
  reg                 _zz_extRam_data_6;
  reg                 _zz_extRam_data_7;
  reg                 _zz_extRam_data_8;
  reg                 _zz_extRam_data_9;
  reg                 _zz_extRam_data_10;
  reg                 _zz_extRam_data_11;
  reg                 _zz_extRam_data_12;
  reg                 _zz_extRam_data_13;
  reg                 _zz_extRam_data_14;
  reg                 _zz_extRam_data_15;
  reg                 _zz_extRam_data_16;
  reg                 _zz_extRam_data_17;
  reg                 _zz_extRam_data_18;
  reg                 _zz_extRam_data_19;
  reg                 _zz_extRam_data_20;
  reg                 _zz_extRam_data_21;
  reg                 _zz_extRam_data_22;
  reg                 _zz_extRam_data_23;
  reg                 _zz_extRam_data_24;
  reg                 _zz_extRam_data_25;
  reg                 _zz_extRam_data_26;
  reg                 _zz_extRam_data_27;
  reg                 _zz_extRam_data_28;
  reg                 _zz_extRam_data_29;
  reg                 _zz_extRam_data_30;
  reg                 _zz_extRam_data_31;
  reg                 _zz_uartAndBaseRamData;
  reg                 _zz_uartAndBaseRamData_1;
  reg                 _zz_uartAndBaseRamData_2;
  reg                 _zz_uartAndBaseRamData_3;
  reg                 _zz_uartAndBaseRamData_4;
  reg                 _zz_uartAndBaseRamData_5;
  reg                 _zz_uartAndBaseRamData_6;
  reg                 _zz_uartAndBaseRamData_7;
  reg                 _zz_uartAndBaseRamData_8;
  reg                 _zz_uartAndBaseRamData_9;
  reg                 _zz_uartAndBaseRamData_10;
  reg                 _zz_uartAndBaseRamData_11;
  reg                 _zz_uartAndBaseRamData_12;
  reg                 _zz_uartAndBaseRamData_13;
  reg                 _zz_uartAndBaseRamData_14;
  reg                 _zz_uartAndBaseRamData_15;
  reg                 _zz_uartAndBaseRamData_16;
  reg                 _zz_uartAndBaseRamData_17;
  reg                 _zz_uartAndBaseRamData_18;
  reg                 _zz_uartAndBaseRamData_19;
  reg                 _zz_uartAndBaseRamData_20;
  reg                 _zz_uartAndBaseRamData_21;
  reg                 _zz_uartAndBaseRamData_22;
  reg                 _zz_uartAndBaseRamData_23;
  reg                 _zz_uartAndBaseRamData_24;
  reg                 _zz_uartAndBaseRamData_25;
  reg                 _zz_uartAndBaseRamData_26;
  reg                 _zz_uartAndBaseRamData_27;
  reg                 _zz_uartAndBaseRamData_28;
  reg                 _zz_uartAndBaseRamData_29;
  reg                 _zz_uartAndBaseRamData_30;
  reg                 _zz_uartAndBaseRamData_31;
  wire       [7:0]    number;
  reg        [15:0]   btnClockingArea_ledBits;
  wire                toplevel_uartRawCtrl_io_read_s2mPipe_valid;
  reg                 toplevel_uartRawCtrl_io_read_s2mPipe_ready;
  wire       [7:0]    toplevel_uartRawCtrl_io_read_s2mPipe_payload;
  reg                 toplevel_uartRawCtrl_io_read_rValidN;
  reg        [7:0]    toplevel_uartRawCtrl_io_read_rData;
  wire                toplevel_uartRawCtrl_io_read_s2mPipe_m2sPipe_valid;
  wire                toplevel_uartRawCtrl_io_read_s2mPipe_m2sPipe_ready;
  wire       [7:0]    toplevel_uartRawCtrl_io_read_s2mPipe_m2sPipe_payload;
  reg                 toplevel_uartRawCtrl_io_read_s2mPipe_rValid;
  reg        [7:0]    toplevel_uartRawCtrl_io_read_s2mPipe_rData;
  wire                when_Stream_l369;
  wire       [31:0]   _zz_when_InOutWrapper_l13;
  wire       [31:0]   _zz_uartAndBaseRamData_32;
  wire                when_InOutWrapper_l13;
  wire                when_InOutWrapper_l13_1;
  wire                when_InOutWrapper_l13_2;
  wire                when_InOutWrapper_l13_3;
  wire                when_InOutWrapper_l13_4;
  wire                when_InOutWrapper_l13_5;
  wire                when_InOutWrapper_l13_6;
  wire                when_InOutWrapper_l13_7;
  wire                when_InOutWrapper_l13_8;
  wire                when_InOutWrapper_l13_9;
  wire                when_InOutWrapper_l13_10;
  wire                when_InOutWrapper_l13_11;
  wire                when_InOutWrapper_l13_12;
  wire                when_InOutWrapper_l13_13;
  wire                when_InOutWrapper_l13_14;
  wire                when_InOutWrapper_l13_15;
  wire                when_InOutWrapper_l13_16;
  wire                when_InOutWrapper_l13_17;
  wire                when_InOutWrapper_l13_18;
  wire                when_InOutWrapper_l13_19;
  wire                when_InOutWrapper_l13_20;
  wire                when_InOutWrapper_l13_21;
  wire                when_InOutWrapper_l13_22;
  wire                when_InOutWrapper_l13_23;
  wire                when_InOutWrapper_l13_24;
  wire                when_InOutWrapper_l13_25;
  wire                when_InOutWrapper_l13_26;
  wire                when_InOutWrapper_l13_27;
  wire                when_InOutWrapper_l13_28;
  wire                when_InOutWrapper_l13_29;
  wire                when_InOutWrapper_l13_30;
  wire                when_InOutWrapper_l13_31;
  wire       [31:0]   _zz_when_InOutWrapper_l13_1;
  wire       [31:0]   _zz_extRam_data_32;
  wire                when_InOutWrapper_l13_32;
  wire                when_InOutWrapper_l13_33;
  wire                when_InOutWrapper_l13_34;
  wire                when_InOutWrapper_l13_35;
  wire                when_InOutWrapper_l13_36;
  wire                when_InOutWrapper_l13_37;
  wire                when_InOutWrapper_l13_38;
  wire                when_InOutWrapper_l13_39;
  wire                when_InOutWrapper_l13_40;
  wire                when_InOutWrapper_l13_41;
  wire                when_InOutWrapper_l13_42;
  wire                when_InOutWrapper_l13_43;
  wire                when_InOutWrapper_l13_44;
  wire                when_InOutWrapper_l13_45;
  wire                when_InOutWrapper_l13_46;
  wire                when_InOutWrapper_l13_47;
  wire                when_InOutWrapper_l13_48;
  wire                when_InOutWrapper_l13_49;
  wire                when_InOutWrapper_l13_50;
  wire                when_InOutWrapper_l13_51;
  wire                when_InOutWrapper_l13_52;
  wire                when_InOutWrapper_l13_53;
  wire                when_InOutWrapper_l13_54;
  wire                when_InOutWrapper_l13_55;
  wire                when_InOutWrapper_l13_56;
  wire                when_InOutWrapper_l13_57;
  wire                when_InOutWrapper_l13_58;
  wire                when_InOutWrapper_l13_59;
  wire                when_InOutWrapper_l13_60;
  wire                when_InOutWrapper_l13_61;
  wire                when_InOutWrapper_l13_62;
  wire                when_InOutWrapper_l13_63;
  wire       [15:0]   _zz_when_InOutWrapper_l13_2;
  wire       [15:0]   _zz_flash_d_16;
  wire                when_InOutWrapper_l13_64;
  wire                when_InOutWrapper_l13_65;
  wire                when_InOutWrapper_l13_66;
  wire                when_InOutWrapper_l13_67;
  wire                when_InOutWrapper_l13_68;
  wire                when_InOutWrapper_l13_69;
  wire                when_InOutWrapper_l13_70;
  wire                when_InOutWrapper_l13_71;
  wire                when_InOutWrapper_l13_72;
  wire                when_InOutWrapper_l13_73;
  wire                when_InOutWrapper_l13_74;
  wire                when_InOutWrapper_l13_75;
  wire                when_InOutWrapper_l13_76;
  wire                when_InOutWrapper_l13_77;
  wire                when_InOutWrapper_l13_78;
  wire                when_InOutWrapper_l13_79;
  wire       [15:0]   _zz_when_InOutWrapper_l13_3;
  wire       [15:0]   _zz_usbAndNetworkData_16;
  wire                when_InOutWrapper_l13_80;
  wire                when_InOutWrapper_l13_81;
  wire                when_InOutWrapper_l13_82;
  wire                when_InOutWrapper_l13_83;
  wire                when_InOutWrapper_l13_84;
  wire                when_InOutWrapper_l13_85;
  wire                when_InOutWrapper_l13_86;
  wire                when_InOutWrapper_l13_87;
  wire                when_InOutWrapper_l13_88;
  wire                when_InOutWrapper_l13_89;
  wire                when_InOutWrapper_l13_90;
  wire                when_InOutWrapper_l13_91;
  wire                when_InOutWrapper_l13_92;
  wire                when_InOutWrapper_l13_93;
  wire                when_InOutWrapper_l13_94;
  wire                when_InOutWrapper_l13_95;

  pll_example clockGen (
    .clkIn (clk50M  ), //i
    .reset (resetBtn)  //i
  );
  Seg7Lut seg7Lut_2 (
    .io_iDig  (seg7Lut_2_io_iDig[3:0]), //i
    .io_oSeg  (seg7Lut_2_io_oSeg[7:0]), //o
    .clk50M   (clk50M                ), //i
    .resetBtn (resetBtn              )  //i
  );
  Seg7Lut seg7Lut_3 (
    .io_iDig  (seg7Lut_3_io_iDig[3:0]), //i
    .io_oSeg  (seg7Lut_3_io_oSeg[7:0]), //o
    .clk50M   (clk50M                ), //i
    .resetBtn (resetBtn              )  //i
  );
  UartCtrl uartRawCtrl (
    .io_config_frame_dataLength (uartRawCtrl_io_config_frame_dataLength[2:0]              ), //i
    .io_config_frame_stop       (uartRawCtrl_io_config_frame_stop                         ), //i
    .io_config_frame_parity     (uartRawCtrl_io_config_frame_parity[1:0]                  ), //i
    .io_config_clockDivider     (uartRawCtrl_io_config_clockDivider[19:0]                 ), //i
    .io_write_valid             (toplevel_uartRawCtrl_io_read_s2mPipe_m2sPipe_valid       ), //i
    .io_write_ready             (uartRawCtrl_io_write_ready                               ), //o
    .io_write_payload           (toplevel_uartRawCtrl_io_read_s2mPipe_m2sPipe_payload[7:0]), //i
    .io_read_valid              (uartRawCtrl_io_read_valid                                ), //o
    .io_read_ready              (toplevel_uartRawCtrl_io_read_rValidN                     ), //i
    .io_read_payload            (uartRawCtrl_io_read_payload[7:0]                         ), //o
    .io_uart_txd                (uartRawCtrl_io_uart_txd                                  ), //o
    .io_uart_rxd                (uartRaw_rxd                                              ), //i
    .io_writeBreak              (uartRawCtrl_io_writeBreak                                ), //i
    .clk50M                     (clk50M                                                   ), //i
    .resetBtn                   (resetBtn                                                 )  //i
  );
  VgaExample vga800x600at75 (
    .io_hSync   (vga800x600at75_io_hSync      ), //o
    .io_vSync   (vga800x600at75_io_vSync      ), //o
    .io_hData   (vga800x600at75_io_hData[11:0]), //o
    .io_vData   (vga800x600at75_io_vData[11:0]), //o
    .io_colorEn (vga800x600at75_io_colorEn    ), //o
    .clk50M     (clk50M                       ), //i
    .resetBtn   (resetBtn                     )  //i
  );
  assign uartAndBaseRamData[0] = _zz_uartAndBaseRamData_31 ? _zz_uartAndBaseRamData_32[0] : 1'bz;
  assign uartAndBaseRamData[1] = _zz_uartAndBaseRamData_30 ? _zz_uartAndBaseRamData_32[1] : 1'bz;
  assign uartAndBaseRamData[2] = _zz_uartAndBaseRamData_29 ? _zz_uartAndBaseRamData_32[2] : 1'bz;
  assign uartAndBaseRamData[3] = _zz_uartAndBaseRamData_28 ? _zz_uartAndBaseRamData_32[3] : 1'bz;
  assign uartAndBaseRamData[4] = _zz_uartAndBaseRamData_27 ? _zz_uartAndBaseRamData_32[4] : 1'bz;
  assign uartAndBaseRamData[5] = _zz_uartAndBaseRamData_26 ? _zz_uartAndBaseRamData_32[5] : 1'bz;
  assign uartAndBaseRamData[6] = _zz_uartAndBaseRamData_25 ? _zz_uartAndBaseRamData_32[6] : 1'bz;
  assign uartAndBaseRamData[7] = _zz_uartAndBaseRamData_24 ? _zz_uartAndBaseRamData_32[7] : 1'bz;
  assign uartAndBaseRamData[8] = _zz_uartAndBaseRamData_23 ? _zz_uartAndBaseRamData_32[8] : 1'bz;
  assign uartAndBaseRamData[9] = _zz_uartAndBaseRamData_22 ? _zz_uartAndBaseRamData_32[9] : 1'bz;
  assign uartAndBaseRamData[10] = _zz_uartAndBaseRamData_21 ? _zz_uartAndBaseRamData_32[10] : 1'bz;
  assign uartAndBaseRamData[11] = _zz_uartAndBaseRamData_20 ? _zz_uartAndBaseRamData_32[11] : 1'bz;
  assign uartAndBaseRamData[12] = _zz_uartAndBaseRamData_19 ? _zz_uartAndBaseRamData_32[12] : 1'bz;
  assign uartAndBaseRamData[13] = _zz_uartAndBaseRamData_18 ? _zz_uartAndBaseRamData_32[13] : 1'bz;
  assign uartAndBaseRamData[14] = _zz_uartAndBaseRamData_17 ? _zz_uartAndBaseRamData_32[14] : 1'bz;
  assign uartAndBaseRamData[15] = _zz_uartAndBaseRamData_16 ? _zz_uartAndBaseRamData_32[15] : 1'bz;
  assign uartAndBaseRamData[16] = _zz_uartAndBaseRamData_15 ? _zz_uartAndBaseRamData_32[16] : 1'bz;
  assign uartAndBaseRamData[17] = _zz_uartAndBaseRamData_14 ? _zz_uartAndBaseRamData_32[17] : 1'bz;
  assign uartAndBaseRamData[18] = _zz_uartAndBaseRamData_13 ? _zz_uartAndBaseRamData_32[18] : 1'bz;
  assign uartAndBaseRamData[19] = _zz_uartAndBaseRamData_12 ? _zz_uartAndBaseRamData_32[19] : 1'bz;
  assign uartAndBaseRamData[20] = _zz_uartAndBaseRamData_11 ? _zz_uartAndBaseRamData_32[20] : 1'bz;
  assign uartAndBaseRamData[21] = _zz_uartAndBaseRamData_10 ? _zz_uartAndBaseRamData_32[21] : 1'bz;
  assign uartAndBaseRamData[22] = _zz_uartAndBaseRamData_9 ? _zz_uartAndBaseRamData_32[22] : 1'bz;
  assign uartAndBaseRamData[23] = _zz_uartAndBaseRamData_8 ? _zz_uartAndBaseRamData_32[23] : 1'bz;
  assign uartAndBaseRamData[24] = _zz_uartAndBaseRamData_7 ? _zz_uartAndBaseRamData_32[24] : 1'bz;
  assign uartAndBaseRamData[25] = _zz_uartAndBaseRamData_6 ? _zz_uartAndBaseRamData_32[25] : 1'bz;
  assign uartAndBaseRamData[26] = _zz_uartAndBaseRamData_5 ? _zz_uartAndBaseRamData_32[26] : 1'bz;
  assign uartAndBaseRamData[27] = _zz_uartAndBaseRamData_4 ? _zz_uartAndBaseRamData_32[27] : 1'bz;
  assign uartAndBaseRamData[28] = _zz_uartAndBaseRamData_3 ? _zz_uartAndBaseRamData_32[28] : 1'bz;
  assign uartAndBaseRamData[29] = _zz_uartAndBaseRamData_2 ? _zz_uartAndBaseRamData_32[29] : 1'bz;
  assign uartAndBaseRamData[30] = _zz_uartAndBaseRamData_1 ? _zz_uartAndBaseRamData_32[30] : 1'bz;
  assign uartAndBaseRamData[31] = _zz_uartAndBaseRamData ? _zz_uartAndBaseRamData_32[31] : 1'bz;
  assign extRam_data[0] = _zz_extRam_data_31 ? _zz_extRam_data_32[0] : 1'bz;
  assign extRam_data[1] = _zz_extRam_data_30 ? _zz_extRam_data_32[1] : 1'bz;
  assign extRam_data[2] = _zz_extRam_data_29 ? _zz_extRam_data_32[2] : 1'bz;
  assign extRam_data[3] = _zz_extRam_data_28 ? _zz_extRam_data_32[3] : 1'bz;
  assign extRam_data[4] = _zz_extRam_data_27 ? _zz_extRam_data_32[4] : 1'bz;
  assign extRam_data[5] = _zz_extRam_data_26 ? _zz_extRam_data_32[5] : 1'bz;
  assign extRam_data[6] = _zz_extRam_data_25 ? _zz_extRam_data_32[6] : 1'bz;
  assign extRam_data[7] = _zz_extRam_data_24 ? _zz_extRam_data_32[7] : 1'bz;
  assign extRam_data[8] = _zz_extRam_data_23 ? _zz_extRam_data_32[8] : 1'bz;
  assign extRam_data[9] = _zz_extRam_data_22 ? _zz_extRam_data_32[9] : 1'bz;
  assign extRam_data[10] = _zz_extRam_data_21 ? _zz_extRam_data_32[10] : 1'bz;
  assign extRam_data[11] = _zz_extRam_data_20 ? _zz_extRam_data_32[11] : 1'bz;
  assign extRam_data[12] = _zz_extRam_data_19 ? _zz_extRam_data_32[12] : 1'bz;
  assign extRam_data[13] = _zz_extRam_data_18 ? _zz_extRam_data_32[13] : 1'bz;
  assign extRam_data[14] = _zz_extRam_data_17 ? _zz_extRam_data_32[14] : 1'bz;
  assign extRam_data[15] = _zz_extRam_data_16 ? _zz_extRam_data_32[15] : 1'bz;
  assign extRam_data[16] = _zz_extRam_data_15 ? _zz_extRam_data_32[16] : 1'bz;
  assign extRam_data[17] = _zz_extRam_data_14 ? _zz_extRam_data_32[17] : 1'bz;
  assign extRam_data[18] = _zz_extRam_data_13 ? _zz_extRam_data_32[18] : 1'bz;
  assign extRam_data[19] = _zz_extRam_data_12 ? _zz_extRam_data_32[19] : 1'bz;
  assign extRam_data[20] = _zz_extRam_data_11 ? _zz_extRam_data_32[20] : 1'bz;
  assign extRam_data[21] = _zz_extRam_data_10 ? _zz_extRam_data_32[21] : 1'bz;
  assign extRam_data[22] = _zz_extRam_data_9 ? _zz_extRam_data_32[22] : 1'bz;
  assign extRam_data[23] = _zz_extRam_data_8 ? _zz_extRam_data_32[23] : 1'bz;
  assign extRam_data[24] = _zz_extRam_data_7 ? _zz_extRam_data_32[24] : 1'bz;
  assign extRam_data[25] = _zz_extRam_data_6 ? _zz_extRam_data_32[25] : 1'bz;
  assign extRam_data[26] = _zz_extRam_data_5 ? _zz_extRam_data_32[26] : 1'bz;
  assign extRam_data[27] = _zz_extRam_data_4 ? _zz_extRam_data_32[27] : 1'bz;
  assign extRam_data[28] = _zz_extRam_data_3 ? _zz_extRam_data_32[28] : 1'bz;
  assign extRam_data[29] = _zz_extRam_data_2 ? _zz_extRam_data_32[29] : 1'bz;
  assign extRam_data[30] = _zz_extRam_data_1 ? _zz_extRam_data_32[30] : 1'bz;
  assign extRam_data[31] = _zz_extRam_data ? _zz_extRam_data_32[31] : 1'bz;
  assign flash_d[0] = _zz_flash_d_15 ? _zz_flash_d_16[0] : 1'bz;
  assign flash_d[1] = _zz_flash_d_14 ? _zz_flash_d_16[1] : 1'bz;
  assign flash_d[2] = _zz_flash_d_13 ? _zz_flash_d_16[2] : 1'bz;
  assign flash_d[3] = _zz_flash_d_12 ? _zz_flash_d_16[3] : 1'bz;
  assign flash_d[4] = _zz_flash_d_11 ? _zz_flash_d_16[4] : 1'bz;
  assign flash_d[5] = _zz_flash_d_10 ? _zz_flash_d_16[5] : 1'bz;
  assign flash_d[6] = _zz_flash_d_9 ? _zz_flash_d_16[6] : 1'bz;
  assign flash_d[7] = _zz_flash_d_8 ? _zz_flash_d_16[7] : 1'bz;
  assign flash_d[8] = _zz_flash_d_7 ? _zz_flash_d_16[8] : 1'bz;
  assign flash_d[9] = _zz_flash_d_6 ? _zz_flash_d_16[9] : 1'bz;
  assign flash_d[10] = _zz_flash_d_5 ? _zz_flash_d_16[10] : 1'bz;
  assign flash_d[11] = _zz_flash_d_4 ? _zz_flash_d_16[11] : 1'bz;
  assign flash_d[12] = _zz_flash_d_3 ? _zz_flash_d_16[12] : 1'bz;
  assign flash_d[13] = _zz_flash_d_2 ? _zz_flash_d_16[13] : 1'bz;
  assign flash_d[14] = _zz_flash_d_1 ? _zz_flash_d_16[14] : 1'bz;
  assign flash_d[15] = _zz_flash_d ? _zz_flash_d_16[15] : 1'bz;
  assign usbAndNetworkData[0] = _zz_usbAndNetworkData_15 ? _zz_usbAndNetworkData_16[0] : 1'bz;
  assign usbAndNetworkData[1] = _zz_usbAndNetworkData_14 ? _zz_usbAndNetworkData_16[1] : 1'bz;
  assign usbAndNetworkData[2] = _zz_usbAndNetworkData_13 ? _zz_usbAndNetworkData_16[2] : 1'bz;
  assign usbAndNetworkData[3] = _zz_usbAndNetworkData_12 ? _zz_usbAndNetworkData_16[3] : 1'bz;
  assign usbAndNetworkData[4] = _zz_usbAndNetworkData_11 ? _zz_usbAndNetworkData_16[4] : 1'bz;
  assign usbAndNetworkData[5] = _zz_usbAndNetworkData_10 ? _zz_usbAndNetworkData_16[5] : 1'bz;
  assign usbAndNetworkData[6] = _zz_usbAndNetworkData_9 ? _zz_usbAndNetworkData_16[6] : 1'bz;
  assign usbAndNetworkData[7] = _zz_usbAndNetworkData_8 ? _zz_usbAndNetworkData_16[7] : 1'bz;
  assign usbAndNetworkData[8] = _zz_usbAndNetworkData_7 ? _zz_usbAndNetworkData_16[8] : 1'bz;
  assign usbAndNetworkData[9] = _zz_usbAndNetworkData_6 ? _zz_usbAndNetworkData_16[9] : 1'bz;
  assign usbAndNetworkData[10] = _zz_usbAndNetworkData_5 ? _zz_usbAndNetworkData_16[10] : 1'bz;
  assign usbAndNetworkData[11] = _zz_usbAndNetworkData_4 ? _zz_usbAndNetworkData_16[11] : 1'bz;
  assign usbAndNetworkData[12] = _zz_usbAndNetworkData_3 ? _zz_usbAndNetworkData_16[12] : 1'bz;
  assign usbAndNetworkData[13] = _zz_usbAndNetworkData_2 ? _zz_usbAndNetworkData_16[13] : 1'bz;
  assign usbAndNetworkData[14] = _zz_usbAndNetworkData_1 ? _zz_usbAndNetworkData_16[14] : 1'bz;
  assign usbAndNetworkData[15] = _zz_usbAndNetworkData ? _zz_usbAndNetworkData_16[15] : 1'bz;
  always @(*) begin
    _zz_usbAndNetworkData = 1'b0;
    if(when_InOutWrapper_l13_95) begin
      _zz_usbAndNetworkData = 1'b1;
    end
  end

  always @(*) begin
    _zz_usbAndNetworkData_1 = 1'b0;
    if(when_InOutWrapper_l13_94) begin
      _zz_usbAndNetworkData_1 = 1'b1;
    end
  end

  always @(*) begin
    _zz_usbAndNetworkData_2 = 1'b0;
    if(when_InOutWrapper_l13_93) begin
      _zz_usbAndNetworkData_2 = 1'b1;
    end
  end

  always @(*) begin
    _zz_usbAndNetworkData_3 = 1'b0;
    if(when_InOutWrapper_l13_92) begin
      _zz_usbAndNetworkData_3 = 1'b1;
    end
  end

  always @(*) begin
    _zz_usbAndNetworkData_4 = 1'b0;
    if(when_InOutWrapper_l13_91) begin
      _zz_usbAndNetworkData_4 = 1'b1;
    end
  end

  always @(*) begin
    _zz_usbAndNetworkData_5 = 1'b0;
    if(when_InOutWrapper_l13_90) begin
      _zz_usbAndNetworkData_5 = 1'b1;
    end
  end

  always @(*) begin
    _zz_usbAndNetworkData_6 = 1'b0;
    if(when_InOutWrapper_l13_89) begin
      _zz_usbAndNetworkData_6 = 1'b1;
    end
  end

  always @(*) begin
    _zz_usbAndNetworkData_7 = 1'b0;
    if(when_InOutWrapper_l13_88) begin
      _zz_usbAndNetworkData_7 = 1'b1;
    end
  end

  always @(*) begin
    _zz_usbAndNetworkData_8 = 1'b0;
    if(when_InOutWrapper_l13_87) begin
      _zz_usbAndNetworkData_8 = 1'b1;
    end
  end

  always @(*) begin
    _zz_usbAndNetworkData_9 = 1'b0;
    if(when_InOutWrapper_l13_86) begin
      _zz_usbAndNetworkData_9 = 1'b1;
    end
  end

  always @(*) begin
    _zz_usbAndNetworkData_10 = 1'b0;
    if(when_InOutWrapper_l13_85) begin
      _zz_usbAndNetworkData_10 = 1'b1;
    end
  end

  always @(*) begin
    _zz_usbAndNetworkData_11 = 1'b0;
    if(when_InOutWrapper_l13_84) begin
      _zz_usbAndNetworkData_11 = 1'b1;
    end
  end

  always @(*) begin
    _zz_usbAndNetworkData_12 = 1'b0;
    if(when_InOutWrapper_l13_83) begin
      _zz_usbAndNetworkData_12 = 1'b1;
    end
  end

  always @(*) begin
    _zz_usbAndNetworkData_13 = 1'b0;
    if(when_InOutWrapper_l13_82) begin
      _zz_usbAndNetworkData_13 = 1'b1;
    end
  end

  always @(*) begin
    _zz_usbAndNetworkData_14 = 1'b0;
    if(when_InOutWrapper_l13_81) begin
      _zz_usbAndNetworkData_14 = 1'b1;
    end
  end

  always @(*) begin
    _zz_usbAndNetworkData_15 = 1'b0;
    if(when_InOutWrapper_l13_80) begin
      _zz_usbAndNetworkData_15 = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d = 1'b0;
    if(when_InOutWrapper_l13_79) begin
      _zz_flash_d = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d_1 = 1'b0;
    if(when_InOutWrapper_l13_78) begin
      _zz_flash_d_1 = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d_2 = 1'b0;
    if(when_InOutWrapper_l13_77) begin
      _zz_flash_d_2 = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d_3 = 1'b0;
    if(when_InOutWrapper_l13_76) begin
      _zz_flash_d_3 = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d_4 = 1'b0;
    if(when_InOutWrapper_l13_75) begin
      _zz_flash_d_4 = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d_5 = 1'b0;
    if(when_InOutWrapper_l13_74) begin
      _zz_flash_d_5 = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d_6 = 1'b0;
    if(when_InOutWrapper_l13_73) begin
      _zz_flash_d_6 = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d_7 = 1'b0;
    if(when_InOutWrapper_l13_72) begin
      _zz_flash_d_7 = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d_8 = 1'b0;
    if(when_InOutWrapper_l13_71) begin
      _zz_flash_d_8 = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d_9 = 1'b0;
    if(when_InOutWrapper_l13_70) begin
      _zz_flash_d_9 = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d_10 = 1'b0;
    if(when_InOutWrapper_l13_69) begin
      _zz_flash_d_10 = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d_11 = 1'b0;
    if(when_InOutWrapper_l13_68) begin
      _zz_flash_d_11 = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d_12 = 1'b0;
    if(when_InOutWrapper_l13_67) begin
      _zz_flash_d_12 = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d_13 = 1'b0;
    if(when_InOutWrapper_l13_66) begin
      _zz_flash_d_13 = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d_14 = 1'b0;
    if(when_InOutWrapper_l13_65) begin
      _zz_flash_d_14 = 1'b1;
    end
  end

  always @(*) begin
    _zz_flash_d_15 = 1'b0;
    if(when_InOutWrapper_l13_64) begin
      _zz_flash_d_15 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data = 1'b0;
    if(when_InOutWrapper_l13_63) begin
      _zz_extRam_data = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_1 = 1'b0;
    if(when_InOutWrapper_l13_62) begin
      _zz_extRam_data_1 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_2 = 1'b0;
    if(when_InOutWrapper_l13_61) begin
      _zz_extRam_data_2 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_3 = 1'b0;
    if(when_InOutWrapper_l13_60) begin
      _zz_extRam_data_3 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_4 = 1'b0;
    if(when_InOutWrapper_l13_59) begin
      _zz_extRam_data_4 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_5 = 1'b0;
    if(when_InOutWrapper_l13_58) begin
      _zz_extRam_data_5 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_6 = 1'b0;
    if(when_InOutWrapper_l13_57) begin
      _zz_extRam_data_6 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_7 = 1'b0;
    if(when_InOutWrapper_l13_56) begin
      _zz_extRam_data_7 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_8 = 1'b0;
    if(when_InOutWrapper_l13_55) begin
      _zz_extRam_data_8 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_9 = 1'b0;
    if(when_InOutWrapper_l13_54) begin
      _zz_extRam_data_9 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_10 = 1'b0;
    if(when_InOutWrapper_l13_53) begin
      _zz_extRam_data_10 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_11 = 1'b0;
    if(when_InOutWrapper_l13_52) begin
      _zz_extRam_data_11 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_12 = 1'b0;
    if(when_InOutWrapper_l13_51) begin
      _zz_extRam_data_12 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_13 = 1'b0;
    if(when_InOutWrapper_l13_50) begin
      _zz_extRam_data_13 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_14 = 1'b0;
    if(when_InOutWrapper_l13_49) begin
      _zz_extRam_data_14 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_15 = 1'b0;
    if(when_InOutWrapper_l13_48) begin
      _zz_extRam_data_15 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_16 = 1'b0;
    if(when_InOutWrapper_l13_47) begin
      _zz_extRam_data_16 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_17 = 1'b0;
    if(when_InOutWrapper_l13_46) begin
      _zz_extRam_data_17 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_18 = 1'b0;
    if(when_InOutWrapper_l13_45) begin
      _zz_extRam_data_18 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_19 = 1'b0;
    if(when_InOutWrapper_l13_44) begin
      _zz_extRam_data_19 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_20 = 1'b0;
    if(when_InOutWrapper_l13_43) begin
      _zz_extRam_data_20 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_21 = 1'b0;
    if(when_InOutWrapper_l13_42) begin
      _zz_extRam_data_21 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_22 = 1'b0;
    if(when_InOutWrapper_l13_41) begin
      _zz_extRam_data_22 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_23 = 1'b0;
    if(when_InOutWrapper_l13_40) begin
      _zz_extRam_data_23 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_24 = 1'b0;
    if(when_InOutWrapper_l13_39) begin
      _zz_extRam_data_24 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_25 = 1'b0;
    if(when_InOutWrapper_l13_38) begin
      _zz_extRam_data_25 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_26 = 1'b0;
    if(when_InOutWrapper_l13_37) begin
      _zz_extRam_data_26 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_27 = 1'b0;
    if(when_InOutWrapper_l13_36) begin
      _zz_extRam_data_27 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_28 = 1'b0;
    if(when_InOutWrapper_l13_35) begin
      _zz_extRam_data_28 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_29 = 1'b0;
    if(when_InOutWrapper_l13_34) begin
      _zz_extRam_data_29 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_30 = 1'b0;
    if(when_InOutWrapper_l13_33) begin
      _zz_extRam_data_30 = 1'b1;
    end
  end

  always @(*) begin
    _zz_extRam_data_31 = 1'b0;
    if(when_InOutWrapper_l13_32) begin
      _zz_extRam_data_31 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData = 1'b0;
    if(when_InOutWrapper_l13_31) begin
      _zz_uartAndBaseRamData = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_1 = 1'b0;
    if(when_InOutWrapper_l13_30) begin
      _zz_uartAndBaseRamData_1 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_2 = 1'b0;
    if(when_InOutWrapper_l13_29) begin
      _zz_uartAndBaseRamData_2 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_3 = 1'b0;
    if(when_InOutWrapper_l13_28) begin
      _zz_uartAndBaseRamData_3 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_4 = 1'b0;
    if(when_InOutWrapper_l13_27) begin
      _zz_uartAndBaseRamData_4 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_5 = 1'b0;
    if(when_InOutWrapper_l13_26) begin
      _zz_uartAndBaseRamData_5 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_6 = 1'b0;
    if(when_InOutWrapper_l13_25) begin
      _zz_uartAndBaseRamData_6 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_7 = 1'b0;
    if(when_InOutWrapper_l13_24) begin
      _zz_uartAndBaseRamData_7 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_8 = 1'b0;
    if(when_InOutWrapper_l13_23) begin
      _zz_uartAndBaseRamData_8 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_9 = 1'b0;
    if(when_InOutWrapper_l13_22) begin
      _zz_uartAndBaseRamData_9 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_10 = 1'b0;
    if(when_InOutWrapper_l13_21) begin
      _zz_uartAndBaseRamData_10 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_11 = 1'b0;
    if(when_InOutWrapper_l13_20) begin
      _zz_uartAndBaseRamData_11 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_12 = 1'b0;
    if(when_InOutWrapper_l13_19) begin
      _zz_uartAndBaseRamData_12 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_13 = 1'b0;
    if(when_InOutWrapper_l13_18) begin
      _zz_uartAndBaseRamData_13 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_14 = 1'b0;
    if(when_InOutWrapper_l13_17) begin
      _zz_uartAndBaseRamData_14 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_15 = 1'b0;
    if(when_InOutWrapper_l13_16) begin
      _zz_uartAndBaseRamData_15 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_16 = 1'b0;
    if(when_InOutWrapper_l13_15) begin
      _zz_uartAndBaseRamData_16 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_17 = 1'b0;
    if(when_InOutWrapper_l13_14) begin
      _zz_uartAndBaseRamData_17 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_18 = 1'b0;
    if(when_InOutWrapper_l13_13) begin
      _zz_uartAndBaseRamData_18 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_19 = 1'b0;
    if(when_InOutWrapper_l13_12) begin
      _zz_uartAndBaseRamData_19 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_20 = 1'b0;
    if(when_InOutWrapper_l13_11) begin
      _zz_uartAndBaseRamData_20 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_21 = 1'b0;
    if(when_InOutWrapper_l13_10) begin
      _zz_uartAndBaseRamData_21 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_22 = 1'b0;
    if(when_InOutWrapper_l13_9) begin
      _zz_uartAndBaseRamData_22 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_23 = 1'b0;
    if(when_InOutWrapper_l13_8) begin
      _zz_uartAndBaseRamData_23 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_24 = 1'b0;
    if(when_InOutWrapper_l13_7) begin
      _zz_uartAndBaseRamData_24 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_25 = 1'b0;
    if(when_InOutWrapper_l13_6) begin
      _zz_uartAndBaseRamData_25 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_26 = 1'b0;
    if(when_InOutWrapper_l13_5) begin
      _zz_uartAndBaseRamData_26 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_27 = 1'b0;
    if(when_InOutWrapper_l13_4) begin
      _zz_uartAndBaseRamData_27 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_28 = 1'b0;
    if(when_InOutWrapper_l13_3) begin
      _zz_uartAndBaseRamData_28 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_29 = 1'b0;
    if(when_InOutWrapper_l13_2) begin
      _zz_uartAndBaseRamData_29 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_30 = 1'b0;
    if(when_InOutWrapper_l13_1) begin
      _zz_uartAndBaseRamData_30 = 1'b1;
    end
  end

  always @(*) begin
    _zz_uartAndBaseRamData_31 = 1'b0;
    if(when_InOutWrapper_l13) begin
      _zz_uartAndBaseRamData_31 = 1'b1;
    end
  end

  assign uartControlled_rdn = 1'b1;
  assign uartControlled_wrn = 1'b1;
  assign baseRam_ceN = 1'b1;
  assign baseRam_oeN = 1'b1;
  assign baseRam_weN = 1'b1;
  assign baseRam_beN = 4'b0000;
  assign baseRam_addr = 20'bxxxxxxxxxxxxxxxxxxxx;
  assign extRam_ceN = 1'b1;
  assign extRam_oeN = 1'b1;
  assign extRam_weN = 1'b1;
  assign extRam_beN = 4'b0000;
  assign extRam_addr = 20'bxxxxxxxxxxxxxxxxxxxx;
  assign flash_a = 23'bxxxxxxxxxxxxxxxxxxxxxxx;
  assign flash_rpN = 1'bx;
  assign flash_vpen = 1'bx;
  assign flash_ceN = 1'bx;
  assign flash_oeN = 1'bx;
  assign flash_weN = 1'bx;
  assign flash_byteN = 1'bx;
  assign sl811_a0 = 1'bx;
  assign sl811_wrN = 1'bx;
  assign sl811_rdN = 1'bx;
  assign sl811_csN = 1'bx;
  assign sl811_rstN = 1'bx;
  assign sl811_dAckN = 1'bx;
  assign dm9k_cmd = 1'bx;
  assign dm9k_iowN = 1'bx;
  assign dm9k_iorN = 1'bx;
  assign dm9k_csN = 1'bx;
  assign dm9k_pwrstN = 1'bx;
  assign seg7Lut_2_io_iDig = number[3 : 0];
  assign dpy0 = seg7Lut_2_io_oSeg;
  assign seg7Lut_3_io_iDig = number[7 : 4];
  assign dpy1 = seg7Lut_3_io_oSeg;
  assign leds = btnClockingArea_ledBits;
  assign uartRawCtrl_io_config_clockDivider = 20'h0028a;
  assign uartRawCtrl_io_config_frame_dataLength = 3'b111;
  assign uartRawCtrl_io_config_frame_parity = UartParityType_NONE;
  assign uartRawCtrl_io_config_frame_stop = UartStopType_ONE;
  assign uartRawCtrl_io_writeBreak = 1'b0;
  assign uartRaw_txd = uartRawCtrl_io_uart_txd;
  assign toplevel_uartRawCtrl_io_read_s2mPipe_valid = (uartRawCtrl_io_read_valid || (! toplevel_uartRawCtrl_io_read_rValidN));
  assign toplevel_uartRawCtrl_io_read_s2mPipe_payload = (toplevel_uartRawCtrl_io_read_rValidN ? uartRawCtrl_io_read_payload : toplevel_uartRawCtrl_io_read_rData);
  always @(*) begin
    toplevel_uartRawCtrl_io_read_s2mPipe_ready = toplevel_uartRawCtrl_io_read_s2mPipe_m2sPipe_ready;
    if(when_Stream_l369) begin
      toplevel_uartRawCtrl_io_read_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l369 = (! toplevel_uartRawCtrl_io_read_s2mPipe_m2sPipe_valid);
  assign toplevel_uartRawCtrl_io_read_s2mPipe_m2sPipe_valid = toplevel_uartRawCtrl_io_read_s2mPipe_rValid;
  assign toplevel_uartRawCtrl_io_read_s2mPipe_m2sPipe_payload = toplevel_uartRawCtrl_io_read_s2mPipe_rData;
  assign toplevel_uartRawCtrl_io_read_s2mPipe_m2sPipe_ready = uartRawCtrl_io_write_ready;
  assign number = toplevel_uartRawCtrl_io_read_s2mPipe_m2sPipe_payload;
  assign video_color_r = ((vga800x600at75_io_hData < 12'h10a) ? 3'b111 : 3'b000);
  assign video_color_g = (((vga800x600at75_io_hData < 12'h214) && (12'h10a <= vga800x600at75_io_hData)) ? 3'b111 : 3'b000);
  assign video_color_b = ((12'h214 <= vga800x600at75_io_hData) ? 2'b11 : 2'b00);
  assign video_colorEn = vga800x600at75_io_colorEn;
  assign video_hSync = vga800x600at75_io_hSync;
  assign video_vSync = vga800x600at75_io_vSync;
  assign videoClk = clk50M;
  assign when_InOutWrapper_l13 = _zz_when_InOutWrapper_l13[0];
  assign when_InOutWrapper_l13_1 = _zz_when_InOutWrapper_l13[1];
  assign when_InOutWrapper_l13_2 = _zz_when_InOutWrapper_l13[2];
  assign when_InOutWrapper_l13_3 = _zz_when_InOutWrapper_l13[3];
  assign when_InOutWrapper_l13_4 = _zz_when_InOutWrapper_l13[4];
  assign when_InOutWrapper_l13_5 = _zz_when_InOutWrapper_l13[5];
  assign when_InOutWrapper_l13_6 = _zz_when_InOutWrapper_l13[6];
  assign when_InOutWrapper_l13_7 = _zz_when_InOutWrapper_l13[7];
  assign when_InOutWrapper_l13_8 = _zz_when_InOutWrapper_l13[8];
  assign when_InOutWrapper_l13_9 = _zz_when_InOutWrapper_l13[9];
  assign when_InOutWrapper_l13_10 = _zz_when_InOutWrapper_l13[10];
  assign when_InOutWrapper_l13_11 = _zz_when_InOutWrapper_l13[11];
  assign when_InOutWrapper_l13_12 = _zz_when_InOutWrapper_l13[12];
  assign when_InOutWrapper_l13_13 = _zz_when_InOutWrapper_l13[13];
  assign when_InOutWrapper_l13_14 = _zz_when_InOutWrapper_l13[14];
  assign when_InOutWrapper_l13_15 = _zz_when_InOutWrapper_l13[15];
  assign when_InOutWrapper_l13_16 = _zz_when_InOutWrapper_l13[16];
  assign when_InOutWrapper_l13_17 = _zz_when_InOutWrapper_l13[17];
  assign when_InOutWrapper_l13_18 = _zz_when_InOutWrapper_l13[18];
  assign when_InOutWrapper_l13_19 = _zz_when_InOutWrapper_l13[19];
  assign when_InOutWrapper_l13_20 = _zz_when_InOutWrapper_l13[20];
  assign when_InOutWrapper_l13_21 = _zz_when_InOutWrapper_l13[21];
  assign when_InOutWrapper_l13_22 = _zz_when_InOutWrapper_l13[22];
  assign when_InOutWrapper_l13_23 = _zz_when_InOutWrapper_l13[23];
  assign when_InOutWrapper_l13_24 = _zz_when_InOutWrapper_l13[24];
  assign when_InOutWrapper_l13_25 = _zz_when_InOutWrapper_l13[25];
  assign when_InOutWrapper_l13_26 = _zz_when_InOutWrapper_l13[26];
  assign when_InOutWrapper_l13_27 = _zz_when_InOutWrapper_l13[27];
  assign when_InOutWrapper_l13_28 = _zz_when_InOutWrapper_l13[28];
  assign when_InOutWrapper_l13_29 = _zz_when_InOutWrapper_l13[29];
  assign when_InOutWrapper_l13_30 = _zz_when_InOutWrapper_l13[30];
  assign when_InOutWrapper_l13_31 = _zz_when_InOutWrapper_l13[31];
  assign _zz_when_InOutWrapper_l13 = 32'h00000000;
  assign _zz_uartAndBaseRamData_32 = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
  assign when_InOutWrapper_l13_32 = _zz_when_InOutWrapper_l13_1[0];
  assign when_InOutWrapper_l13_33 = _zz_when_InOutWrapper_l13_1[1];
  assign when_InOutWrapper_l13_34 = _zz_when_InOutWrapper_l13_1[2];
  assign when_InOutWrapper_l13_35 = _zz_when_InOutWrapper_l13_1[3];
  assign when_InOutWrapper_l13_36 = _zz_when_InOutWrapper_l13_1[4];
  assign when_InOutWrapper_l13_37 = _zz_when_InOutWrapper_l13_1[5];
  assign when_InOutWrapper_l13_38 = _zz_when_InOutWrapper_l13_1[6];
  assign when_InOutWrapper_l13_39 = _zz_when_InOutWrapper_l13_1[7];
  assign when_InOutWrapper_l13_40 = _zz_when_InOutWrapper_l13_1[8];
  assign when_InOutWrapper_l13_41 = _zz_when_InOutWrapper_l13_1[9];
  assign when_InOutWrapper_l13_42 = _zz_when_InOutWrapper_l13_1[10];
  assign when_InOutWrapper_l13_43 = _zz_when_InOutWrapper_l13_1[11];
  assign when_InOutWrapper_l13_44 = _zz_when_InOutWrapper_l13_1[12];
  assign when_InOutWrapper_l13_45 = _zz_when_InOutWrapper_l13_1[13];
  assign when_InOutWrapper_l13_46 = _zz_when_InOutWrapper_l13_1[14];
  assign when_InOutWrapper_l13_47 = _zz_when_InOutWrapper_l13_1[15];
  assign when_InOutWrapper_l13_48 = _zz_when_InOutWrapper_l13_1[16];
  assign when_InOutWrapper_l13_49 = _zz_when_InOutWrapper_l13_1[17];
  assign when_InOutWrapper_l13_50 = _zz_when_InOutWrapper_l13_1[18];
  assign when_InOutWrapper_l13_51 = _zz_when_InOutWrapper_l13_1[19];
  assign when_InOutWrapper_l13_52 = _zz_when_InOutWrapper_l13_1[20];
  assign when_InOutWrapper_l13_53 = _zz_when_InOutWrapper_l13_1[21];
  assign when_InOutWrapper_l13_54 = _zz_when_InOutWrapper_l13_1[22];
  assign when_InOutWrapper_l13_55 = _zz_when_InOutWrapper_l13_1[23];
  assign when_InOutWrapper_l13_56 = _zz_when_InOutWrapper_l13_1[24];
  assign when_InOutWrapper_l13_57 = _zz_when_InOutWrapper_l13_1[25];
  assign when_InOutWrapper_l13_58 = _zz_when_InOutWrapper_l13_1[26];
  assign when_InOutWrapper_l13_59 = _zz_when_InOutWrapper_l13_1[27];
  assign when_InOutWrapper_l13_60 = _zz_when_InOutWrapper_l13_1[28];
  assign when_InOutWrapper_l13_61 = _zz_when_InOutWrapper_l13_1[29];
  assign when_InOutWrapper_l13_62 = _zz_when_InOutWrapper_l13_1[30];
  assign when_InOutWrapper_l13_63 = _zz_when_InOutWrapper_l13_1[31];
  assign _zz_when_InOutWrapper_l13_1 = 32'h00000000;
  assign _zz_extRam_data_32 = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
  assign when_InOutWrapper_l13_64 = _zz_when_InOutWrapper_l13_2[0];
  assign when_InOutWrapper_l13_65 = _zz_when_InOutWrapper_l13_2[1];
  assign when_InOutWrapper_l13_66 = _zz_when_InOutWrapper_l13_2[2];
  assign when_InOutWrapper_l13_67 = _zz_when_InOutWrapper_l13_2[3];
  assign when_InOutWrapper_l13_68 = _zz_when_InOutWrapper_l13_2[4];
  assign when_InOutWrapper_l13_69 = _zz_when_InOutWrapper_l13_2[5];
  assign when_InOutWrapper_l13_70 = _zz_when_InOutWrapper_l13_2[6];
  assign when_InOutWrapper_l13_71 = _zz_when_InOutWrapper_l13_2[7];
  assign when_InOutWrapper_l13_72 = _zz_when_InOutWrapper_l13_2[8];
  assign when_InOutWrapper_l13_73 = _zz_when_InOutWrapper_l13_2[9];
  assign when_InOutWrapper_l13_74 = _zz_when_InOutWrapper_l13_2[10];
  assign when_InOutWrapper_l13_75 = _zz_when_InOutWrapper_l13_2[11];
  assign when_InOutWrapper_l13_76 = _zz_when_InOutWrapper_l13_2[12];
  assign when_InOutWrapper_l13_77 = _zz_when_InOutWrapper_l13_2[13];
  assign when_InOutWrapper_l13_78 = _zz_when_InOutWrapper_l13_2[14];
  assign when_InOutWrapper_l13_79 = _zz_when_InOutWrapper_l13_2[15];
  assign _zz_when_InOutWrapper_l13_2 = 16'bxxxxxxxxxxxxxxxx;
  assign _zz_flash_d_16 = 16'bxxxxxxxxxxxxxxxx;
  assign when_InOutWrapper_l13_80 = _zz_when_InOutWrapper_l13_3[0];
  assign when_InOutWrapper_l13_81 = _zz_when_InOutWrapper_l13_3[1];
  assign when_InOutWrapper_l13_82 = _zz_when_InOutWrapper_l13_3[2];
  assign when_InOutWrapper_l13_83 = _zz_when_InOutWrapper_l13_3[3];
  assign when_InOutWrapper_l13_84 = _zz_when_InOutWrapper_l13_3[4];
  assign when_InOutWrapper_l13_85 = _zz_when_InOutWrapper_l13_3[5];
  assign when_InOutWrapper_l13_86 = _zz_when_InOutWrapper_l13_3[6];
  assign when_InOutWrapper_l13_87 = _zz_when_InOutWrapper_l13_3[7];
  assign when_InOutWrapper_l13_88 = _zz_when_InOutWrapper_l13_3[8];
  assign when_InOutWrapper_l13_89 = _zz_when_InOutWrapper_l13_3[9];
  assign when_InOutWrapper_l13_90 = _zz_when_InOutWrapper_l13_3[10];
  assign when_InOutWrapper_l13_91 = _zz_when_InOutWrapper_l13_3[11];
  assign when_InOutWrapper_l13_92 = _zz_when_InOutWrapper_l13_3[12];
  assign when_InOutWrapper_l13_93 = _zz_when_InOutWrapper_l13_3[13];
  assign when_InOutWrapper_l13_94 = _zz_when_InOutWrapper_l13_3[14];
  assign when_InOutWrapper_l13_95 = _zz_when_InOutWrapper_l13_3[15];
  assign _zz_when_InOutWrapper_l13_3 = 16'bxxxxxxxxxxxxxxxx;
  assign _zz_usbAndNetworkData_16 = 16'bxxxxxxxxxxxxxxxx;
  always @(posedge clockBtn or posedge resetBtn) begin
    if(resetBtn) begin
      btnClockingArea_ledBits <= 16'h0001;
    end else begin
      btnClockingArea_ledBits <= {btnClockingArea_ledBits[14 : 0],btnClockingArea_ledBits[15 : 15]};
    end
  end

  always @(posedge clk50M or posedge resetBtn) begin
    if(resetBtn) begin
      toplevel_uartRawCtrl_io_read_rValidN <= 1'b1;
      toplevel_uartRawCtrl_io_read_s2mPipe_rValid <= 1'b0;
    end else begin
      if(uartRawCtrl_io_read_valid) begin
        toplevel_uartRawCtrl_io_read_rValidN <= 1'b0;
      end
      if(toplevel_uartRawCtrl_io_read_s2mPipe_ready) begin
        toplevel_uartRawCtrl_io_read_rValidN <= 1'b1;
      end
      if(toplevel_uartRawCtrl_io_read_s2mPipe_ready) begin
        toplevel_uartRawCtrl_io_read_s2mPipe_rValid <= toplevel_uartRawCtrl_io_read_s2mPipe_valid;
      end
    end
  end

  always @(posedge clk50M) begin
    if(toplevel_uartRawCtrl_io_read_rValidN) begin
      toplevel_uartRawCtrl_io_read_rData <= uartRawCtrl_io_read_payload;
    end
    if(toplevel_uartRawCtrl_io_read_s2mPipe_ready) begin
      toplevel_uartRawCtrl_io_read_s2mPipe_rData <= toplevel_uartRawCtrl_io_read_s2mPipe_payload;
    end
  end


endmodule

module VgaExample (
  output wire          io_hSync,
  output wire          io_vSync,
  output reg  [11:0]   io_hData,
  output reg  [11:0]   io_vData,
  output wire          io_colorEn,
  input  wire          clk50M,
  input  wire          resetBtn
);

  wire                when_VgaExample_l51;
  wire                when_VgaExample_l53;
  wire                hSppBool;
  wire                vSppBool;

  assign when_VgaExample_l51 = (io_hData == 12'h40f);
  assign when_VgaExample_l53 = (io_vData == 12'h299);
  assign hSppBool = 1'b1;
  assign io_hSync = (((12'h358 <= io_hData) && (io_hData < 12'h3d0)) ? hSppBool : (! hSppBool));
  assign vSppBool = 1'b1;
  assign io_vSync = (((12'h27d <= io_vData) && (io_vData < 12'h283)) ? vSppBool : (! vSppBool));
  assign io_colorEn = ((io_hData < 12'h320) && (io_vData < 12'h258));
  always @(posedge clk50M) begin
    if(when_VgaExample_l51) begin
      io_hData <= 12'h000;
      if(when_VgaExample_l53) begin
        io_vData <= 12'h000;
      end else begin
        io_vData <= (io_vData + 12'h001);
      end
    end else begin
      io_hData <= (io_hData + 12'h001);
    end
  end


endmodule

module UartCtrl (
  input  wire [2:0]    io_config_frame_dataLength,
  input  wire [0:0]    io_config_frame_stop,
  input  wire [1:0]    io_config_frame_parity,
  input  wire [19:0]   io_config_clockDivider,
  input  wire          io_write_valid,
  output reg           io_write_ready,
  input  wire [7:0]    io_write_payload,
  output wire          io_read_valid,
  input  wire          io_read_ready,
  output wire [7:0]    io_read_payload,
  output wire          io_uart_txd,
  input  wire          io_uart_rxd,
  input  wire          io_writeBreak,
  input  wire          clk50M,
  input  wire          resetBtn
);
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;

  wire                tx_io_cts;
  wire                tx_io_write_ready;
  wire                tx_io_txd;
  wire                rx_io_read_valid;
  wire       [7:0]    rx_io_read_payload;
  wire                rx_io_break;
  reg        [19:0]   clockDivider_counter;
  wire                clockDivider_tick;
  reg                 clockDivider_tickReg;
  reg                 io_write_thrown_valid;
  wire                io_write_thrown_ready;
  wire       [7:0]    io_write_thrown_payload;
  `ifndef SYNTHESIS
  reg [23:0] io_config_frame_stop_string;
  reg [31:0] io_config_frame_parity_string;
  `endif


  UartCtrlTx tx (
    .io_configFrame_dataLength (io_config_frame_dataLength[2:0]), //i
    .io_configFrame_stop       (io_config_frame_stop           ), //i
    .io_configFrame_parity     (io_config_frame_parity[1:0]    ), //i
    .io_samplingTick           (clockDivider_tickReg           ), //i
    .io_write_valid            (io_write_thrown_valid          ), //i
    .io_write_ready            (tx_io_write_ready              ), //o
    .io_write_payload          (io_write_thrown_payload[7:0]   ), //i
    .io_cts                    (tx_io_cts                      ), //i
    .io_txd                    (tx_io_txd                      ), //o
    .io_break                  (io_writeBreak                  ), //i
    .clk50M                    (clk50M                         ), //i
    .resetBtn                  (resetBtn                       )  //i
  );
  UartCtrlRx rx (
    .io_configFrame_dataLength (io_config_frame_dataLength[2:0]), //i
    .io_configFrame_stop       (io_config_frame_stop           ), //i
    .io_configFrame_parity     (io_config_frame_parity[1:0]    ), //i
    .io_samplingTick           (clockDivider_tickReg           ), //i
    .io_read_valid             (rx_io_read_valid               ), //o
    .io_read_payload           (rx_io_read_payload[7:0]        ), //o
    .io_rxd                    (io_uart_rxd                    ), //i
    .io_break                  (rx_io_break                    ), //o
    .clk50M                    (clk50M                         ), //i
    .resetBtn                  (resetBtn                       )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_config_frame_stop)
      UartStopType_ONE : io_config_frame_stop_string = "ONE";
      UartStopType_TWO : io_config_frame_stop_string = "TWO";
      default : io_config_frame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_config_frame_parity)
      UartParityType_NONE : io_config_frame_parity_string = "NONE";
      UartParityType_EVEN : io_config_frame_parity_string = "EVEN";
      UartParityType_ODD : io_config_frame_parity_string = "ODD ";
      default : io_config_frame_parity_string = "????";
    endcase
  end
  `endif

  assign clockDivider_tick = (clockDivider_counter == 20'h00000);
  always @(*) begin
    io_write_thrown_valid = io_write_valid;
    if(rx_io_break) begin
      io_write_thrown_valid = 1'b0;
    end
  end

  always @(*) begin
    io_write_ready = io_write_thrown_ready;
    if(rx_io_break) begin
      io_write_ready = 1'b1;
    end
  end

  assign io_write_thrown_payload = io_write_payload;
  assign io_write_thrown_ready = tx_io_write_ready;
  assign io_read_valid = rx_io_read_valid;
  assign io_read_payload = rx_io_read_payload;
  assign io_uart_txd = tx_io_txd;
  assign tx_io_cts = 1'b0;
  always @(posedge clk50M or posedge resetBtn) begin
    if(resetBtn) begin
      clockDivider_counter <= 20'h00000;
      clockDivider_tickReg <= 1'b0;
    end else begin
      clockDivider_tickReg <= clockDivider_tick;
      clockDivider_counter <= (clockDivider_counter - 20'h00001);
      if(clockDivider_tick) begin
        clockDivider_counter <= io_config_clockDivider;
      end
    end
  end


endmodule

//Seg7Lut_1 replaced by Seg7Lut

module Seg7Lut (
  input  wire [3:0]    io_iDig,
  output wire [7:0]    io_oSeg,
  input  wire          clk50M,
  input  wire          resetBtn
);

  reg        [6:0]    _zz_oSegReg;
  reg        [6:0]    oSegReg;

  always @(*) begin
    case(io_iDig)
      4'b0001 : begin
        _zz_oSegReg = 7'h76;
      end
      4'b0010 : begin
        _zz_oSegReg = 7'h21;
      end
      4'b0011 : begin
        _zz_oSegReg = 7'h24;
      end
      4'b0100 : begin
        _zz_oSegReg = 7'h16;
      end
      4'b0101 : begin
        _zz_oSegReg = 7'h0c;
      end
      4'b0110 : begin
        _zz_oSegReg = 7'h08;
      end
      4'b0111 : begin
        _zz_oSegReg = 7'h66;
      end
      4'b1000 : begin
        _zz_oSegReg = 7'h00;
      end
      4'b1001 : begin
        _zz_oSegReg = 7'h06;
      end
      4'b1010 : begin
        _zz_oSegReg = 7'h02;
      end
      4'b1011 : begin
        _zz_oSegReg = 7'h18;
      end
      4'b1100 : begin
        _zz_oSegReg = 7'h49;
      end
      4'b1101 : begin
        _zz_oSegReg = 7'h30;
      end
      4'b1110 : begin
        _zz_oSegReg = 7'h09;
      end
      4'b1111 : begin
        _zz_oSegReg = 7'h0b;
      end
      default : begin
        _zz_oSegReg = 7'h40;
      end
    endcase
  end

  assign io_oSeg = {(~ oSegReg),1'b0};
  always @(posedge clk50M) begin
    oSegReg <= _zz_oSegReg;
  end


endmodule

module UartCtrlRx (
  input  wire [2:0]    io_configFrame_dataLength,
  input  wire [0:0]    io_configFrame_stop,
  input  wire [1:0]    io_configFrame_parity,
  input  wire          io_samplingTick,
  output wire          io_read_valid,
  output wire [7:0]    io_read_payload,
  input  wire          io_rxd,
  output wire          io_break,
  input  wire          clk50M,
  input  wire          resetBtn
);
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;
  localparam UartCtrlRxState_IDLE = 3'd0;
  localparam UartCtrlRxState_START = 3'd1;
  localparam UartCtrlRxState_DATA = 3'd2;
  localparam UartCtrlRxState_PARITY = 3'd3;
  localparam UartCtrlRxState_STOP = 3'd4;

  wire                io_rxd_buffercc_io_dataOut;
  wire                _zz_sampler_value;
  wire                _zz_sampler_value_1;
  wire                _zz_sampler_value_2;
  wire                _zz_sampler_value_3;
  wire                _zz_sampler_value_4;
  wire                _zz_sampler_value_5;
  wire                _zz_sampler_value_6;
  wire       [2:0]    _zz_when_UartCtrlRx_l139;
  wire       [0:0]    _zz_when_UartCtrlRx_l139_1;
  wire                sampler_synchroniser;
  wire                sampler_samples_0;
  reg                 sampler_samples_1;
  reg                 sampler_samples_2;
  reg                 sampler_samples_3;
  reg                 sampler_samples_4;
  reg                 sampler_value;
  reg                 sampler_tick;
  reg        [2:0]    bitTimer_counter;
  reg                 bitTimer_tick;
  wire                when_UartCtrlRx_l43;
  reg        [2:0]    bitCounter_value;
  reg        [6:0]    break_counter;
  wire                break_valid;
  wire                when_UartCtrlRx_l69;
  reg        [2:0]    stateMachine_state;
  reg                 stateMachine_parity;
  reg        [7:0]    stateMachine_shifter;
  reg                 stateMachine_validReg;
  wire                when_UartCtrlRx_l93;
  wire                when_UartCtrlRx_l103;
  wire                when_UartCtrlRx_l111;
  wire                when_UartCtrlRx_l113;
  wire                when_UartCtrlRx_l125;
  wire                when_UartCtrlRx_l136;
  wire                when_UartCtrlRx_l139;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  `endif


  assign _zz_when_UartCtrlRx_l139_1 = ((io_configFrame_stop == UartStopType_ONE) ? 1'b0 : 1'b1);
  assign _zz_when_UartCtrlRx_l139 = {2'd0, _zz_when_UartCtrlRx_l139_1};
  assign _zz_sampler_value = ((((1'b0 || ((_zz_sampler_value_1 && sampler_samples_1) && sampler_samples_2)) || (((_zz_sampler_value_2 && sampler_samples_0) && sampler_samples_1) && sampler_samples_3)) || (((1'b1 && sampler_samples_0) && sampler_samples_2) && sampler_samples_3)) || (((1'b1 && sampler_samples_1) && sampler_samples_2) && sampler_samples_3));
  assign _zz_sampler_value_3 = (((1'b1 && sampler_samples_0) && sampler_samples_1) && sampler_samples_4);
  assign _zz_sampler_value_4 = ((1'b1 && sampler_samples_0) && sampler_samples_2);
  assign _zz_sampler_value_5 = (1'b1 && sampler_samples_1);
  assign _zz_sampler_value_6 = 1'b1;
  assign _zz_sampler_value_1 = (1'b1 && sampler_samples_0);
  assign _zz_sampler_value_2 = 1'b1;
  BufferCC io_rxd_buffercc (
    .io_dataIn  (io_rxd                    ), //i
    .io_dataOut (io_rxd_buffercc_io_dataOut), //o
    .clk50M     (clk50M                    ), //i
    .resetBtn   (resetBtn                  )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      UartStopType_ONE : io_configFrame_stop_string = "ONE";
      UartStopType_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      UartParityType_NONE : io_configFrame_parity_string = "NONE";
      UartParityType_EVEN : io_configFrame_parity_string = "EVEN";
      UartParityType_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      UartCtrlRxState_IDLE : stateMachine_state_string = "IDLE  ";
      UartCtrlRxState_START : stateMachine_state_string = "START ";
      UartCtrlRxState_DATA : stateMachine_state_string = "DATA  ";
      UartCtrlRxState_PARITY : stateMachine_state_string = "PARITY";
      UartCtrlRxState_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  `endif

  assign sampler_synchroniser = io_rxd_buffercc_io_dataOut;
  assign sampler_samples_0 = sampler_synchroniser;
  always @(*) begin
    bitTimer_tick = 1'b0;
    if(sampler_tick) begin
      if(when_UartCtrlRx_l43) begin
        bitTimer_tick = 1'b1;
      end
    end
  end

  assign when_UartCtrlRx_l43 = (bitTimer_counter == 3'b000);
  assign break_valid = (break_counter == 7'h68);
  assign when_UartCtrlRx_l69 = (io_samplingTick && (! break_valid));
  assign io_break = break_valid;
  assign io_read_valid = stateMachine_validReg;
  assign when_UartCtrlRx_l93 = ((sampler_tick && (! sampler_value)) && (! break_valid));
  assign when_UartCtrlRx_l103 = (sampler_value == 1'b1);
  assign when_UartCtrlRx_l111 = (bitCounter_value == io_configFrame_dataLength);
  assign when_UartCtrlRx_l113 = (io_configFrame_parity == UartParityType_NONE);
  assign when_UartCtrlRx_l125 = (stateMachine_parity == sampler_value);
  assign when_UartCtrlRx_l136 = (! sampler_value);
  assign when_UartCtrlRx_l139 = (bitCounter_value == _zz_when_UartCtrlRx_l139);
  assign io_read_payload = stateMachine_shifter;
  always @(posedge clk50M or posedge resetBtn) begin
    if(resetBtn) begin
      sampler_samples_1 <= 1'b1;
      sampler_samples_2 <= 1'b1;
      sampler_samples_3 <= 1'b1;
      sampler_samples_4 <= 1'b1;
      sampler_value <= 1'b1;
      sampler_tick <= 1'b0;
      break_counter <= 7'h00;
      stateMachine_state <= UartCtrlRxState_IDLE;
      stateMachine_validReg <= 1'b0;
    end else begin
      if(io_samplingTick) begin
        sampler_samples_1 <= sampler_samples_0;
      end
      if(io_samplingTick) begin
        sampler_samples_2 <= sampler_samples_1;
      end
      if(io_samplingTick) begin
        sampler_samples_3 <= sampler_samples_2;
      end
      if(io_samplingTick) begin
        sampler_samples_4 <= sampler_samples_3;
      end
      sampler_value <= ((((((_zz_sampler_value || _zz_sampler_value_3) || (_zz_sampler_value_4 && sampler_samples_4)) || ((_zz_sampler_value_5 && sampler_samples_2) && sampler_samples_4)) || (((_zz_sampler_value_6 && sampler_samples_0) && sampler_samples_3) && sampler_samples_4)) || (((1'b1 && sampler_samples_1) && sampler_samples_3) && sampler_samples_4)) || (((1'b1 && sampler_samples_2) && sampler_samples_3) && sampler_samples_4));
      sampler_tick <= io_samplingTick;
      if(sampler_value) begin
        break_counter <= 7'h00;
      end else begin
        if(when_UartCtrlRx_l69) begin
          break_counter <= (break_counter + 7'h01);
        end
      end
      stateMachine_validReg <= 1'b0;
      case(stateMachine_state)
        UartCtrlRxState_IDLE : begin
          if(when_UartCtrlRx_l93) begin
            stateMachine_state <= UartCtrlRxState_START;
          end
        end
        UartCtrlRxState_START : begin
          if(bitTimer_tick) begin
            stateMachine_state <= UartCtrlRxState_DATA;
            if(when_UartCtrlRx_l103) begin
              stateMachine_state <= UartCtrlRxState_IDLE;
            end
          end
        end
        UartCtrlRxState_DATA : begin
          if(bitTimer_tick) begin
            if(when_UartCtrlRx_l111) begin
              if(when_UartCtrlRx_l113) begin
                stateMachine_state <= UartCtrlRxState_STOP;
                stateMachine_validReg <= 1'b1;
              end else begin
                stateMachine_state <= UartCtrlRxState_PARITY;
              end
            end
          end
        end
        UartCtrlRxState_PARITY : begin
          if(bitTimer_tick) begin
            if(when_UartCtrlRx_l125) begin
              stateMachine_state <= UartCtrlRxState_STOP;
              stateMachine_validReg <= 1'b1;
            end else begin
              stateMachine_state <= UartCtrlRxState_IDLE;
            end
          end
        end
        default : begin
          if(bitTimer_tick) begin
            if(when_UartCtrlRx_l136) begin
              stateMachine_state <= UartCtrlRxState_IDLE;
            end else begin
              if(when_UartCtrlRx_l139) begin
                stateMachine_state <= UartCtrlRxState_IDLE;
              end
            end
          end
        end
      endcase
    end
  end

  always @(posedge clk50M) begin
    if(sampler_tick) begin
      bitTimer_counter <= (bitTimer_counter - 3'b001);
    end
    if(bitTimer_tick) begin
      bitCounter_value <= (bitCounter_value + 3'b001);
    end
    if(bitTimer_tick) begin
      stateMachine_parity <= (stateMachine_parity ^ sampler_value);
    end
    case(stateMachine_state)
      UartCtrlRxState_IDLE : begin
        if(when_UartCtrlRx_l93) begin
          bitTimer_counter <= 3'b010;
        end
      end
      UartCtrlRxState_START : begin
        if(bitTimer_tick) begin
          bitCounter_value <= 3'b000;
          stateMachine_parity <= (io_configFrame_parity == UartParityType_ODD);
        end
      end
      UartCtrlRxState_DATA : begin
        if(bitTimer_tick) begin
          stateMachine_shifter[bitCounter_value] <= sampler_value;
          if(when_UartCtrlRx_l111) begin
            bitCounter_value <= 3'b000;
          end
        end
      end
      UartCtrlRxState_PARITY : begin
        if(bitTimer_tick) begin
          bitCounter_value <= 3'b000;
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module UartCtrlTx (
  input  wire [2:0]    io_configFrame_dataLength,
  input  wire [0:0]    io_configFrame_stop,
  input  wire [1:0]    io_configFrame_parity,
  input  wire          io_samplingTick,
  input  wire          io_write_valid,
  output reg           io_write_ready,
  input  wire [7:0]    io_write_payload,
  input  wire          io_cts,
  output wire          io_txd,
  input  wire          io_break,
  input  wire          clk50M,
  input  wire          resetBtn
);
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;
  localparam UartCtrlTxState_IDLE = 3'd0;
  localparam UartCtrlTxState_START = 3'd1;
  localparam UartCtrlTxState_DATA = 3'd2;
  localparam UartCtrlTxState_PARITY = 3'd3;
  localparam UartCtrlTxState_STOP = 3'd4;

  wire       [2:0]    _zz_clockDivider_counter_valueNext;
  wire       [0:0]    _zz_clockDivider_counter_valueNext_1;
  wire       [2:0]    _zz_when_UartCtrlTx_l93;
  wire       [0:0]    _zz_when_UartCtrlTx_l93_1;
  reg                 clockDivider_counter_willIncrement;
  wire                clockDivider_counter_willClear;
  reg        [2:0]    clockDivider_counter_valueNext;
  reg        [2:0]    clockDivider_counter_value;
  wire                clockDivider_counter_willOverflowIfInc;
  wire                clockDivider_counter_willOverflow;
  reg        [2:0]    tickCounter_value;
  reg        [2:0]    stateMachine_state;
  reg                 stateMachine_parity;
  reg                 stateMachine_txd;
  wire                when_UartCtrlTx_l58;
  wire                when_UartCtrlTx_l73;
  wire                when_UartCtrlTx_l76;
  wire                when_UartCtrlTx_l93;
  wire       [2:0]    _zz_stateMachine_state;
  reg                 _zz_io_txd;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  reg [47:0] _zz_stateMachine_state_string;
  `endif


  assign _zz_clockDivider_counter_valueNext_1 = clockDivider_counter_willIncrement;
  assign _zz_clockDivider_counter_valueNext = {2'd0, _zz_clockDivider_counter_valueNext_1};
  assign _zz_when_UartCtrlTx_l93_1 = ((io_configFrame_stop == UartStopType_ONE) ? 1'b0 : 1'b1);
  assign _zz_when_UartCtrlTx_l93 = {2'd0, _zz_when_UartCtrlTx_l93_1};
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      UartStopType_ONE : io_configFrame_stop_string = "ONE";
      UartStopType_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      UartParityType_NONE : io_configFrame_parity_string = "NONE";
      UartParityType_EVEN : io_configFrame_parity_string = "EVEN";
      UartParityType_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      UartCtrlTxState_IDLE : stateMachine_state_string = "IDLE  ";
      UartCtrlTxState_START : stateMachine_state_string = "START ";
      UartCtrlTxState_DATA : stateMachine_state_string = "DATA  ";
      UartCtrlTxState_PARITY : stateMachine_state_string = "PARITY";
      UartCtrlTxState_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_stateMachine_state)
      UartCtrlTxState_IDLE : _zz_stateMachine_state_string = "IDLE  ";
      UartCtrlTxState_START : _zz_stateMachine_state_string = "START ";
      UartCtrlTxState_DATA : _zz_stateMachine_state_string = "DATA  ";
      UartCtrlTxState_PARITY : _zz_stateMachine_state_string = "PARITY";
      UartCtrlTxState_STOP : _zz_stateMachine_state_string = "STOP  ";
      default : _zz_stateMachine_state_string = "??????";
    endcase
  end
  `endif

  always @(*) begin
    clockDivider_counter_willIncrement = 1'b0;
    if(io_samplingTick) begin
      clockDivider_counter_willIncrement = 1'b1;
    end
  end

  assign clockDivider_counter_willClear = 1'b0;
  assign clockDivider_counter_willOverflowIfInc = (clockDivider_counter_value == 3'b111);
  assign clockDivider_counter_willOverflow = (clockDivider_counter_willOverflowIfInc && clockDivider_counter_willIncrement);
  always @(*) begin
    clockDivider_counter_valueNext = (clockDivider_counter_value + _zz_clockDivider_counter_valueNext);
    if(clockDivider_counter_willClear) begin
      clockDivider_counter_valueNext = 3'b000;
    end
  end

  always @(*) begin
    stateMachine_txd = 1'b1;
    case(stateMachine_state)
      UartCtrlTxState_IDLE : begin
      end
      UartCtrlTxState_START : begin
        stateMachine_txd = 1'b0;
      end
      UartCtrlTxState_DATA : begin
        stateMachine_txd = io_write_payload[tickCounter_value];
      end
      UartCtrlTxState_PARITY : begin
        stateMachine_txd = stateMachine_parity;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_write_ready = io_break;
    case(stateMachine_state)
      UartCtrlTxState_IDLE : begin
      end
      UartCtrlTxState_START : begin
      end
      UartCtrlTxState_DATA : begin
        if(clockDivider_counter_willOverflow) begin
          if(when_UartCtrlTx_l73) begin
            io_write_ready = 1'b1;
          end
        end
      end
      UartCtrlTxState_PARITY : begin
      end
      default : begin
      end
    endcase
  end

  assign when_UartCtrlTx_l58 = ((io_write_valid && (! io_cts)) && clockDivider_counter_willOverflow);
  assign when_UartCtrlTx_l73 = (tickCounter_value == io_configFrame_dataLength);
  assign when_UartCtrlTx_l76 = (io_configFrame_parity == UartParityType_NONE);
  assign when_UartCtrlTx_l93 = (tickCounter_value == _zz_when_UartCtrlTx_l93);
  assign _zz_stateMachine_state = (io_write_valid ? UartCtrlTxState_START : UartCtrlTxState_IDLE);
  assign io_txd = _zz_io_txd;
  always @(posedge clk50M or posedge resetBtn) begin
    if(resetBtn) begin
      clockDivider_counter_value <= 3'b000;
      stateMachine_state <= UartCtrlTxState_IDLE;
      _zz_io_txd <= 1'b1;
    end else begin
      clockDivider_counter_value <= clockDivider_counter_valueNext;
      case(stateMachine_state)
        UartCtrlTxState_IDLE : begin
          if(when_UartCtrlTx_l58) begin
            stateMachine_state <= UartCtrlTxState_START;
          end
        end
        UartCtrlTxState_START : begin
          if(clockDivider_counter_willOverflow) begin
            stateMachine_state <= UartCtrlTxState_DATA;
          end
        end
        UartCtrlTxState_DATA : begin
          if(clockDivider_counter_willOverflow) begin
            if(when_UartCtrlTx_l73) begin
              if(when_UartCtrlTx_l76) begin
                stateMachine_state <= UartCtrlTxState_STOP;
              end else begin
                stateMachine_state <= UartCtrlTxState_PARITY;
              end
            end
          end
        end
        UartCtrlTxState_PARITY : begin
          if(clockDivider_counter_willOverflow) begin
            stateMachine_state <= UartCtrlTxState_STOP;
          end
        end
        default : begin
          if(clockDivider_counter_willOverflow) begin
            if(when_UartCtrlTx_l93) begin
              stateMachine_state <= _zz_stateMachine_state;
            end
          end
        end
      endcase
      _zz_io_txd <= (stateMachine_txd && (! io_break));
    end
  end

  always @(posedge clk50M) begin
    if(clockDivider_counter_willOverflow) begin
      tickCounter_value <= (tickCounter_value + 3'b001);
    end
    if(clockDivider_counter_willOverflow) begin
      stateMachine_parity <= (stateMachine_parity ^ stateMachine_txd);
    end
    case(stateMachine_state)
      UartCtrlTxState_IDLE : begin
      end
      UartCtrlTxState_START : begin
        if(clockDivider_counter_willOverflow) begin
          stateMachine_parity <= (io_configFrame_parity == UartParityType_ODD);
          tickCounter_value <= 3'b000;
        end
      end
      UartCtrlTxState_DATA : begin
        if(clockDivider_counter_willOverflow) begin
          if(when_UartCtrlTx_l73) begin
            tickCounter_value <= 3'b000;
          end
        end
      end
      UartCtrlTxState_PARITY : begin
        if(clockDivider_counter_willOverflow) begin
          tickCounter_value <= 3'b000;
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module BufferCC (
  input  wire          io_dataIn,
  output wire          io_dataOut,
  input  wire          clk50M,
  input  wire          resetBtn
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk50M or posedge resetBtn) begin
    if(resetBtn) begin
      buffers_0 <= 1'b0;
      buffers_1 <= 1'b0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule
