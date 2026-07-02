vlib work 
vlog *.*v
vsim -voptargs=+acc work.top_tb
do wave.do	
run -all