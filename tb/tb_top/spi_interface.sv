interface spi_interface #(int SLV_COUNT = test_param_pkg::slvCount);

  logic [SLV_COUNT -1:0] ss_pad_o;         // slave select
  logic                  sclk_pad_o;       // serial clock
  logic                  mosi_pad_o;       // master out slave in
  logic                  miso_pad_i;       // master in slave out
        
endinterface