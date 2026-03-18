// UVM Test Component
`ifndef FIR_TEST_SV
`define FIR_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "FIR_env.sv"
`include "FIR_seq_item.sv"
`include "FIR_sequence.sv"

import FIR_config_intf_pkg::*;


class FIR_test extends uvm_test;
    
    `uvm_component_utils(FIR_test);

    FIR_env env;
    FIR_config_test test_config_obj;
    FIR_sequence seq;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    
    function  void build_phase(uvm_phase phase);

    `uvm_info("BUILD_PHASE", "Starting build_phase", UVM_LOW)

    super.build_phase(phase);
    env=FIR_env::type_id::create("env",this);
    seq=FIR_sequence::type_id::create("seq",this);
    test_config_obj = FIR_config_test::type_id::create("test_config_obj");

        if(!uvm_config_db #(virtual FIR_interface):: get(this,"","FIR_INTF",test_config_obj.FIR_IF_config))
        `uvm_fatal("BUILD_PHASE","test cannot get virtual DUT interface")

        uvm_config_db #(FIR_config_test)::set(this,"env.ag","FIR_CFG",test_config_obj);

    `uvm_info("BUILD_PHASE", "Ending build_phase", UVM_LOW)

    endfunction


    task run_phase(uvm_phase phase);
            
        super.run_phase(phase);

        `uvm_info("RUN_PHASE", "Starting run_phase", UVM_LOW)
        
        phase.raise_objection(this);
        seq.start(env.ag.agent_sequencer);
        phase.drop_objection(this);

        `uvm_info("RUN_PHASE", "Ending run_phase", UVM_LOW)

    endtask


endclass

`endif // FIR_TEST_SV
