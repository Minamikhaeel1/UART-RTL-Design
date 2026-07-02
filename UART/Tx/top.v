module top #(parameter size = 8)(
input [size -1 : 0] P_data_t ,
input data_valid_t , 
input par_en_t , 
input par_type_t , 
input clk_t , 
input rst_t ,
output Tx_out_t , 
output busy_t
);

wire ser_done_t ;
wire ser_en_t ; 
wire par_bit_t ;
wire ser_data_t;
wire [1:0] mux_sel_t;



fsm fsm_inst (
.data_valid(data_valid_t),
.par_en(par_en_t),
.ser_done(ser_done_t),
.clk(clk_t),
.rst(rst_t),
.ser_en(ser_en_t),
.mux_sel(mux_sel_t),
.busy(busy_t)

);

ser serial_inst (
.P_data(P_data_t),
.ser_en(ser_en_t),
.ser_done(ser_done_t),
.ser_data(ser_data_t),
.clk(clk_t),
.rst(rst_t)

);

parity par_inst (
.data_valid(data_valid_t),
.P_data(P_data_t),
.par_type(par_type_t),
.par_bit(par_bit_t),
.busy(busy_t)
);

mux mux_inst (
.mux_sel(mux_sel_t),
.ser_data(ser_data_t),
.par_bit(par_bit_t),
.Tx_out(Tx_out_t)

);




endmodule