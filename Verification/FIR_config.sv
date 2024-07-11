package FIR_config;

import uvm_pkg::*;
`include "uvm_macros.svh"

class FIR_config_test extends uvm_object;

    `uvm_object_utils(FIR_config_test)

    virtual FIR_interface FIR_IF_config;        

    function new(string name="FIR_seq_item");
        super.new(name);
    endfunction

endclass

endpackage 