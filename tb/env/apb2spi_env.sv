class apb2spi_env extends uvm_env;

	`uvm_component_utils(apb2spi_env)

	apb_agent agent_apb;
	spi_agent agent_spi;
	apb2spi_scb scb;
	apb2spi_predictor prd;
	apb2spi_env_config env_config;
	apb_agent_config agent_config_apb;
	spi_agent_config agent_config_spi;


	function new (string name = "apb2spi_env", uvm_component parent = null);
		super.new(name, parent);
		`uvm_info(get_name(), "ENV INITIATED \n", UVM_DEBUG)
	endfunction


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_name(), "ENV BUILD PHASE \n", UVM_DEBUG)

		if( ! (uvm_config_db #(apb2spi_env_config) :: get(this, "", "CONFIG_DATA_ENV", env_config)) )  begin
		`uvm_fatal(get_full_name(),"SIMULATION STOPPED || ENV COULD NOT FIND CONFIG \n") 
		end

		build_apb_agent();
		build_spi_agent();
		build_scb();
		build_prd();

	endfunction

	virtual function void build_apb_agent();

		agent_config_apb = apb_agent_config::type_id::create("agent_config_apb",this);

		agent_config_apb.has_functional_coverage = 1;  
		agent_config_apb.active_or_passive = UVM_ACTIVE;

		uvm_config_db #(apb_agent_config) :: set(this, "APB_AGENT", "CONFIG_DATA_APB_AGENT", agent_config_apb);
		agent_apb = apb_agent::type_id::create("APB_AGENT", this);

	endfunction

	virtual function void build_spi_agent();

		agent_config_spi = spi_agent_config::type_id::create("agent_config_spi",this);

		agent_config_spi.has_functional_coverage = 1;  
		agent_config_spi.active_or_passive = UVM_ACTIVE;

		uvm_config_db #(spi_agent_config) :: set(this, "SPI_AGENT", "CONFIG_DATA_SPI_AGENT", agent_config_spi);
		agent_spi = spi_agent::type_id::create("SPI_AGENT", this);

	endfunction

	virtual function void build_scb();

		if(env_config.has_scoreboard == 1) begin
			scb = apb2spi_scb::type_id::create("SCOREBOARD" , this);              
			`uvm_info(get_full_name()," [ENV] SCOREBOARD BUILT \n", UVM_DEBUG)
		end

	endfunction

	virtual function void build_prd();

		if(env_config.has_predictor == 1) begin
			prd = apb2spi_predictor::type_id::create("PREDICTOR" , this);              
			`uvm_info(get_full_name()," [ENV] PREDICTOR BUILT \n", UVM_DEBUG)
		end   
		$display("[ENV] PRD BUILT");

	endfunction

	virtual function void connect_phase (uvm_phase phase);
		super.connect_phase (phase);
		`uvm_info(get_full_name(), "ENVIRONMENT CONNECT PHASE \n", UVM_DEBUG)

		agent_apb.mntr.mntr_analysis_port.connect(scb.apb_mntr2scb);
		agent_spi.mntr.mntr_analysis_port.connect(scb.spi_mntr2scb);

		agent_apb.mntr.mntr_analysis_port.connect(prd.apb_mntr2prd);
		agent_spi.mntr.mntr_analysis_port.connect(prd.spi_mntr2prd);

		scb.prd_get_port.connect(prd.prd_get_imp);

	endfunction

endclass
