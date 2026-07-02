onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /rx_top_tb/dut/rx_in_t
add wave -noupdate -radix decimal /rx_top_tb/dut/prescale_t
add wave -noupdate /rx_top_tb/dut/par_en_t
add wave -noupdate /rx_top_tb/dut/par_type_t
add wave -noupdate /rx_top_tb/dut/clk_t
add wave -noupdate /rx_top_tb/dut/rst_t
add wave -noupdate /rx_top_tb/dut/p_data_t
add wave -noupdate /rx_top_tb/dut/par_err_t
add wave -noupdate /rx_top_tb/dut/stop_err_t
add wave -noupdate /rx_top_tb/dut/data_valid_t
add wave -noupdate /rx_top_tb/dut/deser_en_t
add wave -noupdate -color Yellow /rx_top_tb/dut/sampled_bit_t
add wave -noupdate -radix decimal /rx_top_tb/dut/edge_cnt_t
add wave -noupdate /rx_top_tb/dut/data_samp_en_t
add wave -noupdate -radix unsigned /rx_top_tb/dut/bit_cnt_t
add wave -noupdate /rx_top_tb/dut/enable_t
add wave -noupdate /rx_top_tb/dut/strt_glich_t
add wave -noupdate /rx_top_tb/dut/par_chk_en_t
add wave -noupdate /rx_top_tb/dut/strt_chk_en_t
add wave -noupdate /rx_top_tb/dut/stp_chk_en_t
add wave -noupdate -color White /rx_top_tb/dut/deser_init/sampled_bit
add wave -noupdate -color White /rx_top_tb/dut/deser_init/deser_en
add wave -noupdate -color White -radix unsigned /rx_top_tb/dut/deser_init/bit_cnt
add wave -noupdate -color White -radix decimal /rx_top_tb/dut/deser_init/edge_cnt
add wave -noupdate /rx_top_tb/dut/deser_init/p_data
add wave -noupdate /rx_top_tb/dut/deser_init/shift_reg
add wave -noupdate /rx_top_tb/dut/fsm_init/Rx_in
add wave -noupdate /rx_top_tb/dut/fsm_init/bit_cnt
add wave -noupdate /rx_top_tb/dut/fsm_init/par_err
add wave -noupdate -color {Slate Blue} /rx_top_tb/dut/fsm_init/strt_glitch
add wave -noupdate /rx_top_tb/dut/fsm_init/stp_err
add wave -noupdate /rx_top_tb/dut/fsm_init/par_en
add wave -noupdate /rx_top_tb/dut/fsm_init/dat_samp_en
add wave -noupdate /rx_top_tb/dut/fsm_init/enable
add wave -noupdate /rx_top_tb/dut/fsm_init/deser_en
add wave -noupdate /rx_top_tb/dut/fsm_init/data_valid
add wave -noupdate /rx_top_tb/dut/fsm_init/stp_chk_en
add wave -noupdate /rx_top_tb/dut/fsm_init/strt_chk_en
add wave -noupdate /rx_top_tb/dut/fsm_init/par_chk_en
add wave -noupdate /rx_top_tb/dut/fsm_init/stop_order
add wave -noupdate -color Turquoise /rx_top_tb/dut/fsm_init/current_state
add wave -noupdate -color Turquoise /rx_top_tb/dut/fsm_init/next_state
add wave -noupdate /rx_top_tb/dut/edge_cnt_init/enable
add wave -noupdate /rx_top_tb/dut/edge_cnt_init/prescale
add wave -noupdate -radix unsigned /rx_top_tb/dut/edge_cnt_init/bit_cnt
add wave -noupdate /rx_top_tb/dut/edge_cnt_init/edge_cnt
add wave -noupdate /rx_top_tb/dut/par_check_init/par_type
add wave -noupdate /rx_top_tb/dut/par_check_init/par_chk_en
add wave -noupdate /rx_top_tb/dut/par_check_init/sampled_bit
add wave -noupdate /rx_top_tb/dut/par_check_init/P_data
add wave -noupdate /rx_top_tb/dut/par_check_init/par_err
add wave -noupdate /rx_top_tb/dut/strt_check_init/strt_chk_en
add wave -noupdate /rx_top_tb/dut/strt_check_init/sampled_bit
add wave -noupdate /rx_top_tb/dut/strt_check_init/strt_glitch
add wave -noupdate /rx_top_tb/dut/stop_check_init/stp_chk_en
add wave -noupdate /rx_top_tb/dut/stop_check_init/sampled_bit
add wave -noupdate /rx_top_tb/dut/stop_check_init/stp_err
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {86590488 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 260
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {80236050 ps} {98400756 ps}
