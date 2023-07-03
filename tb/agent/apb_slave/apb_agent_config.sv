`ifndef AGNT_CONFIG
`define AGNT_CONFIG

class apb_agent_config extends uvm_object;

    `uvm_object_utils(apb_agent_config)
    
    bit has_functional_coverage;
        
    uvm_active_passive_enum active_or_passive = UVM_PASSIVE; 

    virtual APB_DRIVER_BFM apb_bfm;
    
    function new(string name="apb_agent_config");
        super.new(name);
    endfunction  

endclass

`endif
