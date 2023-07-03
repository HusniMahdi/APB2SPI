class reset_test_seq extends vseq_base;
  `uvm_object_utils(reset_test_seq)

  function new(string name = "reset_test_seq");
  super.new(name);
  endfunction

  virtual task pre_body();
    super.pre_body();
  endtask

  virtual task body();

    reset();

    apb_read_all();

  endtask


endclass