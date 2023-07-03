class apb2spi_inputs_item extends uvm_sequence_item;
  `uvm_object_utils(apb2spi_inputs_item)

  rand SPI_REG_BLOCK REG_BLOCK;
  rand DATA master_data, slave_data;

  function new (string name = "apb2spi_inputs_item");
    super.new(name);
    REG_BLOCK [DATA_R0] = 0;
    REG_BLOCK [DATA_R1] = 0;
    REG_BLOCK [DATA_R2] = 0;
    REG_BLOCK [DATA_R3] = 0;
    REG_BLOCK [CTRL_R] = 0;
    REG_BLOCK [DIV_R] = 0;
    REG_BLOCK [SS_R] = 0;
  endfunction

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