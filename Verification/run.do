vlib work
vmap work work
vlog *.v *.sv +cover -covercells 

vsim -voptargs=+acc work.Top_module -classdebug -uvmcontrol=all -coverage -onfinish stop

add wave -position insertpoint  \
sim:/Top_module/FIR_IF/reset \
sim:/Top_module/FIR_IF/noisy_signal \
sim:/Top_module/FIR_IF/filtered_signal \
sim:/Top_module/FIR_IF/clk


run -all
coverage save FIR_code_cov.ucdb -instance DUT
coverage save FIR_func_cov.ucdb -cvg
 
vcover report FIR_code_cov.ucdb -details -annotate -all -output code_coverage_rpt.txt
vcover report FIR_func_cov.ucdb -details -annotate -all -output func_coverage_rpt.txt