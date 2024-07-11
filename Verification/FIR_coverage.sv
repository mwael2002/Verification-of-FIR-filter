// UVM Coverage Component
`ifndef FIR_COVERAGE_SV
`define FIR_COVERAGE_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "FIR_seq_item.sv"

class FIR_coverage extends uvm_component;
    `uvm_component_utils(FIR_coverage)

    uvm_analysis_export #(FIR_seq_item) cov_export;
    uvm_tlm_analysis_fifo #(FIR_seq_item) cov_fifo ;
    FIR_seq_item cov_seq_item;


    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        
        super.build_phase(phase);

        cov_fifo=new("cov_fifo",this);
        cov_export=new("cov_export",this);
        cov_seq_item=FIR_seq_item::type_id::create("cov_seq_item",this);

    endfunction


    function void connect_phase(uvm_phase phase);
        
        super.connect_phase(phase);
        cov_fifo.connect(cov_export);
        cov_fifo.size=32;

    endfunction

endclass

`endif // FIR_COVERAGE_SV
