class spi_monitor extends uvm_monitor;
	`uvm_component_utils(spi_monitor);

	spi_seq_item item_collect;
	virtual spi_interface vif;

	uvm_analysis_port #(spi_seq_item) mntr_analysis_port;       

	function new(string name="spi_monitor", uvm_component parent=null);
		super.new(name,parent);
		`uvm_info(get_full_name(),"SPI MONITOR INITIATED \n", UVM_MEDIUM)
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase (phase); 
		`uvm_info(get_full_name(),"SPI MONITOR BUILD PHASE \n", UVM_MEDIUM)

		mntr_analysis_port = new("mntr_analysis_port",this);

		if (!(uvm_config_db #(virtual spi_interface)::get(this, "", "spi_interface", vif))) begin
		`uvm_fatal(get_full_name(),"SIMULATION STOPPED || SPI MONITOR COULD NOT FIND INTERFACE\n") 
		end
	endfunction


	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info(get_full_name(),"SPI MONITOR RUN PHASE \n",UVM_MEDIUM) 
		item_collect = spi_seq_item::type_id::create("item_collect");
		
		forever begin
			@(posedge vif.sclk_pad_o);
			item_collect.mosi_posedge = vif.mosi_pad_o;
			item_collect.miso_posedge = vif.miso_pad_i;
			@(negedge vif.sclk_pad_o);
			item_collect.mosi_negedge = vif.mosi_pad_o;            
			item_collect.miso_negedge = vif.miso_pad_i;

			mntr_analysis_port.write(item_collect);
		end 
	endtask

endclass