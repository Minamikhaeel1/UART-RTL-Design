vlib work 
vlog *.*v
vsim -voptargs=+acc work.rx_top_tb
do wave.do	
run -all
