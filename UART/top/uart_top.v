module UART 

(
 input                             RST,
 input                             TX_CLK,
 input                             RX_CLK,
 input                             RX_IN_S,
 output     [7:0]       RX_OUT_P, 
 output                            RX_OUT_V,
 input      [7:0]       TX_IN_P, 
 input                             TX_IN_V, 
 output                            TX_OUT_S,
 output                            TX_OUT_V,  
 input      [5:0]                  Prescale, 
 input                             parity_enable,
 input                             parity_type,
 output                            parity_error,
 output                            framing_error
);

top UART_TX (
.clk_t(TX_CLK),
.rst_t(RST),
.P_data_t(TX_IN_P),
.data_valid_t(TX_IN_V),
.par_en_t(parity_enable),
.par_type_t(parity_type), 
.Tx_out_t(TX_OUT_S),
.busy_t(TX_OUT_V)
);
 
 
uart_rx_top UART_RX (
.clk_t(RX_CLK),
.rst_t(RST),
.rx_in_t(RX_IN_S),
.prescale_t(Prescale),
.par_en_t(parity_enable),
.par_type_t(parity_type),
.p_data_t(RX_OUT_P), 
.data_valid_tb(RX_OUT_V),
.par_err_t(parity_error),
.stop_err_t(framing_error)
);
 



endmodule