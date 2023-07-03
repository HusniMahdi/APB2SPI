`timescale 1ns / 1ps

`ifndef COV
`define COV

class apb_cov extends uvm_subscriber #(apb_seq_item);
   `uvm_component_utils(apb_cov);

   apb_seq_item mntr_item;
        
   covergroup apb_read_cg;
                                                     
        // ADDRESS: coverpoint mntr_item.paddr {
        //     bins ADRS [8] = {[0:255]};
        // }
    
        // DATA: coverpoint mntr_item.data {
        //     bins DATA [8] = {[0:2**30]};
        //     bins BIG_DATA [2] = {[2**30:2**32]};
        // }

        // PWRITE: coverpoint mntr_item.pwrite{
        //     bins READ = {0};
        //     bins WRITE = {1};
        // }

        // READ_OPP: cross PWRITE, DATA, ADDRESS {
        //     ignore_bins igb1 = binsof(PWRITE.WRITE);
        // }

        // WRITE_OPP: cross PWRITE, DATA, ADDRESS {
        //     ignore_bins igb2 = binsof(PWRITE.READ);
        // }

                
   endgroup: apb_read_cg

 
   function new(string name = "apb_cov", uvm_component parent = null);
       super.new(name, parent);
                
       apb_read_cg = new();

   endfunction

   function void write(apb_seq_item t);
       mntr_item = t;
    //    $display($time, " [COV] pwrite = %d || paddr = %d || data = %d ", mntr_item.pwrite, mntr_item.paddr, mntr_item.data);
       apb_read_cg.sample();
   endfunction
    
endclass


`endif