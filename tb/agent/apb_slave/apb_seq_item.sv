class apb_seq_item extends uvm_sequence_item;
 
    rand logic                        presetn;
    rand ADDR_VALUE                   paddr;
    rand logic                        pwrite;
    rand logic                        psel;
    rand logic                        penable;
    rand DATA                         pdata;  

    DATA                              expected_data;
    logic 				              pready;
    logic 				              pslverr;
    logic				              irq;

    `uvm_object_utils_begin(apb_seq_item)
         `uvm_field_int(presetn,UVM_ALL_ON)
         `uvm_field_int(pwrite,UVM_ALL_ON)
         `uvm_field_int(paddr,UVM_ALL_ON)
         `uvm_field_int(psel,UVM_ALL_ON)
         `uvm_field_int(penable,UVM_ALL_ON)
         `uvm_field_int(pdata,UVM_ALL_ON)
         `uvm_field_int(expected_data,UVM_ALL_ON)
         `uvm_field_int(pready,UVM_ALL_ON)
         `uvm_field_int(pslverr,UVM_ALL_ON)
         `uvm_field_int(irq,UVM_ALL_ON)
         
    `uvm_object_utils_end


    function new(string name = "apb_seq_item");
        super.new(name);
    endfunction: new
    
endclass: apb_seq_item
