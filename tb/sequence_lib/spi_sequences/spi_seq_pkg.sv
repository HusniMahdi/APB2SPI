package spi_seq_pkg;

	`include "uvm_macros.svh"
	import uvm_pkg::* ;
	import test_param_pkg::* ;
	import spi_agent_pkg::spi_seq_item ;
	
	`include "spi_seq.sv"
	`include "spi_slave_ctrl_seq.sv"
	`include "spi_reg_assign_seq.sv"	
	
endpackage

