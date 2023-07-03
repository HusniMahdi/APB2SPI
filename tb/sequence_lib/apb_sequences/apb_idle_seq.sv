class apb_idle_seq extends apb_seq;
    `uvm_object_utils(apb_idle_seq)

    function new(string name="apb_idle_seq");
        super.new(name);
    endfunction 

    virtual task body();

        item = apb_seq_item::type_id::create("item");
        start_item(item);
        item.randomize() with {
            item.presetn == 1;
            item.psel == 0;
            item.paddr == 0;
            item.pwrite == 0;
            item.penable == 0;
            item.pdata == 0;
        };

        finish_item(item);

    endtask
    
endclass
