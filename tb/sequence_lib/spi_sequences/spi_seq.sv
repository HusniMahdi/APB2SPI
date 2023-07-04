class spi_seq extends uvm_sequence #(spi_seq_item);
    `uvm_object_utils(spi_seq)
    
    spi_seq_item item;

    rand DATA slave_data;
    rand SPI_REG_BLOCK REG_BLOCK;
        
    function new(string name = "spi_seq");
        super.new(name);
    endfunction

    virtual task body();

    endtask
       
endclass: spi_seq