`timescale 1ns / 1ps

`ifndef RST_SEQ
`define RST_SEQ

class apb_reset_seq extends apb_seq;
    `uvm_object_utils(apb_reset_seq)
    
    apb_seq_item item;

    function new(string name="apb_reset_seq");
        super.new(name);
    endfunction 

    virtual task body();

        item = apb_seq_item::type_id::create("item");
        start_item(item);
        item.randomize() with {
            item.presetn == 0;
            item.psel == 0;
            item.paddr == 0;
            item.pwrite == 0;
            item.penable == 0;
            item.pdata == 0;
        };

        finish_item(item);

    endtask

endclass

`endif
