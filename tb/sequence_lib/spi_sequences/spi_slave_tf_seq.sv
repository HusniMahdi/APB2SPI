class spi_slave_tf_seq extends spi_seq;
    `uvm_object_utils(spi_slave_tf_seq)
        
    function new(string name = "spi_slave_tf_seq");
        super.new(name);
    endfunction

    virtual task body();
      item = spi_seq_item::type_id::create("item");
      start_item(item);
      finish_item(item);
    endtask
       
endclass: spi_slave_tf_seq