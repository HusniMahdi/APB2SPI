`timescale 1ns / 1ps

`ifndef SPI_AGENT
`define SPI_AGENT

class spi_agent extends uvm_agent;
    `uvm_component_utils(spi_agent)

    spi_driver drvr;
    spi_monitor mntr;
    spi_sequencer sqncr;
    spi_agent_config agent_config_spi;
    
    function new(string name = "spi_agent", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info(get_full_name(),"SPI AGENT INITIATED \n", UVM_MEDIUM)
                
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_full_name(), "SPI AGENT BUILD PHASE \n", UVM_MEDIUM)

        if( !(uvm_config_db #(spi_agent_config) :: get(this, "", "CONFIG_DATA_SPI_AGENT", agent_config_spi) ))  begin
            `uvm_fatal(get_full_name(),"SIMULATION STOPPED, AGENT CONFIG ITEM NOT FOUND \n")
            
        end        
            
        if(agent_config_spi.active_or_passive == UVM_ACTIVE) begin
            sqncr = spi_sequencer::type_id::create("sqncr", this);   // created sqncr
            drvr = spi_driver::type_id::create("drvr", this);  // created driver
        end                                                     
        mntr = spi_monitor::type_id::create("mntr", this);

    endfunction

    virtual function void connect_phase (uvm_phase phase);
        super.connect_phase (phase);
        `uvm_info(get_full_name(), "AGENT CONNECT PHASE \n", UVM_MEDIUM)
        
        drvr.seq_item_port.connect(sqncr.seq_item_export);
    endfunction

    task run_phase(uvm_phase phase);
        `uvm_info(get_full_name(), "AGENT RUN PHASE \n", UVM_MEDIUM)  
    endtask 

endclass

`endif