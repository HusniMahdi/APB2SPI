`include "uvm_macros.svh"  
import uvm_pkg::*;

import apb2spi_test_pkg::* ;
import test_param_pkg::* ;

module tb_top();

	bit clk;
	always #5 clk = ~clk;

	spi_interface spi_intf();

	apb_interface	apb_intf(clk);  

	APB_DRIVER_BFM apb_driver_bfm (
			.PCLK(clk),
			.PRESETn(apb_intf.PRESETN),
			.PADDR(apb_intf.PADDR),    
			.PWRITE(apb_intf.PWRITE),    
			.PSEL(apb_intf.PSEL),    
			.PENABLE(apb_intf.PENABLE),    
			.PWDATA(apb_intf.PWDATA),    
			.PRDATA(apb_intf.PRDATA),    
			.PREADY(apb_intf.PREADY)
		);


	SPI_DRIVER_BFM spi_driver_bfm (
			.clk(spi_intf.sclk_pad_o),
			.ss(spi_intf.ss_pad_o),
			.miso(spi_intf.miso_pad_i),
			.mosi(spi_intf.mosi_pad_o)
	);

	spi_top DUT   ( 
			.PCLK(apb_intf.PCLK),
			.PRESETN(apb_intf.PRESETN),
			.PADDR(apb_intf.PADDR),
			.PWRITE(apb_intf.PWRITE),
			.PSEL(apb_intf.PSEL),
			.PENABLE(apb_intf.PENABLE),
			.PWDATA(apb_intf.PWDATA),
			.PRDATA(apb_intf.PRDATA),
			.PREADY(apb_intf.PREADY),
			.IRQ(apb_intf.IRQ),
			.ss_pad_o(spi_intf.ss_pad_o),
			.sclk_pad_o(spi_intf.sclk_pad_o),
			.mosi_pad_o(spi_intf.mosi_pad_o),
			.miso_pad_i(spi_intf.miso_pad_i)
	);


	initial begin 

		uvm_config_db #(virtual apb_interface) :: set(null, "*", "apb_interface", apb_intf);
		uvm_config_db #(virtual spi_interface) :: set(null, "*", "spi_interface", spi_intf);
		uvm_config_db #(virtual APB_DRIVER_BFM) :: set(null, "*", "apb_driver_bfm", apb_driver_bfm);
		uvm_config_db #(virtual SPI_DRIVER_BFM) :: set(null, "*", "spi_driver_bfm", spi_driver_bfm);

		run_test ();

	end 

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars(0, tb_top);
	end

endmodule