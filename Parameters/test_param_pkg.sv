package test_param_pkg;

  import uvm_pkg::* ;
  `include "uvm_macros.svh"

  parameter dataWidth = 32;
  parameter addrWidth = 32;
  parameter slvCount = 8;

  typedef bit [dataWidth-1:0] REG_VALUE;
  typedef bit [addrWidth-1:0] ADDR_VALUE;
  typedef bit [(dataWidth*4)-1:0] DATA;

  typedef enum {
    DATA_R0 = 'h00,
    DATA_R1 = 'h04,
    DATA_R2 = 'h08,
    DATA_R3 = 'h0C,
    CTRL_R = 'h10,
    DIV_R = 'h14,
    SS_R = 'h18
  } REG_NAMES;

  typedef REG_VALUE SPI_REG_BLOCK [REG_NAMES];

  parameter DATA_REG       =   32'h00;
  parameter DATA_REG0      =   32'h00;
  parameter DATA_REG1      =   32'h04;
  parameter DATA_REG2      =   32'h08;
  parameter DATA_REG3      =   32'h0C;
  parameter CTRL_REG       =   32'h10;
  parameter DIV_REG        =   32'h14;
  parameter SS_REG         =   32'h18;
  
  // CTRL FIELDS
  parameter ASS = 1'b1;
  parameter MSS = 1'b0;
  
  parameter IE = 1'b1;
  
  parameter LSB_FIRST = 1'b1;
  parameter MSB_FIRST = 1'b0;
  
  parameter TX_NEG = 1'b1;
  parameter TX_POS = 1'b0;
  
  parameter NEG = 1'b1;
  parameter POS = 1'b0;
  
  parameter RX_NEG = 1'b1;
  parameter RX_POS = 1'b0;
  
  parameter GO = 1'b1;
  parameter BUSY = 1'b0;
  
  parameter RSV = 1'b0;
  
  typedef struct packed {
  
      bit [17:0] reserved;
      bit auto_ss;
      bit int_enb;
      bit first_bit;
      bit Tx;
      bit Rx;
      bit Go_Busy;
      bit reserved2;
      bit [6:0] Char_Len;
  
  } CTRL_VECTOR;




  `define OPP_DISPLAY(item) \
    if (!item.presetn) $display($time, " ns || [%s] APB RESETED", get_name()); \
    // else if (!item.psel) $display($time, " ns || [%s] APB IDLE", get_name()); \
    else if (item.pwrite && item.psel) $display($time, " ns || [%s]  APB WRITTEN Data :: %0h to Address :: %0h", get_name(), item.pdata, item.paddr); \
    else if (!item.pwrite && item.psel) $display($time, " ns || [%s]  APB READ Data :: %0h from Address :: %0h", get_name(), item.pdata, item.paddr); 

      
  `define DISPLAY_VIF(vif) \
    if (vif.PWRITE) $display ($time, "ns || [%s -vif] RST_N = %d, Write = %d, Enable = %d, Address = %d, Data = %d", get_name(), vif.RST_N, vif.PWRITE, vif.PENABLE, vif.PADDR, vif.PWDATA); \
    else $display ($time, "ns || [%s -vif] RST_N = %d, Write = %d, Enable = %d, Address = %d, Data = %d", get_name(), vif.RST_N, vif.PWRITE, vif.PENABLE, vif.PADDR, vif.PRDATA);

  `define INFO $time, " ns || [%s] ", get_name,

endpackage