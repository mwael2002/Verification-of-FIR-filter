// UVM Env Component
`ifndef FIR_ENV_SV
`define FIR_ENV_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "FIR_scoreboard.sv"
`include "FIR_coverage.sv"
`include "FIR_agent.sv"

class FIR_env extends uvm_env;
    `uvm_component_utils(FIR_env)

    FIR_coverage cov;
    FIR_agent ag;
    FIR_scoreboard sb;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Add your component-specific code here

    function void build_phase(uvm_phase phase);
        
        super.build_phase(phase);
        ag=FIR_agent::type_id::create("ag",this);       
        cov=FIR_coverage::type_id::create("cov",this);
        sb=FIR_scoreboard::type_id::create("sb",this);

    endfunction

    function void connect_phase(uvm_phase phase);
        
        super.connect_phase(phase);
        ag.agent_port.connect(sb.sb_export);
        ag.agent_port.connect(cov.cov_export);

    endfunction


endclass

`endif // FIR_ENV_SV
