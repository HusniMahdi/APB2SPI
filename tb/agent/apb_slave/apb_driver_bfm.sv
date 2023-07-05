interface APB_DRIVER_BFM #(int DATAWIDTH = test_param_pkg::dataWidth, ADDRWIDTH = test_param_pkg::addrWidth) (
  input               PCLK,
  output logic        PRESETn,

  output logic [31:0] PADDR,
  input  logic [31:0] PRDATA,
  output logic [31:0] PWDATA,
  output logic        PSEL,
  output logic        PENABLE,
  output logic        PWRITE,
  input  logic        PREADY
);


`include "uvm_macros.svh"
import uvm_pkg::*;
import apb_agent_pkg::*;
import test_param_pkg::*;

apb_agent_config m_cfg;


task drive (apb_seq_item item);

  // @(negedge PCLK)
  PRESETn <= item.presetn;
  PADDR <= item.paddr;
  PWDATA <= item.pdata;
  PSEL <= item.psel;
  PENABLE <= 0;
  PWRITE <= item.pwrite;

  if (item.psel) begin
    @(negedge PCLK)
    PENABLE <= 1;
    if (!PREADY) begin
      @(negedge PREADY);
    end
  end
  @(negedge PCLK);

endtask

endinterface