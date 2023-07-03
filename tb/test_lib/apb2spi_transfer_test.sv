class apb2spi_transfer_test extends apb2spi_base_test;
  `uvm_component_utils(apb2spi_transfer_test)
  
  transfer_test_seq seq;

  function new (string name = "apb2spi_transfer_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

      
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    seq = transfer_test_seq::type_id::create("RESET SEQ", this);
          
  endfunction


  virtual function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_full_name(),"TEST CONNECT PHASE \n", UVM_DEBUG)

    seq.spi_sqncr = env.agent_spi.sqncr;
    seq.apb_sqncr = env.agent_apb.sqncr;

  endfunction


  virtual task run_phase(uvm_phase phase);
    
    phase.raise_objection(this);    
        seq.repeat_times = 2;    
        seq.start(null);        
        env.scb.scb_report();        
    phase.drop_objection(this);

  endtask

endclass