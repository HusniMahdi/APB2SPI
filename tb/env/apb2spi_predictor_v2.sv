`uvm_analysis_imp_decl(_apb_mntr2prd)
`uvm_analysis_imp_decl(_spi_mntr2prd)

class apb2spi_predictor extends uvm_component;
	`uvm_component_utils(apb2spi_predictor);

	uvm_analysis_imp_apb_mntr2prd #(apb_seq_item, apb2spi_predictor)    apb_mntr2prd;
  apb_seq_item                                                        apb_mntr_qu [$];

  uvm_analysis_imp_spi_mntr2prd #(spi_seq_item, apb2spi_predictor)    spi_mntr2prd;
  spi_seq_item                                                        spi_mntr_qu [$];

	uvm_blocking_get_imp #(spi_seq_item, apb2spi_predictor)             prd_get_imp;

	SPI_REG_BLOCK REG_BLOCK;
	bit expected_mosi_bit;

	function new(string name = "apb2spi_predictor", uvm_component parent = null);
		super.new(name, parent);
		`uvm_info(get_full_name(),"PREDICTOR new() \n", UVM_DEBUG)
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		apb_mntr2prd = new("apb_mntr2prd",this);
		spi_mntr2prd = new("spi_mntr2prd",this);
		prd_get_imp = new("prd_get_imp", this);

		`uvm_info(get_full_name(), "PREDICTOR Build Phase \n", UVM_DEBUG)
	endfunction


	function void write_apb_mntr2prd(apb_seq_item item_collect);
    apb_mntr_qu.push_front(item_collect);
	endfunction

	function void write_spi_mntr2prd(spi_seq_item item_collect);
    spi_mntr_qu.push_front(item_collect);
	endfunction

  virtual task run_phase (uvm_phase phase);

    forever begin
      fork

        begin
          wait (apb_mntr_qu.size() > 0);
          assign_regs(apb_mntr_qu.pop_back());  
        end

        begin
          wait (spi_mntr_qu.size() > 0);
          update_regs(spi_mntr_qu.pop_back());
        end
      join_any

    end


  endtask

	function void update_regs(spi_seq_item item);

    static bit [6:0] i;
		bit [6:0] no_bits = REG_BLOCK[CTRL_R][6:0];
		int bit_pos = (REG_BLOCK[CTRL_R][11] == LSB_FIRST) ? i:(no_bits-1-i);
		bit miso_bit = (REG_BLOCK[CTRL_R][09] == RX_NEG) ? item.miso_negedge:item.miso_posedge;
		ADDR_VALUE addr = (int'(bit_pos/32))*4;
		REG_NAMES NAME;
		$cast(NAME, addr);

		expected_mosi_bit = REG_BLOCK [NAME][bit_pos%32];
		REG_BLOCK [NAME][bit_pos%32] = miso_bit;

		i++;
		if (i == no_bits) begin 
			i = 0;
			REG_BLOCK[CTRL_R][8] = BUSY;
		end

	endfunction

	function void assign_regs(apb_seq_item item);
		REG_NAMES NAME;
		$cast(NAME, item.paddr);

		if (!item.presetn) begin
			$display(`INFO "Reseting Reg Values");
			REG_BLOCK[DATA_R0] = 'h0;
			REG_BLOCK[DATA_R1] = 'h0;
			REG_BLOCK[DATA_R2] = 'h0;
			REG_BLOCK[DATA_R3] = 'h0;

			REG_BLOCK[CTRL_R] = 'h0;
			REG_BLOCK[DIV_R] = 'hffff;
			REG_BLOCK[SS_R] = 'h0;
		end

    else if (item.presetn && item.psel && item.penable && item.pwrite) begin
      REG_BLOCK[NAME] = item.pdata;
    end

	endfunction

	virtual task get (output spi_seq_item item);

		item = spi_seq_item::type_id::create("item");

		item.REG_BLOCK = REG_BLOCK;
		item.expected_mosi_bit = expected_mosi_bit;

	endtask

endclass
