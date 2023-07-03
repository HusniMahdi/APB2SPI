package vseq_pkg;

	`include "uvm_macros.svh"
	import uvm_pkg::* ;
	import test_param_pkg::* ;

  import apb_seq_pkg::* ;
  import apb_agent_pkg::* ;

	import spi_seq_pkg::* ;
	import spi_agent_pkg::* ;
	
	`include "apb2spi_inputs_item.sv"
	`include "vseq_base.sv"
	`include "reset_test_seq.sv"
	`include "transfer_test_seq.sv"
	
endpackage
