`timescale 1ns / 1ps

class apb_driver extends uvm_driver #(apb_seq_item);
    `uvm_component_utils(apb_driver)
    
    apb_seq_item item;
    virtual APB_DRIVER_BFM apb_bfm;
    
    uvm_analysis_port #(apb_seq_item) drvr_analysis_port;
    
    function new(string name = "apb_driver", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info(get_full_name(),"APB DRIVER INITIATED\n", UVM_MEDIUM)  
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_full_name(), "APB DRIVER BUILD PHASE\n", UVM_MEDIUM)
        
        drvr_analysis_port = new("drvr_analysis_port", this);
        
        if (!(uvm_config_db #(virtual APB_DRIVER_BFM)::get(this, "", "apb_driver_bfm", apb_bfm)) ) begin
            `uvm_fatal(get_full_name(),"SIMULATION STOPPED || DRIVER COULD NOT FIND INTERFACE\n") 
        end
                
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase (phase);
        `uvm_info(get_full_name(),"APB DRIVER RUN PHASE \n", UVM_NONE) 
        
        forever begin
            seq_item_port.get_next_item(item);
            apb_bfm.drive(item);
            seq_item_port.item_done();
        end
        
    endtask
    
endclass: apb_driver