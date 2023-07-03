`ifndef ENV_PKG
`define ENV_PKG

package apb2spi_env_pkg;

	`include "uvm_macros.svh"
	import uvm_pkg::* ;
	import test_param_pkg::* ;
	
	import apb_agent_pkg::* ;
	import spi_agent_pkg::* ;
	
	`include "apb2spi_scb.sv"
	// `include "apb2spi_predictor.sv"
	`include "apb2spi_predictor_v2.sv" 
	`include "apb2spi_env_config.sv"
	`include "apb2spi_env.sv"


endpackage

`endif
