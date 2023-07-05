class transfer_seq extends vseq_base;
  `uvm_object_utils(transfer_seq)

  // rand SPI_REG_BLOCK REG_BLOCK;
  // rand DATA slave_data;    // these two already declared in vseq, so no need to redeclare

  function new(string name = "transfer_seq");
    super.new(name);
  endfunction

  virtual task pre_body();
    super.pre_body();
  endtask

  virtual task body();

    $display(`INFO " ==== Started ====");
    complete_transfer();

  endtask

  task complete_transfer ();
    semaphore sema;
    sema = new();

    fork
      begin
        apb_write(CTRL_REG, REG_BLOCK[CTRL_R]);
        sema.put();
        apb_write(DATA_REG, master_data);
        apb_write(DIV_REG, REG_BLOCK[DIV_R]);
        apb_write(SS_REG, REG_BLOCK[SS_R]);
        REG_BLOCK[CTRL_R][8] = GO;
        sema.put();
        apb_write(CTRL_REG, REG_BLOCK[CTRL_R]);
        apb_idle_for(REG_BLOCK[DIV_R], REG_BLOCK[CTRL_R][6:0]);
        $display($time, " ns || [%s] APB Thread Ended", get_name());
      end

      begin
        sema.get();
        slave_ctrl.slave_data = slave_data;
        slave_ctrl.CTRL = REG_BLOCK[CTRL_R];
        slave_ctrl.start(spi_sqncr);

        sema.get();
        slave_ctrl.CTRL = REG_BLOCK[CTRL_R];
        slave_ctrl.start(spi_sqncr);
        $display($time, " ns || [%s] SPI Thread Ended", get_name());
      end
    join

  endtask

  constraint MASTER_DATA_RESERVED {
    REG_BLOCK[DATA_R0] >= 0;
    REG_BLOCK[DATA_R0] <= 'hFFFF_FFFF;

    REG_BLOCK[DATA_R1] >= 0;
    REG_BLOCK[DATA_R1] <= 'hFFFF_FFFF;

    REG_BLOCK[DATA_R2] >= 0;
    REG_BLOCK[DATA_R2] <= 'hFFFF_FFFF;

    REG_BLOCK[DATA_R3] >= 0;
    REG_BLOCK[DATA_R3] <= 'hFFFF_FFFF;
  };

  // constraint SLAVE_DATA_RESERVED {
  //   slave_data[127:64] == 0;
  // };

  constraint CTRL_BLOCK_RESERVED {
    REG_BLOCK[CTRL_R][31:14] == 0;
    REG_BLOCK[CTRL_R][7] == 0;
    REG_BLOCK[CTRL_R][8] == 0;
    REG_BLOCK[CTRL_R][6:0] <= 64;
  };

  constraint DIV_BLOCK_RESERVED {
    REG_BLOCK[DIV_R][31:4] == 0;
  };

  constraint SS_BLOCK_RESERVED {
    REG_BLOCK[SS_R][31:8] == 0;
  };

endclass