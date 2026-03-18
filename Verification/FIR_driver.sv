// UVM Driver Component
`ifndef FIR_DRIVER_SV
`define FIR_DRIVER_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "FIR_seq_item.sv"
import FIR_config_intf_pkg::*;

class FIR_driver extends uvm_driver#(FIR_seq_item);

    `uvm_component_utils(FIR_driver)

    virtual FIR_interface FIR_IF_driver;
    FIR_seq_item driver_seq_item;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        
        super.build_phase(phase);

    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
        driver_seq_item=FIR_seq_item::type_id::create("driver_seq_item");
        seq_item_port.get_next_item(driver_seq_item);


        foreach (driver_seq_item.noisy_signal[i]) begin

                FIR_IF_driver.reset=driver_seq_item.reset;
                FIR_IF_driver.noisy_signal=driver_seq_item.noisy_signal[i];
                @(negedge FIR_IF_driver.clk);
        end

        seq_item_port.item_done();

        end

    endtask


endclass

`endif // FIR_DRIVER_SV
