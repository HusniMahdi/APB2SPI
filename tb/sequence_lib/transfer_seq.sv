class transfer_seq extends vseq_base;
  `uvm_object_utils(transfer_seq)

  function new(string name = "transfer_seq");
    super.new(name);
  endfunction

  virtual task pre_body();
    super.pre_body();
  endtask

  virtual task body();

    complete_transfer ();
    apb_read_all();

  endtask

  task complete_transfer ();

    apb_write(CTRL_REG, REG_BLOCK[CTRL_R]);
    slave_ctrl.slave_data = slave_data;
    slave_ctrl.REG_BLOCK[CTRL_R] = REG_BLOCK[CTRL_R];
    slave_ctrl.start(spi_sqncr);
    apb_write(DATA_REG, master_data);
    apb_write(DIV_REG, REG_BLOCK[DIV_R]);
    apb_write(SS_REG, REG_BLOCK[SS_R]);

    REG_BLOCK[CTRL_R][8] = GO;
    slave_ctrl.REG_BLOCK[CTRL_R] = REG_BLOCK[CTRL_R];
    apb_write(CTRL_REG, REG_BLOCK[CTRL_R]);

    fork
      begin
        apb_idle_for(REG_BLOCK[DIV_R], REG_BLOCK[CTRL_R][6:0]);
        $display($time, " ns || [%s] APB Thread Ended", get_name());
      end

      begin
        slave_ctrl.start(spi_sqncr);
        $display($time, " ns || [%s] SPI Thread Ended", get_name());
      end
    join

  endtask


  constraint MASTER_DATA_RESERVED {
    master_data[127:64] == 0;
  };

  constraint SLAVE_DATA_RESERVED {
    slave_data[127:64] == 0;
  };

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