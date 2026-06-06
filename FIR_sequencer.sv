// UVM Sequencer Component
`ifndef FIR_SEQUENCER_SV
`define FIR_SEQUENCER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "FIR_seq_item.sv"
import FIR_config_output_pkg::*;


class FIR_sequencer extends uvm_sequencer#(FIR_seq_item);
    `uvm_component_utils(FIR_sequencer)

	function  new(string name="spi_sequencer",uvm_component parent=null);
		super.new(name,parent);
	endfunction : new


	function void build_phase(uvm_phase phase);
		
		super.build_phase(phase);

	endfunction

endclass


`endif // FIR_SEQUENCER_SV
