class transfer_test_seq extends vseq_base;
  `uvm_object_utils(transfer_test_seq)


  int repeat_times;

  function new(string name = "transfer_test_seq");
  super.new(name);
  endfunction

  virtual task pre_body();
    super.pre_body();
  endtask

  virtual task body();

    reset();

    repeat (5) begin
      inputs_i.randomize();
      complete_transfer (inputs_i);
      apb_read_all();
    end

  endtask

  task complete_transfer (apb2spi_inputs_item item);

    apb_write(CTRL_REG, item.REG_BLOCK[CTRL_R]);
    slave_ctrl.slave_data = item.slave_data;
    slave_ctrl.REG_BLOCK[CTRL_R] = item.REG_BLOCK[CTRL_R];
    slave_ctrl.start(spi_sqncr);
    apb_write(DATA_REG, item.master_data);
    apb_write(DIV_REG, item.REG_BLOCK[DIV_R]);
    apb_write(SS_REG, item.REG_BLOCK[SS_R]);

    item.REG_BLOCK[CTRL_R][8] = GO;
    slave_ctrl.REG_BLOCK[CTRL_R] = item.REG_BLOCK[CTRL_R];
    apb_write(CTRL_REG, item.REG_BLOCK[CTRL_R]);

    fork
      begin
        apb_idle_for(item.REG_BLOCK[DIV_R], item.REG_BLOCK[CTRL_R][6:0]);
        $display($time, " ns || [%s] APB Thread Ended", get_name());
      end

      begin
        slave_ctrl.start(spi_sqncr);
        $display($time, " ns || [%s] SPI Thread Ended", get_name());
      end
    join

  endtask



endclass