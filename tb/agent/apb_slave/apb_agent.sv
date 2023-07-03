`timescale 1ns / 1ps

`ifndef APB_AGENT
`define APB_AGENT

class apb_agent extends uvm_agent;
    `uvm_component_utils(apb_agent)

    apb_driver drvr;
    apb_monitor mntr;
    apb_sequencer sqncr;
    apb_agent_config agent_config_apb;
    

    function new(string name = "apb_agent", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info(get_full_name(),"APB AGENT new() \n", UVM_MEDIUM)
                
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_full_name(), "APB AGENT BUILD PHASE \n", UVM_MEDIUM)
        

        if(!(uvm_config_db #(apb_agent_config) :: get(this, "", "CONFIG_DATA_APB_AGENT", agent_config_apb)))  begin
            `uvm_fatal(get_full_name(),"SIMULATION STOPPED, APB AGENT CONFIG ITEM NOT FOUND \n")
        end 
            
        if(agent_config_apb.active_or_passive == UVM_ACTIVE) begin
            sqncr = apb_sequencer::type_id::create("APB_SQNCR", this);   // created sqncr
            drvr = apb_driver::type_id::create("APB_DRVR", this);  // created driver
        end
    
        mntr = apb_monitor::type_id::create("APB_MNTR", this);

    endfunction

    virtual function void connect_phase (uvm_phase phase);
        super.connect_phase (phase);
        `uvm_info(get_full_name(), "APB AGENT CONNECT PHASE \n", UVM_MEDIUM)
        
        drvr.seq_item_port.connect(sqncr.seq_item_export);
         
    endfunction

    task run_phase(uvm_phase phase);
        `uvm_info(get_full_name(), "APB AGENT RUN PHASE \n", UVM_MEDIUM)  
    endtask 

endclass

`endif