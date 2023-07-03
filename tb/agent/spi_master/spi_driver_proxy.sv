class spi_driver extends uvm_driver #(spi_seq_item);
    `uvm_component_utils(spi_driver)
    
    spi_seq_item item;
    virtual SPI_DRIVER_BFM spi_bfm;
    
    uvm_analysis_port #(spi_seq_item) drvr_analysis_port;
    
    function new(string name = "spi_driver", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info(get_full_name(),"DRIVER INITIATED\n", UVM_MEDIUM)  
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_full_name(), "DRIVER BUILD PHASE\n", UVM_MEDIUM)
        
        drvr_analysis_port = new("drvr_analysis_port", this);
        
        if (!(uvm_config_db #(virtual SPI_DRIVER_BFM)::get(this, "", "spi_driver_bfm", spi_bfm)) ) begin
            `uvm_fatal(get_full_name(),"SIMULATION STOPPED || DRIVER COULD NOT FIND BFM \n") 
        end
                
    endfunction

    virtual function void connect_phase (uvm_phase phase);
        super.connect_phase (phase);
        `uvm_info(get_full_name(), "SPI DRIVER CONNECT PHASE \n", UVM_MEDIUM)
    endfunction

    task run_phase(uvm_phase phase);
        `uvm_info(get_full_name(),"SPI DRIVER RUN PHASE \n", UVM_MEDIUM)
        forever begin
            seq_item_port.get_next_item(item);
            // $display($time, " ns [SPI PROXY] Got Item");
            spi_bfm.drive(item);
            seq_item_port.item_done();
        end
    endtask
    
endclass: spi_driver
