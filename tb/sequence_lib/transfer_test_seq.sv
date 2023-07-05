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
    //   seq.REG_BLOCK[CTRL_R] == {ASS, IE, LSB_FIRST, TX_NEG, RX_NEG, BUSY, 8'd40};
    //   // seq.REG_BLOCK[DATA_R0] == 'hBBBB_CAFE;
    //   // seq.slave_data == 'hCCCC_DDDD_EEEE_FFFF;
    //   seq.REG_BLOCK[DIV_R] == 2;
    //   seq.REG_BLOCK[SS_R] == 2;
    // };

    // $display(`INFO "Transfer Seq Randomized");
    // $display ("REGISTER DATA_R0 Assigned data %h", seq.REG_BLOCK[DATA_R0]);
    // $display ("REGISTER DATA_R1 Assigned data %h", seq.REG_BLOCK[DATA_R1]);
    // $display ("REGISTER DATA_R2 Assigned data %h", seq.REG_BLOCK[DATA_R2]);
    // $display ("REGISTER DATA_R3 Assigned data %h", seq.REG_BLOCK[DATA_R3]);
    // $display ("REGISTER CTRL Assigned data %h", seq.REG_BLOCK[CTRL_R]);
    // $display ("REGISTER DIV Assigned data %h", seq.REG_BLOCK[DIV_R]);
    // $display ("REGISTER SS Assigned data %h", seq.REG_BLOCK[SS_R]);

    // seq.start(null);
    // apb_read_all();

    repeat (repeat_times) begin
      seq.randomize();
      seq.start(null);
      apb_read_all();

    end

  endtask

endclass