// UVM Scoreboard Component
`ifndef FIR_SCOREBOARD_SV
`define FIR_SCOREBOARD_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "FIR_seq_item.sv"

class FIR_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(FIR_scoreboard)

    uvm_analysis_export #(FIR_seq_item) sb_export;
    uvm_tlm_analysis_fifo #(FIR_seq_item) sb_fifo ;
    FIR_seq_item sc_seq_item;


    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        
        super.build_phase(phase);

        sb_fifo=new("sb_fifo",this);
        sb_export=new("sb_export",this);
        sc_seq_item=FIR_seq_item::type_id::create("sc_seq_item",this);

    endfunction


    function void connect_phase(uvm_phase phase);
        
        super.connect_phase(phase);
        sb_fifo.connect(sb_export);
        sb_fifo.size=32;

    endfunction

endclass

`endif // FIR_SCOREBOARD_SV
