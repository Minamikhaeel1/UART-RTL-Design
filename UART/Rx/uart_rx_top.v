module uart_rx_top (
input rx_in_t,
input [5:0]prescale_t,
input par_en_t,
input par_type_t,
input clk_t,
input rst_t , 
output [7:0] p_data_t,
output par_err_t,
output stop_err_t,
output data_valid_t
);

wire deser_en_t;
wire sampled_bit_t ; 
wire [5:0] edge_cnt_t;
wire data_samp_en_t ; 
wire [3:0] bit_cnt_t;
wire enable_t ; 
wire strt_glich_t;
wire par_chk_en_t;
wire strt_chk_en_t;
wire stp_chk_en_t;

fsm fsm_init(
.Rx_in(rx_in_t),
.bit_cnt(bit_cnt_t),
.par_err(par_err_t),
.strt_glitch(strt_glich_t),
.stp_err(stop_err_t),
.par_en(par_en_t),
.clk(clk_t),
.rst(rst_t),
.dat_samp_en(data_samp_en_t),
.enable(enable_t),
.deser_en(deser_en_t),
.data_valid(data_valid_t),
.stp_chk_en(stp_chk_en_t),
.strt_chk_en(strt_chk_en_t),
.par_chk_en(par_chk_en_t),
.edge_cnt(edge_cnt_t),
.prescale(prescale_t)

);

deser deser_init(
.sampled_bit(sampled_bit_t),
.deser_en(deser_en_t),
.bit_cnt(bit_cnt_t),
.edge_cnt(edge_cnt_t),
.prescale(prescale_t),
.clk(clk_t),
.rst(rst_t),
.p_data(p_data_t),
.par_en(par_en_t)

);
data_samp data_samp_init(
.Rx_in(rx_in_t),
.prescale(prescale_t),
.data_samp_en(data_samp_en_t),
.edge_cnt(edge_cnt_t),
.clk(clk_t),
.rst(rst_t),
.sampled_bit(sampled_bit_t)
);


edge_cnt edge_cnt_init(
.clk(clk_t),
.rst(rst_t),
.enable(enable_t),
.prescale(prescale_t),
.bit_cnt(bit_cnt_t),
.edge_cnt(edge_cnt_t)
);


par_check par_check_init(
.par_type(par_type_t),
.par_chk_en(par_chk_en_t),
.sampled_bit(sampled_bit_t),
.P_data(p_data_t),
.par_err(par_err_t)
);


strt_check strt_check_init(
.strt_chk_en(strt_chk_en_t),
.sampled_bit(sampled_bit_t),
.strt_glitch(strt_glich_t)
);


stop_check stop_check_init(
.stp_chk_en(stp_chk_en_t),
.sampled_bit(sampled_bit_t),
.stp_err(stop_err_t)
);

endmodule


