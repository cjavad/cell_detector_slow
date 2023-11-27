module DataMemory(
  input         clock,
  input  [15:0] io_address,
  output [31:0] io_dataRead,
  input         io_writeEnable,
  input  [31:0] io_dataWrite,
  input         io_testerEnable,
  input  [15:0] io_testerAddress,
  output [31:0] io_testerDataRead,
  input         io_testerWriteEnable,
  input  [31:0] io_testerDataWrite
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] memory [0:65535]; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_addr; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_2_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_2_addr; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_1_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_1_addr; // @[DataMemory.scala 18:20]
  wire  memory__T_1_mask; // @[DataMemory.scala 18:20]
  wire  memory__T_1_en; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_3_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_3_addr; // @[DataMemory.scala 18:20]
  wire  memory__T_3_mask; // @[DataMemory.scala 18:20]
  wire  memory__T_3_en; // @[DataMemory.scala 18:20]
  wire [31:0] _GEN_5 = io_testerWriteEnable ? io_testerDataWrite : memory__T_data; // @[DataMemory.scala 27:32]
  wire [31:0] _GEN_11 = io_writeEnable ? io_dataWrite : memory__T_2_data; // @[DataMemory.scala 37:26]
  assign memory__T_addr = io_testerAddress;
  assign memory__T_data = memory[memory__T_addr]; // @[DataMemory.scala 18:20]
  assign memory__T_2_addr = io_address;
  assign memory__T_2_data = memory[memory__T_2_addr]; // @[DataMemory.scala 18:20]
  assign memory__T_1_data = io_testerDataWrite;
  assign memory__T_1_addr = io_testerAddress;
  assign memory__T_1_mask = 1'h1;
  assign memory__T_1_en = io_testerEnable & io_testerWriteEnable;
  assign memory__T_3_data = io_dataWrite;
  assign memory__T_3_addr = io_address;
  assign memory__T_3_mask = 1'h1;
  assign memory__T_3_en = io_testerEnable ? 1'h0 : io_writeEnable;
  assign io_dataRead = io_testerEnable ? 32'h0 : _GEN_11; // @[DataMemory.scala 26:17 DataMemory.scala 34:17 DataMemory.scala 40:19]
  assign io_testerDataRead = io_testerEnable ? _GEN_5 : 32'h0; // @[DataMemory.scala 24:23 DataMemory.scala 30:25 DataMemory.scala 36:23]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 65536; initvar = initvar+1)
    memory[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(memory__T_1_en & memory__T_1_mask) begin
      memory[memory__T_1_addr] <= memory__T_1_data; // @[DataMemory.scala 18:20]
    end
    if(memory__T_3_en & memory__T_3_mask) begin
      memory[memory__T_3_addr] <= memory__T_3_data; // @[DataMemory.scala 18:20]
    end
  end
endmodule
module Accelerator(
  input         clock,
  input         reset,
  input         io_start,
  output        io_done,
  output [15:0] io_address,
  input  [31:0] io_dataRead,
  output        io_writeEnable,
  output [31:0] io_dataWrite
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] stateReg; // @[Accelerator.scala 18:25]
  reg [3:0] stepReg; // @[Accelerator.scala 19:24]
  reg [15:0] addressReg; // @[Accelerator.scala 23:27]
  reg [31:0] dataReg; // @[Accelerator.scala 24:24]
  reg [31:0] cxReg; // @[Accelerator.scala 26:22]
  reg [31:0] cyReg; // @[Accelerator.scala 27:22]
  reg [31:0] xReg; // @[Accelerator.scala 28:21]
  reg [31:0] yReg; // @[Accelerator.scala 29:21]
  wire  _T = 4'h0 == stepReg; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_1 = io_start ? 32'h0 : {{16'd0}, addressReg}; // @[Accelerator.scala 41:7]
  wire  _T_1 = 4'h6 == stepReg; // @[Conditional.scala 37:30]
  wire  _T_2 = $signed(xReg) >= 32'sh0; // @[Accelerator.scala 51:18]
  wire  _T_3 = $signed(xReg) < 32'sh14; // @[Accelerator.scala 51:39]
  wire  _T_4 = _T_2 & _T_3; // @[Accelerator.scala 51:31]
  wire  _T_5 = $signed(yReg) >= 32'sh0; // @[Accelerator.scala 51:60]
  wire  _T_6 = _T_4 & _T_5; // @[Accelerator.scala 51:52]
  wire  _T_7 = $signed(yReg) < 32'sh14; // @[Accelerator.scala 51:81]
  wire  _T_8 = _T_6 & _T_7; // @[Accelerator.scala 51:73]
  wire [63:0] _T_9 = $signed(yReg) * 32'sh14; // @[Accelerator.scala 52:29]
  wire [63:0] _GEN_80 = {{32{xReg[31]}},xReg}; // @[Accelerator.scala 52:42]
  wire [63:0] _T_13 = $signed(_T_9) + $signed(_GEN_80); // @[Accelerator.scala 52:56]
  wire [63:0] _GEN_4 = _T_8 ? _T_13 : 64'h0; // @[Accelerator.scala 51:95]
  wire  _T_14 = 4'h7 == stepReg; // @[Conditional.scala 37:30]
  wire  _T_15 = dataReg == 32'h0; // @[Accelerator.scala 62:21]
  wire  _T_16 = 4'h8 == stepReg; // @[Conditional.scala 37:30]
  wire [15:0] _T_18 = addressReg + 16'h190; // @[Accelerator.scala 70:32]
  wire  _T_19 = $signed(cxReg) == 32'sh13; // @[Accelerator.scala 73:19]
  wire [31:0] _T_22 = $signed(cyReg) + 32'sh1; // @[Accelerator.scala 74:24]
  wire [31:0] _T_25 = $signed(cxReg) + 32'sh1; // @[Accelerator.scala 77:24]
  wire  _T_26 = addressReg == 16'h18f; // @[Accelerator.scala 80:24]
  wire [15:0] _T_28 = addressReg + 16'h1; // @[Accelerator.scala 83:34]
  wire [15:0] _GEN_10 = _T_26 ? addressReg : _T_28; // @[Accelerator.scala 80:41]
  wire  _T_29 = 4'h1 == stepReg; // @[Conditional.scala 37:30]
  wire  _T_30 = 4'h2 == stepReg; // @[Conditional.scala 37:30]
  wire [31:0] _T_33 = $signed(cyReg) - 32'sh1; // @[Accelerator.scala 99:21]
  wire  _T_34 = 4'h3 == stepReg; // @[Conditional.scala 37:30]
  wire [31:0] _T_37 = $signed(cxReg) - 32'sh1; // @[Accelerator.scala 106:21]
  wire  _T_38 = 4'h4 == stepReg; // @[Conditional.scala 37:30]
  wire  _T_42 = 4'h5 == stepReg; // @[Conditional.scala 37:30]
  wire  _T_46 = 4'h9 == stepReg; // @[Conditional.scala 37:30]
  wire  _GEN_17 = _T_42 ? 1'h0 : _T_46; // @[Conditional.scala 39:67]
  wire  _GEN_22 = _T_38 ? 1'h0 : _GEN_17; // @[Conditional.scala 39:67]
  wire  _GEN_27 = _T_34 ? 1'h0 : _GEN_22; // @[Conditional.scala 39:67]
  wire  _GEN_32 = _T_30 ? 1'h0 : _GEN_27; // @[Conditional.scala 39:67]
  wire  _GEN_37 = _T_29 ? 1'h0 : _GEN_32; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_38 = _T_16 ? _T_18 : 16'h0; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_43 = _T_16 ? _GEN_10 : addressReg; // @[Conditional.scala 39:67]
  wire  _GEN_47 = _T_16 ? 1'h0 : _GEN_37; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_49 = _T_14 ? 16'h0 : _GEN_38; // @[Conditional.scala 39:67]
  wire  _GEN_50 = _T_14 ? 1'h0 : _T_16; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_53 = _T_14 ? addressReg : _GEN_43; // @[Conditional.scala 39:67]
  wire  _GEN_57 = _T_14 ? 1'h0 : _GEN_47; // @[Conditional.scala 39:67]
  wire [63:0] _GEN_58 = _T_1 ? _GEN_4 : {{48'd0}, _GEN_49}; // @[Conditional.scala 39:67]
  wire  _GEN_61 = _T_1 ? 1'h0 : _GEN_50; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_64 = _T_1 ? addressReg : _GEN_53; // @[Conditional.scala 39:67]
  wire  _GEN_68 = _T_1 ? 1'h0 : _GEN_57; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_70 = _T ? _GEN_1 : {{16'd0}, _GEN_64}; // @[Conditional.scala 40:58]
  wire [63:0] _GEN_73 = _T ? 64'h0 : _GEN_58; // @[Conditional.scala 40:58]
  assign io_done = _T ? 1'h0 : _GEN_68; // @[Accelerator.scala 34:11 Accelerator.scala 132:15]
  assign io_address = _GEN_73[15:0]; // @[Accelerator.scala 32:14 Accelerator.scala 52:20 Accelerator.scala 70:18]
  assign io_writeEnable = _T ? 1'h0 : _GEN_61; // @[Accelerator.scala 31:18 Accelerator.scala 71:22]
  assign io_dataWrite = dataReg; // @[Accelerator.scala 33:16]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  stepReg = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  addressReg = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  dataReg = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  cxReg = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  cyReg = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  xReg = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  yReg = _RAND_7[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      stateReg <= 4'h0;
    end else if (!(_T)) begin
      if (!(_T_1)) begin
        if (!(_T_14)) begin
          if (!(_T_16)) begin
            if (_T_29) begin
              stateReg <= 4'h2;
            end else if (_T_30) begin
              stateReg <= 4'h3;
            end else if (_T_34) begin
              stateReg <= 4'h4;
            end else if (_T_38) begin
              stateReg <= 4'h5;
            end else if (_T_42) begin
              stateReg <= 4'h8;
            end
          end
        end
      end
    end
    if (reset) begin
      stepReg <= 4'h0;
    end else if (_T) begin
      if (io_start) begin
        stepReg <= 4'h1;
      end
    end else if (_T_1) begin
      stepReg <= 4'h7;
    end else if (_T_14) begin
      if (_T_15) begin
        stepReg <= 4'h8;
      end else begin
        stepReg <= stateReg;
      end
    end else if (_T_16) begin
      if (_T_26) begin
        stepReg <= 4'h9;
      end else begin
        stepReg <= 4'h1;
      end
    end else if (_T_29) begin
      stepReg <= 4'h6;
    end else if (_T_30) begin
      stepReg <= 4'h6;
    end else if (_T_34) begin
      stepReg <= 4'h6;
    end else if (_T_38) begin
      stepReg <= 4'h6;
    end else if (_T_42) begin
      stepReg <= 4'h6;
    end else if (_T_46) begin
      stepReg <= 4'h9;
    end
    if (reset) begin
      addressReg <= 16'h0;
    end else begin
      addressReg <= _GEN_70[15:0];
    end
    if (reset) begin
      dataReg <= 32'h0;
    end else if (!(_T)) begin
      if (_T_1) begin
        if (_T_8) begin
          dataReg <= io_dataRead;
        end else begin
          dataReg <= 32'h0;
        end
      end
    end
    if (reset) begin
      cxReg <= 32'sh0;
    end else if (!(_T)) begin
      if (!(_T_1)) begin
        if (!(_T_14)) begin
          if (_T_16) begin
            if (_T_19) begin
              cxReg <= 32'sh0;
            end else begin
              cxReg <= _T_25;
            end
          end
        end
      end
    end
    if (reset) begin
      cyReg <= 32'sh0;
    end else if (!(_T)) begin
      if (!(_T_1)) begin
        if (!(_T_14)) begin
          if (_T_16) begin
            if (_T_19) begin
              cyReg <= _T_22;
            end
          end
        end
      end
    end
    if (reset) begin
      xReg <= 32'sh0;
    end else if (_T) begin
      if (io_start) begin
        xReg <= 32'sh0;
      end
    end else if (!(_T_1)) begin
      if (!(_T_14)) begin
        if (!(_T_16)) begin
          if (_T_29) begin
            xReg <= cxReg;
          end else if (_T_30) begin
            xReg <= cxReg;
          end else if (_T_34) begin
            xReg <= _T_37;
          end else if (_T_38) begin
            xReg <= _T_25;
          end else if (_T_42) begin
            xReg <= cxReg;
          end
        end
      end
    end
    if (reset) begin
      yReg <= 32'sh0;
    end else if (_T) begin
      if (io_start) begin
        yReg <= 32'sh0;
      end
    end else if (!(_T_1)) begin
      if (!(_T_14)) begin
        if (!(_T_16)) begin
          if (_T_29) begin
            yReg <= cyReg;
          end else if (_T_30) begin
            yReg <= _T_33;
          end else if (_T_34) begin
            yReg <= cyReg;
          end else if (_T_38) begin
            yReg <= cyReg;
          end else if (_T_42) begin
            yReg <= _T_22;
          end
        end
      end
    end
  end
endmodule
module SystemTop(
  input         clock,
  input         reset,
  output        io_done,
  input         io_start,
  input         io_testerDataMemEnable,
  input  [15:0] io_testerDataMemAddress,
  output [31:0] io_testerDataMemDataRead,
  input         io_testerDataMemWriteEnable,
  input  [31:0] io_testerDataMemDataWrite
);
  wire  dataMemory_clock; // @[SystemTop.scala 18:26]
  wire [15:0] dataMemory_io_address; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_dataRead; // @[SystemTop.scala 18:26]
  wire  dataMemory_io_writeEnable; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_dataWrite; // @[SystemTop.scala 18:26]
  wire  dataMemory_io_testerEnable; // @[SystemTop.scala 18:26]
  wire [15:0] dataMemory_io_testerAddress; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_testerDataRead; // @[SystemTop.scala 18:26]
  wire  dataMemory_io_testerWriteEnable; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_testerDataWrite; // @[SystemTop.scala 18:26]
  wire  accelerator_clock; // @[SystemTop.scala 19:27]
  wire  accelerator_reset; // @[SystemTop.scala 19:27]
  wire  accelerator_io_start; // @[SystemTop.scala 19:27]
  wire  accelerator_io_done; // @[SystemTop.scala 19:27]
  wire [15:0] accelerator_io_address; // @[SystemTop.scala 19:27]
  wire [31:0] accelerator_io_dataRead; // @[SystemTop.scala 19:27]
  wire  accelerator_io_writeEnable; // @[SystemTop.scala 19:27]
  wire [31:0] accelerator_io_dataWrite; // @[SystemTop.scala 19:27]
  DataMemory dataMemory ( // @[SystemTop.scala 18:26]
    .clock(dataMemory_clock),
    .io_address(dataMemory_io_address),
    .io_dataRead(dataMemory_io_dataRead),
    .io_writeEnable(dataMemory_io_writeEnable),
    .io_dataWrite(dataMemory_io_dataWrite),
    .io_testerEnable(dataMemory_io_testerEnable),
    .io_testerAddress(dataMemory_io_testerAddress),
    .io_testerDataRead(dataMemory_io_testerDataRead),
    .io_testerWriteEnable(dataMemory_io_testerWriteEnable),
    .io_testerDataWrite(dataMemory_io_testerDataWrite)
  );
  Accelerator accelerator ( // @[SystemTop.scala 19:27]
    .clock(accelerator_clock),
    .reset(accelerator_reset),
    .io_start(accelerator_io_start),
    .io_done(accelerator_io_done),
    .io_address(accelerator_io_address),
    .io_dataRead(accelerator_io_dataRead),
    .io_writeEnable(accelerator_io_writeEnable),
    .io_dataWrite(accelerator_io_dataWrite)
  );
  assign io_done = accelerator_io_done; // @[SystemTop.scala 23:11]
  assign io_testerDataMemDataRead = dataMemory_io_testerDataRead; // @[SystemTop.scala 34:28]
  assign dataMemory_clock = clock;
  assign dataMemory_io_address = accelerator_io_address; // @[SystemTop.scala 28:25]
  assign dataMemory_io_writeEnable = accelerator_io_writeEnable; // @[SystemTop.scala 30:29]
  assign dataMemory_io_dataWrite = accelerator_io_dataWrite; // @[SystemTop.scala 29:27]
  assign dataMemory_io_testerEnable = io_testerDataMemEnable; // @[SystemTop.scala 36:30]
  assign dataMemory_io_testerAddress = io_testerDataMemAddress; // @[SystemTop.scala 33:31]
  assign dataMemory_io_testerWriteEnable = io_testerDataMemWriteEnable; // @[SystemTop.scala 37:35]
  assign dataMemory_io_testerDataWrite = io_testerDataMemDataWrite; // @[SystemTop.scala 35:33]
  assign accelerator_clock = clock;
  assign accelerator_reset = reset;
  assign accelerator_io_start = io_start; // @[SystemTop.scala 24:24]
  assign accelerator_io_dataRead = dataMemory_io_dataRead; // @[SystemTop.scala 27:27]
endmodule
