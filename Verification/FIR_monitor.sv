// UVM Monitor Component
`ifndef FIR_MONITOR_SV
`define FIR_MONITOR_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "FIR_seq_item.sv"
import FIR_config_intf_pkg::*;
import FIR_config_output_pkg::*;


class FIR_monitor extends uvm_monitor;
    `uvm_component_utils(FIR_monitor)

    virtual FIR_interface FIR_IF_mon;
    uvm_analysis_port #(FIR_seq_item) mon_port;
    FIR_seq_item mon_seq_item;
    FIR_config_output mon_config_output;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        
            super.build_phase(phase);
            mon_port=new("mon_port",this);

    endfunction

    task run_phase(uvm_phase phase);
        
        int sig_length;
        super.run_phase(phase);
        
        forever begin
      
        mon_config_output=FIR_config_output::type_id::create("mon_config_output");
        mon_seq_item=FIR_seq_item::type_id::create("mon_seq_item");


        sig_length=$size(mon_seq_item.noisy_signal);

        for (int i=0;i<sig_length;i++) begin
                @(posedge FIR_IF_mon.clk);
                mon_seq_item.filtered_signal[i]=FIR_IF_mon.filtered_signal;
                @(negedge FIR_IF_mon.clk);
                mon_seq_item.noisy_signal[i]=FIR_IF_mon.noisy_signal;
                mon_seq_item.reset=FIR_IF_mon.reset;
                
                
        end

        
        mon_port.write(mon_seq_item); 

        #1;
        end

    endtask


endclass

`endif // FIR_MONITOR_SV
