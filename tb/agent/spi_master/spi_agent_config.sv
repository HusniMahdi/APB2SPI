`ifndef SPI_AGNT_CONFIG
`define SPI_AGNT_CONFIG

class spi_agent_config extends uvm_object;

    `uvm_object_utils(spi_agent_config)
    
    bit has_functional_coverage;
        
    uvm_active_passive_enum active_or_passive = UVM_PASSIVE;

    virtual SPI_DRIVER_BFM spi_bfm;
    
    function new(string name="spi_agent_config");
        super.new(name);
    endfunction  

endclass

`endif