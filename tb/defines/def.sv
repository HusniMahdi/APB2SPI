// REG ADDRESSES
parameter DATA_REG       =   32'h00;
parameter DATA_REG0      =   32'h00;
parameter DATA_REG1      =   32'h04;
parameter DATA_REG2      =   32'h08;
parameter DATA_REG3      =   32'h0C;
parameter CTRL_REG       =   32'h10;
parameter DIV_REG        =   32'h14;
parameter SS_REG         =   32'h18;

// CTRL FIELDS
parameter ASS = 1'b1;
parameter MSS = 1'b0;

parameter IE = 1'b1;

parameter LSB = 1'b1;
parameter MSB = 1'b0;

parameter TX_NEG = 1'b1;
parameter TX_POS = 1'b0;

parameter NEG = 1'b1;
parameter POS = 1'b0;

parameter RX_NEG = 1'b1;
parameter RX_POS = 1'b0;

parameter GO = 1'b1;
parameter BUSY = 1'b0;

parameter RSV = 1'b0;

typedef struct packed {

    bit [17:0] reserved;
    bit auto_ss;
    bit int_enb;
    bit first_bit;
    bit Tx;
    bit Rx;
    bit Go_Busy;
    bit reserved2;
    bit [6:0] Char_Len;

} CTRL_VECTOR;