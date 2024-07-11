// UVM Sequence Component
`ifndef FIR_SEQUENCE_SV
`define FIR_SEQUENCE_SV

class FIR_sequence extends uvm_sequence;
    `uvm_component_utils(FIR_sequence)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Add your component-specific code here

endclass

`endif // FIR_SEQUENCE_SV
