class apb_write_seq extends apb_seq;
	`uvm_object_utils(apb_write_seq)

	function new(string name="apb_write_seq");
		super.new(name);
	endfunction 

	virtual task body();

		item = apb_seq_item::type_id::create("item");
		start_item(item);
		item.randomize() with {
			item.presetn == 1;
			item.psel == 1;
			item.paddr == local::paddr;
			item.pwrite == 1;
			item.penable == 1;
			item.pdata == local::pwdata;
		};
		finish_item(item);


	endtask

endclass