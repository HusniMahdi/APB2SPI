`timescale 1ns / 1ps

`ifndef SPI_SQNCR
`define SPI_SQNCR

class spi_sequencer extends uvm_sequencer #(spi_seq_item);
    `uvm_component_utils(spi_sequencer)
    
    function new (string name = "spi_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction

endclass

`endif