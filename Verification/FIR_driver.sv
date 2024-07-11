// UVM Driver Component
`ifndef FIR_DRIVER_SV
`define FIR_DRIVER_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "FIR_seq_item.sv"
import FIR_config_test::FIR_config_test;

class FIR_driver extends uvm_driver;
    `uvm_component_utils(FIR_driver)

    uvm_analysis_port driver_port;
    virtual FIR_interface FIR_IF_driver;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        
        super.build_phase(phase);
        driver_port=new("driver_port",this);

    endfunction

endclass

`endif // FIR_DRIVER_SV
