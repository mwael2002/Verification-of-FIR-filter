// UVM Agent Component
`ifndef FIR_AGENT_SV
`define FIR_AGENT_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "FIR_monitor.sv"
`include "FIR_driver.sv"
`include "FIR_sequencer.sv"

class FIR_agent extends uvm_agent;
    `uvm_component_utils(FIR_agent)

    FIR_driver agent_driver;
    FIR_monitor agent_monitor;
    FIR_sequencer agent_sequencer;
    FIR_config_test agent_config_obj; 

    uvm_analysis_port #(FIR_seq_item) agent_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        
        super.build_phase(phase);
        agent_driver=FIR_driver::type_id::create("FIR_driver",this);
        agent_monitor=FIR_monitor::type_id::create("FIR_monitor",this);
        agent_sequencer=FIR_sequencer::type_id::create("FIR_sequencer",this);
        agent_config_obj=FIR_config_test::type_id::create("agent_config_obj");

        if(!uvm_config_db #(FIR_config_test):: get(this,"","FIR_CFG",agent_config_obj))
        `uvm_fatal("build_phase","test cannot get virtual DUT interface")

    endfunction

    function void connect_phase(uvm_phase phase);
        
        super.connect_phase(phase);
        agent_driver.FIR_IF_driver=agent_config_obj.FIR_IF_config;
        agent_driver.FIR_IF_mon=agent_config_obj.FIR_IF_config;
        agent_port.connect(agent_monitor.mon_port);
        agent_driver.driver_port.connect(agent_sequencer.sqr_export);
        
    endfunction


endclass

`endif // FIR_AGENT_SV
