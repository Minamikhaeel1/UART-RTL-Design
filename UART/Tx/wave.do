onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {tb signals} /top_tb/P_data_tb
add wave -noupdate -expand -group {tb signals} /top_tb/rst_tb
add wave -noupdate -expand -group {tb signals} -color Gold /top_tb/clk_tb
add wave -noupdate -expand -group {tb signals} /top_tb/data_valid_tb
add wave -noupdate -expand -group {tb signals} -color Gold /top_tb/Tx_out_tb
add wave -noupdate -expand -group {tb signals} /top_tb/busy_tb
add wave -noupdate -expand -group {tb signals} /top_tb/par_en_tb
add wave -noupdate -expand -group {tb signals} /top_tb/par_type_tb
add wave -noupdate -expand -group {fsm sig} /top_tb/DUT/fsm_inst/par_en
add wave -noupdate -expand -group {fsm sig} /top_tb/DUT/fsm_inst/ser_done
add wave -noupdate -expand -group {fsm sig} /top_tb/DUT/fsm_inst/ser_en
add wave -noupdate -expand -group {fsm sig} /top_tb/DUT/fsm_inst/mux_sel
add wave -noupdate -expand -group {fsm sig} /top_tb/DUT/fsm_inst/busy
add wave -noupdate -expand -group {fsm sig} /top_tb/DUT/fsm_inst/current_state
add wave -noupdate -expand -group {fsm sig} /top_tb/DUT/fsm_inst/next_state
add wave -noupdate -expand -group {ser sig} /top_tb/DUT/serial_inst/ser_en
add wave -noupdate -expand -group {ser sig} /top_tb/DUT/serial_inst/ser_done
add wave -noupdate -expand -group {ser sig} /top_tb/DUT/serial_inst/ser_data
add wave -noupdate -expand -group {ser sig} /top_tb/DUT/serial_inst/counter
add wave -noupdate -expand -group {ser sig} /top_tb/DUT/serial_inst/shift_reg
add wave -noupdate -expand -group {ser sig} /top_tb/DUT/serial_inst/flag
add wave -noupdate -expand -group {parity sig} /top_tb/DUT/par_inst/par_type
add wave -noupdate -expand -group {parity sig} /top_tb/DUT/par_inst/busy
add wave -noupdate -expand -group {parity sig} /top_tb/DUT/par_inst/par_bit
add wave -noupdate -expand -group {mux sig} /top_tb/DUT/mux_inst/mux_sel
add wave -noupdate -expand -group {mux sig} /top_tb/DUT/mux_inst/ser_data
add wave -noupdate -expand -group {mux sig} /top_tb/DUT/mux_inst/par_bit
add wave -noupdate -expand -group {mux sig} /top_tb/DUT/mux_inst/Tx_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {154732 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {418908 ps}
