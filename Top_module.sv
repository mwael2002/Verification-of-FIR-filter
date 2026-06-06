import uvm_pkg::*;
`include "FIR_test.sv"

module Top_module;

    parameter N = 16;
    parameter T=51;

    bit clk;

    always #2 clk=~clk;


    FIR_interface #(.N(N))FIR_IF(clk);

    FIR_transposed #(.N(N),.T(T))DUT(FIR_IF);


    initial begin

    uvm_config_db#(virtual FIR_interface)::set(null,"uvm_test_top","FIR_INTF",FIR_IF);
    run_test("FIR_test");
    end


endmodule