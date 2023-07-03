class spi_seq_item extends uvm_sequence_item;

    rand DATA slave_data;
    rand SPI_REG_BLOCK REG_BLOCK;

    bit mosi_negedge, mosi_posedge;
    bit miso_negedge, miso_posedge;

    bit expected_mosi_bit;

    `uvm_object_utils_begin(spi_seq_item)
        `uvm_field_int(slave_data,UVM_ALL_ON)
        `uvm_field_int(REG_BLOCK[DATA_R0],UVM_ALL_ON)
        `uvm_field_int(REG_BLOCK[DATA_R1],UVM_ALL_ON)
        `uvm_field_int(REG_BLOCK[DATA_R2],UVM_ALL_ON)
        `uvm_field_int(REG_BLOCK[DATA_R3],UVM_ALL_ON)
        `uvm_field_int(REG_BLOCK[CTRL_R],UVM_ALL_ON)
        `uvm_field_int(REG_BLOCK[DIV_R],UVM_ALL_ON)
        `uvm_field_int(REG_BLOCK[SS_R],UVM_ALL_ON)
        `uvm_field_int(mosi_negedge,UVM_ALL_ON)
        `uvm_field_int(mosi_posedge,UVM_ALL_ON)
        `uvm_field_int(miso_negedge,UVM_ALL_ON)
        `uvm_field_int(miso_posedge,UVM_ALL_ON)
        `uvm_field_int(expected_mosi_bit,UVM_ALL_ON)
    `uvm_object_utils_end


    function new(string name = "spi_seq_item");
        super.new(name);
    endfunction: new
    
endclass: spi_seq_item
