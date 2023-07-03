package apb2spi_test_pkg;

	import uvm_pkg::* ;
	`include "uvm_macros.svh"
	
	import test_param_pkg::* ;
	import apb2spi_env_pkg::* ;
	import vseq_pkg::* ;
	import spi_agent_pkg::* ;
	import apb_agent_pkg::* ;
	
	`include "apb2spi_base_test.sv"
	`include "apb2spi_reset_test.sv"
	`include "apb2spi_transfer_test.sv"
	

endpackage

// /home/husni/work/uvm/apb/apb2spi_slv_memory/tb/tb/test_lib/
