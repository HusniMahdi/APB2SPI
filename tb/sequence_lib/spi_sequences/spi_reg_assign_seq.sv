// class spi_reg_assign_seq extends spi_seq;
//   `uvm_object_utils(spi_reg_assign_seq)

//   rand SPI_REG_BLOCK REG_BLOCK;
//   import apb_seq_pkg::apb_write_seq ;
//   import apb_agent_pkg::apb_sequencer ;

//   apb_write_seq write_seq;
//   apb_sequencer apb_sqncr;


//   function new(string name = "spi_reg_assign_seq");
//     super.new(name);
//   endfunction

//   virtual task body ();

//     REG_BLOCK[CTRL_R][8] = BUSY;
//     apb_write_ctrl (REG_BLOCK[CTRL_R]);
//     apb_write_data ({REG_BLOCK[DATA_R3], REG_BLOCK[DATA_R2], REG_BLOCK[DATA_R1], REG_BLOCK[DATA_R0]});
//     apb_write_div (REG_BLOCK[DIV_R]);
//     apb_write_ss (REG_BLOCK[SS_R]);

//   endtask

//   task apb_write_ctrl(REG_VALUE data);
//     write_seq = apb_write_seq::type_id::create("write_seq");
//     write_seq.paddr = CTRL_REG;
//     write_seq.pwdata  = data;
//     write_seq.start(apb_sqncr);
//   endtask

//   task apb_write_div(REG_VALUE data);
//     write_seq = apb_write_seq::type_id::create("write_seq");
//     write_seq.paddr = DIV_REG;
//     write_seq.pwdata  = data;
//     write_seq.start(apb_sqncr);
//   endtask

//   task apb_write_ss(REG_VALUE data);
//     write_seq = apb_write_seq::type_id::create("write_seq");
//     write_seq.paddr = SS_REG;
//     write_seq.pwdata  = data;
//     write_seq.start(apb_sqncr);
//   endtask

//   task apb_write_data(DATA data);
//     write_seq = apb_write_seq::type_id::create("write_seq");
    
//     write_seq.paddr = DATA_REG0;
//     write_seq.pwdata  = data[31:0];
//     write_seq.start(apb_sqncr);

//     if (data[63:32]) begin
//       write_seq.paddr = DATA_REG1;
//       write_seq.pwdata  = data[63:32];
//       write_seq.start(apb_sqncr);                
//     end

//     if (data[95:64]) begin
//       write_seq.paddr = DATA_REG2;
//       write_seq.pwdata  = data[95:64];
//       write_seq.start(apb_sqncr);                
//     end

//     if (data[127:96]) begin
//       write_seq.paddr = DATA_REG3;
//       write_seq.pwdata  = data[127:96];
//       write_seq.start(apb_sqncr);                
//     end

//   endtask


//   // constraint MASTER_DATA_RESERVED {
//   //   // REG_BLOCK[DATA_R0] == 0;
//   //   // REG_BLOCK[DATA_R1] == 0;
//   //   REG_BLOCK[DATA_R2] == 0;
//   //   REG_BLOCK[DATA_R3] == 0;
//   // };

//   // constraint CTRL_BLOCK_RESERVED {
//   //   REG_BLOCK[CTRL_R][31:14] == 0;
//   //   REG_BLOCK[CTRL_R][7] == 0;
//   //   REG_BLOCK[CTRL_R][8] == 0;
//   //   REG_BLOCK[CTRL_R][6:0] <= 64;
//   // };

//   // constraint DIV_BLOCK_RESERVED {
//   //   REG_BLOCK[DIV_R][31:4] == 0;
//   // };

//   // constraint SS_BLOCK_RESERVED {
//   //   REG_BLOCK[SS_R][31:8] == 0;
//   // };


// endclass