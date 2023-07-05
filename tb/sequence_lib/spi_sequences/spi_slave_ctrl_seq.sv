class spi_slave_ctrl_seq extends spi_seq;
    `uvm_object_utils(spi_slave_ctrl_seq)
    
    rand DATA slave_data;
    rand REG_VALUE CTRL;

    function new(string name = "spi_slave_ctrl_seq");
        super.new(name);
    endfunction

    virtual task body();
      item = spi_seq_item::type_id::create("item");

      start_item(item);
      item.randomize() with {
        item.slave_data == local::slave_data;
        item.REG_BLOCK[CTRL_R] == local::CTRL;
      };        
      finish_item(item);

    endtask
       
endclass: spi_slave_ctrl_seq