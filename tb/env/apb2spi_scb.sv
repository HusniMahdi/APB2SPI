`uvm_analysis_imp_decl(_prd2scb)
`uvm_analysis_imp_decl(_apb_mntr2scb)
`uvm_analysis_imp_decl(_spi_mntr2scb)


class apb2spi_scb extends uvm_scoreboard;
	`uvm_component_utils(apb2spi_scb);

	uvm_blocking_get_port #(spi_seq_item) 							  prd_get_port;
	spi_seq_item                                          prd_item;

	uvm_analysis_imp_apb_mntr2scb #(apb_seq_item, apb2spi_scb)  apb_mntr2scb;
	apb_seq_item                                        				apb_mntr_qu [$];
	apb_seq_item                                        				apb_read_item;

	uvm_analysis_imp_spi_mntr2scb #(spi_seq_item, apb2spi_scb)  spi_mntr2scb;
	spi_seq_item                                        				spi_mntr_qu [$];
	spi_seq_item                                        				spi_read_item;

	int                                                 APB_Passed, APB_Failed, APB_Total;
	int                                                 SPI_Passed, SPI_Failed, SPI_Total;
	apb_seq_item                                        failed_qu [$];


	function new(string name = "apb_scb", uvm_component parent = null);
		super.new(name, parent);
		`uvm_info(get_full_name(),"SCOREBOARD new() \n", UVM_LOW) 
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		prd_get_port = new("prd_get_port", this);
		apb_mntr2scb = new("apb_mntr2scb", this);
		spi_mntr2scb = new("spi_mntr2scb", this);
		`uvm_info(get_full_name(), "SCOREBOARD Build Phase \n", UVM_LOW)
	endfunction


	function void write_apb_mntr2scb(apb_seq_item item_collect);
		// `OPP_DISPLAY(item_collect)
		if (!item_collect.pwrite && item_collect.psel) apb_mntr_qu.push_front(item_collect);
	endfunction

	function void write_spi_mntr2scb(spi_seq_item item_collect);
		// $display(`INFO "SCB got item from SPI MNTR");
		spi_mntr_qu.push_front(item_collect);
	endfunction

	task run_phase(uvm_phase phase);
		`uvm_info(get_full_name(),"SCOREBOARD Run Phase \n",UVM_LOW)

		forever begin
			fork
				check_apb();
				check_spi();
			join_any
		end

	endtask

	task check_spi();

		bit read_mosi_bit;
		bit TX;
		bit LSB;

		wait (spi_mntr_qu.size() > 0);
		spi_read_item = spi_mntr_qu.pop_back();

		prd_get_port.get(prd_item);

		TX = prd_item.REG_BLOCK[CTRL_R][10];
		read_mosi_bit = spi_read_item.mosi_negedge*!TX + spi_read_item.mosi_posedge*TX;

		$display (`INFO "Comparing MOSI Read Bit %b with Expected Bit %b", read_mosi_bit, prd_item.expected_mosi_bit);
		if (prd_item.expected_mosi_bit === read_mosi_bit) begin
			$display("SPI PASSED");
			SPI_Passed++;
		end
		else begin
			$display("SPI FAILED");
			SPI_Failed++;
		end

	endtask

	task check_apb ();
		REG_NAMES NAME;
		wait (apb_mntr_qu.size() > 0);
		apb_read_item = apb_mntr_qu.pop_back();
		prd_get_port.get(prd_item);
		$cast(NAME, apb_read_item.paddr);
		$display(`INFO "Comparing %s REG APB Read Data %0h with Expected Data %h", NAME, apb_read_item.pdata, prd_item.REG_BLOCK[NAME]);
		if (prd_item.REG_BLOCK[NAME] === apb_read_item.pdata) begin
			$display("APB PASSED");
			APB_Passed ++;
		end
		else begin
			$display("APB FAILED");
			APB_Failed ++;
		end
	endtask


	task scb_report();
		APB_Total = APB_Passed + APB_Failed;
		SPI_Total = SPI_Passed + SPI_Failed;
		$display ("\n \n ===================================       SCOREBOARD REPORT       =================================== \n");
		$display(" ********* Total APB Tests %d || Passed %d || Failed %d ||  ********* \n", APB_Total, APB_Passed, APB_Failed);
		$display(" ********* Total SPI Tests %d || Passed %d || Failed %d ||  ********* \n", SPI_Total, SPI_Passed, SPI_Failed);

		// while (failed_qu.size() > 0) begin
		//     // read_item = failed_qu.pop_back();
		//     // $display("(!!!) Failed Read from Address %d (in DEC) || Expected Data %h || Read Data %h || Burst Mode = %s || Size = %s" , read_item.paddr, read_item.expected_data, read_item.prdata, name_s[read_item.hburst_i], size_s[read_item.hsize_i]);
		// end

		$display ("\n ===================================       END       =================================== \n \n");
	endtask

endclass