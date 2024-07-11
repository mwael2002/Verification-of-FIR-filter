// UVM Test Component
`ifndef FIR_TEST_SV
`define FIR_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "FIR_env.sv"

class FIR_test extends uvm_test;
    
    `uvm_component_utils(FIR_test);

    FIR_env env0;
    FIR_config_test test_config_obj;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    
    function  void build_phase(uvm_phase phase);

    super.build_phase(phase);
    env0=FIR_env::type_id::create("env0",this);
    test_config_obj = FIR_config_test::type_id::create("test_config_obj",this);

        if(!uvm_config_db #(virtual FIR_interface):: get(this,"","FIR_INTF",test_config_obj.FIR_IF_config))
        `uvm_fatal("build_phase","test cannot get virtual DUT interface")

        uvm_config_db #(FIR_config_test):: set(this,"*","FIR_CFG",test_config_obj);

    endfunction


    task run_phase(uvm_phase phase);
            
        super.run_phase(phase);
        
        phase.raise_objection(this);
        //seq.start(env.ag.sqr);
        phase.drop_objection(this);

    endtask


endclass

`endif // FIR_TEST_SV
