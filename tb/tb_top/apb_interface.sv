interface apb_interface #(int ADDRWIDTH = test_param_pkg::addrWidth, DATAWIDTH = test_param_pkg::dataWidth) 
    (input bit PCLK);

    logic                        PRESETN;
    logic        [ADDRWIDTH-1:0] PADDR;
    logic                        PWRITE;

    logic                        PSEL;
    logic                        PENABLE;
    logic        [DATAWIDTH-1:0] PWDATA;
    
    logic        [DATAWIDTH-1:0] PRDATA;
    logic                        PREADY;
    
    logic                        IRQ;
        
endinterface