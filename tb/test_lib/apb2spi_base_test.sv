class apb2spi_base_test extends uvm_test;

    `uvm_component_utils(apb2spi_base_test)

    apb2spi_env env;
    apb2spi_env_config env_config;

    apb_agent_config apb_config;
    spi_agent_config spi_config;
    vseq_base vseq;

    function new(string name = "apb2spi_base_test", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info(get_full_name(),"TEST INITIATED \n", UVM_DEBUG)        
    endfunction
    
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_full_name(),"TEST BUILD PHASE \n", UVM_DEBUG)

        env_config = apb2spi_env_config::type_id::create("env_config",this);

        apb_config = apb_agent_config::type_id::create("apb_config",this);
        uvm_config_db #(virtual APB_DRIVER_BFM) :: get(this, "", "apb_driver_bfm", apb_config.apb_bfm);
        env_config.apb_config = apb_config;

        spi_config = spi_agent_config::type_id::create("spi_config",this);
        uvm_config_db #(virtual SPI_DRIVER_BFM) :: get(this, "", "spi_driver_bfm", spi_config.spi_bfm);
        env_config.spi_config = spi_config;

        env_config.has_scoreboard = 1;
        env_config.has_predictor = 1;
        
        uvm_config_db #(apb2spi_env_config) :: set(this, "ENVIRONMENT", "CONFIG_DATA_ENV", env_config);

        env = apb2spi_env::type_id::create("ENVIRONMENT",this);

        vseq = vseq_base::type_id::create("VSEQ", this);
               
    endfunction
    

    virtual function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_full_name(),"TEST CONNECT PHASE \n", UVM_DEBUG)

        vseq.spi_sqncr = env.agent_spi.sqncr;
        vseq.apb_sqncr = env.agent_apb.sqncr;

    endfunction
     
    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_full_name(),"TEST RUN PHASE \n", UVM_DEBUG)
        
        phase.raise_objection(this);
            
            vseq.start(null);
            
            env.scb.scb_report();
            
        phase.drop_objection(this);

    endtask
    

endclass