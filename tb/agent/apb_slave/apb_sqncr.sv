`timescale 1ns / 1ps

`ifndef SQNCR
`define SQNCR

class apb_sequencer extends uvm_sequencer #(apb_seq_item);
    `uvm_component_utils(apb_sequencer)
    
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

endclass

`endif