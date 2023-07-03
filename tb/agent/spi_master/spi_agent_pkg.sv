`ifndef SPI_AGNT_PKG
`define SPI_AGNT_PKG

package spi_agent_pkg;

	`include "uvm_macros.svh"
	import uvm_pkg::* ;
	import test_param_pkg::* ;
		
	`include "spi_seq_item.sv"
	`include "spi_driver_proxy.sv"
	`include "spi_monitor.sv"
	`include "spi_sequencer.sv"
	`include "spi_agent_config.sv"
	`include "spi_agent.sv"

        
endpackage 

`endif