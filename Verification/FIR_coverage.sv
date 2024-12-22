// UVM Coverage Component
`ifndef FIR_COVERAGE_SV
`define FIR_COVERAGE_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "FIR_seq_item.sv"

class FIR_coverage extends uvm_component;
    `uvm_component_utils(FIR_coverage)

    parameter N=16;
    logic reset; 
    logic signed [N-1:0] noisy_signal;
    // Array of output signal points
    logic signed [N-1:0] filtered_signal;

    uvm_analysis_export #(FIR_seq_item) cov_export;
    uvm_tlm_analysis_fifo #(FIR_seq_item) cov_fifo ;
    FIR_seq_item cov_seq_item;

    covergroup c1;
    
    c_reset: coverpoint this.reset;
    c_noisy_signal: coverpoint this.noisy_signal{
        option.auto_bin_max=512;
    }
    c_filtered_signal: coverpoint this.filtered_signal{
        option.auto_bin_max=512;
        ignore_bins ignore_range_pos []= {[signed'(16'b0010_0000_0000_0000):signed'(16'b0111_1111_1111_1111)]};
        ignore_bins ignore_range_neg []= {[signed'(16'b1000_0000_0000_0000):signed'(16'b1110_0000_0000_0000)]};
    }
    
    endgroup

    function new(string name, uvm_component parent);
        super.new(name, parent);
        this.c1=new();
    endfunction

    function void build_phase(uvm_phase phase);
        
        super.build_phase(phase);

        cov_fifo=new("cov_fifo",this);
        cov_export=new("cov_export",this);
        cov_seq_item=FIR_seq_item::type_id::create("cov_seq_item",this);

    endfunction


    function void connect_phase(uvm_phase phase);
        
        super.connect_phase(phase);
        cov_export.connect(cov_fifo.analysis_export);

    endfunction

    task run_phase(uvm_phase phase);
            super.run_phase(phase);
            

	        //`uvm_info("run_phase","coverage run phase has started",UVM_LOW);
            forever begin
                int i,sig_length;
	            cov_fifo.get(cov_seq_item);
                sig_length=$size(cov_seq_item.noisy_signal);

                for (i=0; i<sig_length;i++) begin
                    this.reset=cov_seq_item.reset;
                    this.noisy_signal=cov_seq_item.noisy_signal[i];
                    this.filtered_signal=cov_seq_item.filtered_signal[i][2*N-1:N];
                    this.c1.sample();

                end
                
	        end
    endtask 

endclass

`endif // FIR_COVERAGE_SV
