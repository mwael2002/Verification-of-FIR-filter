vlib work
vlog transposed_block.v FIR_transposed.sv FIR_interface.sv FIR_seq_item.sv FIR_config.sv FIR_driver.sv  FIR_agent.sv FIR_monitor.sv FIR_scoreboard.sv  \
FIR_coverage.sv FIR_sequence.sv FIR_sequencer.sv FIR_env.sv FIR_test.sv Top_module.sv +cover

vsim -voptargs=+acc work.Top_module -classdebug -uvmcontrol=all -coverage 

add wave -position insertpoint  \
sim:/Top_module/FIR_IF/reset \
sim:/Top_module/FIR_IF/noisy_signal \
sim:/Top_module/FIR_IF/filtered_signal \
sim:/Top_module/FIR_IF/clk


run -all
coverage save FIR.ucdb -du Top_module 
#-du Top_module/DUT/ 
vcover report FIR.ucdb -details -annotate -all -output coverage_rpt.txt