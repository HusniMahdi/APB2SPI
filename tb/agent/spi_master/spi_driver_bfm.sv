interface SPI_DRIVER_BFM (
  input  logic       clk,
  input  logic [(test_param_pkg::slvCount -1): 0] ss,
  output logic       miso,
  input  logic       mosi
);

  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import spi_agent_pkg::*;
  import test_param_pkg::* ;

  spi_agent_config spi_config;
  REG_VALUE CTRL;
  bit RX, TX, LSB;
  bit [6:0] no_bits;
  DATA slave_data;

  task drive(spi_seq_item item);
    if (item.REG_BLOCK[CTRL_R][8] == BUSY) begin
      no_bits <= item.REG_BLOCK[CTRL_R][6:0];
      RX <= item.REG_BLOCK[CTRL_R][9];
      TX <= item.REG_BLOCK[CTRL_R][10];
      LSB <= item.REG_BLOCK[CTRL_R][11];
      slave_data <= item.slave_data;
    end

    else begin
      for (int i = 0; i < no_bits; i++) begin
        if (RX == RX_NEG) @(posedge clk);
        // $display($time, " ns || [SPI_BFM] MISO transfer of bit position %d of data %0b", i*LSB + (no_bits-1-i)*!LSB, slave_data);
        miso <= slave_data[i]*LSB + slave_data[no_bits-1-i]*!LSB;
        if (RX == RX_POS) @(negedge clk);
      end
    end

  endtask

endinterface