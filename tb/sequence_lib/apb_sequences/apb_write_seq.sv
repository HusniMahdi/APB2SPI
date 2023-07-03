class apb_write_seq extends apb_seq;
    `uvm_object_utils(apb_write_seq)
    
    function new(string name="apb_write_seq");
        super.new(name);
    endfunction 

    virtual task body();

        item = apb_seq_item::type_id::create("item");
        write(item, pwdata, paddr);

        if (pwdata[63:32]) write(item, pwdata[63:32], DATA_REG1);
        if (pwdata[95:64]) write(item, pwdata[95:64], DATA_REG2);
        if (pwdata[127:96]) write(item, pwdata[127:96], DATA_REG3);
        
    endtask

    task write (apb_seq_item item, DATA data, ADDR_VALUE addr);
        start_item(item);
        item.randomize() with {
            item.presetn == 1;
            item.psel == 1;
            item.paddr == addr;
            item.pwrite == 1;
            item.penable == 1;
            item.pdata == data;
        };        
        finish_item(item);
    endtask
        
endclass