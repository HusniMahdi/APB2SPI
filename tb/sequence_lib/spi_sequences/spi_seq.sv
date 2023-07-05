class spi_seq extends uvm_sequence #(spi_seq_item);
    `uvm_object_utils(spi_seq)
    
    spi_seq_item item;
    rand DATA slva_data, master_data;
        
    function new(string name = "spi_seq");
        super.new(name);
    endfunction

   
endclass: spi_seq