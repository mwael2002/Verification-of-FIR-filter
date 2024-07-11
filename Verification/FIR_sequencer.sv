// UVM Sequencer Component
`ifndef FIR_SEQUENCER_SV
`define FIR_SEQUENCER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "FIR_seq_item.sv"

class FIR_sequencer extends uvm_sequencer;
    `uvm_component_utils(FIR_sequencer)

	uvm_analysis_export #(FIR_seq_item) sqr_export;

	function  new(string name="spi_sequencer",uvm_component parent=null);
		super.new(name,parent);
	endfunction : new


	function void build_phase(uvm_phase phase);
		
		super.build_phase(phase);
		sqr_export=new("sqr_export",this);

	endfunction

endclass

`endif // FIR_SEQUENCER_SV
