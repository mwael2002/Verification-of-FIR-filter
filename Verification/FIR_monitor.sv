// UVM Monitor Component
`ifndef FIR_MONITOR_SV
`define FIR_MONITOR_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "FIR_seq_item.sv"
import FIR_config_test::FIR_config_test;

class FIR_monitor extends uvm_monitor;
    `uvm_component_utils(FIR_monitor)

    virtual FIR_interface FIR_IF_mon;
    uvm_analysis_port #(FIR_seq_item) mon_port;


    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        
            super.build_phase(phase);
            mon_port=new("mon_port",this);

    endfunction

endclass

`endif // FIR_MONITOR_SV
