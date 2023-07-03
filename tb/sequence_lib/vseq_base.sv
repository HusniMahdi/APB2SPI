class vseq_base extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(vseq_base)


  spi_sequencer spi_sqncr;
  apb_sequencer apb_sqncr;

  apb_reset_seq reset_seq;
  apb_write_seq write_seq;
  apb_read_seq  read_seq;
  apb_idle_seq  idle_seq;

  apb2spi_inputs_item inputs_i;

  spi_slave_tf_seq slv_tf_seq;
  spi_slave_ctrl_seq slave_ctrl;


  function new(string name = "vseq_base");
  super.new(name);
  endfunction

  virtual task pre_body();
    reset_seq = apb_reset_seq::type_id::create("reset_seq");
    write_seq = apb_write_seq::type_id::create("write_seq");
    read_seq = apb_read_seq::type_id::create("read_seq");
    idle_seq = apb_idle_seq::type_id::create("idle_seq");
    inputs_i = apb2spi_inputs_item::type_id::create("inputs_i");

    slave_ctrl = spi_slave_ctrl_seq::type_id::create("slave_ctrl");
    slv_tf_seq = spi_slave_tf_seq::type_id::create("slv_tf_seq");
  endtask

  virtual task body();

    reset();

    // inputs_i.randomize() with {
    //   inputs_i.REG_BLOCK[CTRL_R] == {ASS, IE, LSB, TX_NEG, RX_NEG, BUSY, 8'd48};
    //   inputs_i.master_data == 'hFACE_AAAA_BBBB_CAFE;
    //   inputs_i.slave_data == 'hCCCC_DDDD_EEEE_FFFF;
    //   inputs_i.REG_BLOCK[DIV_R] == 2;
    //   inputs_i.REG_BLOCK[SS_R] == 2;
    // };

    // complete_transfer(inputs_i);

    // apb_read_all();

    // repeat (2) begin
    //   inputs_i.randomize();
    //   complete_transfer(inputs_i);
    //   apb_read_all();        
    // end


  endtask


  task reset();
    reset_seq.start(apb_sqncr);
  endtask

  task apb_write(ADDR_VALUE addr, DATA data);
    write_seq.paddr = addr;
    write_seq.pwdata  = data;

    write_seq.start(apb_sqncr);
  endtask

  task apb_read(ADDR_VALUE addr);
    read_seq.paddr = addr;

    read_seq.start(apb_sqncr);
  endtask

  task apb_idle();
    idle_seq.start(apb_sqncr);
  endtask

  task apb_idle_for(REG_VALUE div, no_bits);
    int n = (div+1)*(2*no_bits +1);
    repeat(n) idle_seq.start(apb_sqncr);
  endtask

  task apb_read_all();
    apb_read(DATA_REG0);
    apb_read(DATA_REG1);
    apb_read(DATA_REG2);
    apb_read(DATA_REG3);
    apb_read(CTRL_REG);
    apb_read(DIV_REG);
    apb_read(SS_REG);
  endtask

endclass