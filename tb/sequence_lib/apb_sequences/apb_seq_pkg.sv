package apb_seq_pkg;

	`include "uvm_macros.svh"
	import uvm_pkg::* ;
	import test_param_pkg::* ;
	import apb_agent_pkg::apb_seq_item ;
	
	`include "apb_seq.sv"
	`include "apb_reset_seq.sv"
	`include "apb_write_seq.sv"
	`include "apb_read_seq.sv"
	`include "apb_idle_seq.sv"
	
endpackage

