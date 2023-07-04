class transfer_test_seq extends vseq_base;
  `uvm_object_utils(transfer_test_seq)

  transfer_seq seq;
  int repeat_times;


  function new(string name = "transfer_test_seq");
    super.new(name);
  endfunction

  virtual task pre_body();
    super.pre_body();

    seq = transfer_seq::type_id::create("TRANSFER SEQ");
    seq.spi_sqncr = this.spi_sqncr;
    seq.apb_sqncr = this.apb_sqncr;

  endtask

  virtual task body();

    reset();

    // seq.randomize() with {
    //   seq.REG_BLOCK[CTRL_R] == {ASS, IE, LSB_FIRST, TX_NEG, RX_NEG, BUSY, 8'd48};
    //   seq.master_data == 'hFACE_AAAA_BBBB_CAFE;
    //   seq.slave_data == 'hCCCC_DDDD_EEEE_FFFF;
    //   seq.REG_BLOCK[DIV_R] == 2;
    //   seq.REG_BLOCK[SS_R] == 2;      
    // };
    seq.randomize();
    seq.start(null);

    apb_read_all();

  endtask

endclass