class apb_seq extends uvm_sequence #(apb_seq_item);
    `uvm_object_utils(apb_seq)
    
    apb_seq_item item;
    
    REG_VALUE             pwdata;
    ADDR_VALUE            paddr;
    bit                   do_rand;
    bit                   rand_test = 0;

    string                test_sequence;

    
    function new(string name = "apb_seq");
        super.new(name);
    endfunction

    virtual task body();

    endtask
       
endclass: apb_seq