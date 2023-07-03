class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor);

  apb_seq_item item_collect;
  virtual apb_interface vif;

  uvm_analysis_port #(apb_seq_item) mntr_analysis_port;

  function new(string name="apb_monitor", uvm_component parent=null);
    super.new(name,parent);
    `uvm_info(get_full_name(),"MONITOR INITIATED \n", UVM_DEBUG)
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase (phase);
    `uvm_info(get_full_name(),"MONITOR BUILD PHASE \n", UVM_DEBUG)

    mntr_analysis_port = new("mntr_analysis_port",this);

    if (!(uvm_config_db #(virtual apb_interface)::get(this, "", "apb_interface", vif))) begin
      `uvm_fatal(get_full_name(),"SIMULATION STOPPED || MONITOR COULD NOT FIND INTERFACE\n")
    end
    else $display($time," MNTR FOUND INTERFACE \n");
  endfunction

  virtual task run_phase(uvm_phase phase);
    `uvm_info(get_name(),"APB MONITOR RUN PHASE \n",UVM_MEDIUM)
    forever begin
      item_collect = apb_seq_item::type_id::create("item_collect", this);

      @(posedge vif.PCLK);
      item_collect.presetn = vif.PRESETN;
      item_collect.paddr = vif.PADDR;
      item_collect.pwrite = vif.PWRITE;
      item_collect.psel = vif.PSEL;

      if (vif.PSEL == 1) begin
        @(posedge vif.PCLK)
        item_collect.penable = vif.PENABLE;

        while(!vif.PREADY) begin
          @(posedge vif.PCLK);
        end

        if (!vif.PWRITE) item_collect.pdata = vif.PRDATA;
        else item_collect.pdata = vif.PWDATA;
        
      end

      `OPP_DISPLAY(item_collect)

      mntr_analysis_port.write(item_collect);

    end

  endtask
  
endclass