`uvm_analysis_imp_decl(_apb_mntr2prd)
`uvm_analysis_imp_decl(_spi_mntr2prd)

class apb2spi_predictor extends uvm_component;
	`uvm_component_utils(apb2spi_predictor);

	uvm_analysis_imp_apb_mntr2prd #(apb_seq_item, apb2spi_predictor)    apb_mntr2prd;
	uvm_analysis_imp_spi_mntr2prd #(spi_seq_item, apb2spi_predictor)    spi_mntr2prd;

	uvm_blocking_get_imp #(spi_seq_item, apb2spi_predictor)             prd_get_imp;

	SPI_REG_BLOCK REG_BLOCK;
	DATA expected_rx;
	bit expected_mosi_bit;
	// int i = 0;


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
		if (item_collect.pwrite && item_collect.penable && item_collect.psel) assign_regs(item_collect);
	endfunction

	function void write_spi_mntr2prd(spi_seq_item item_collect);
		update_regs(item_collect);
	endfunction

	function update_regs(spi_seq_item item);
		static bit [6:0] i;
		REG_VALUE CTRL = REG_BLOCK[CTRL_R];
		bit RX = CTRL[9];
		bit LSB = CTRL[11];
		bit [6:0] no_bits = CTRL[6:0];
		int bit_pos = i*LSB + (no_bits-1-i)*!LSB;

		
		// $display(`INFO "SPI Updating expected RX bit position %d with %b", bit_pos, item.rx_negedge*RX + item.rx_posedge*!RX);
		expected_mosi_bit = expected_rx[bit_pos];
		expected_rx [bit_pos] = item.rx_negedge*RX + item.rx_posedge*!RX;
		// $display(`INFO "SPI Updated Expected RX %0h", expected_rx);

		REG_BLOCK[DATA_R0] = expected_rx[31:0];
		REG_BLOCK[DATA_R1] = expected_rx[63:32];
		REG_BLOCK[DATA_R2] = expected_rx[95:64];
		REG_BLOCK[DATA_R3] = expected_rx[127:96];

		i++;
		if (i == no_bits) begin 
			i = 0;
			REG_BLOCK[CTRL_R][8] = BUSY;
		end

	endfunction

	function assign_regs(apb_seq_item item);
		REG_NAMES NAME;
		$cast(NAME, item.paddr);

		REG_BLOCK[NAME] = item.pdata;
		// $display(`INFO "Assigned %s REG value with %0h", NAME, REG_BLOCK[NAME]);
		expected_rx = {REG_BLOCK[DATA_R3], REG_BLOCK[DATA_R2], REG_BLOCK[DATA_R1], REG_BLOCK[DATA_R0]};
		// $display(`INFO "Expected RX %0h", expected_rx);
	endfunction

	virtual task get (output spi_seq_item item);

		item = spi_seq_item::type_id::create("item");

		item.REG_BLOCK = REG_BLOCK;
		item.expected_rx = expected_rx;
		item.expected_mosi_bit = expected_mosi_bit;

	endtask

endclass
