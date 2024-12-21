package FIR_config_intf_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

class FIR_config_test extends uvm_object;

    `uvm_object_utils(FIR_config_test)

    virtual FIR_interface FIR_IF_config;        

    function new(string name="FIR_config_test");
        super.new(name);
    endfunction

endclass

endpackage

package FIR_config_output_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

typedef enum bit [1:0] {OUTPUT_NOT_FINISHED, OUTPUT_NOT_IN_SCOREBOARD,OUTPUT_IN_SCOREBOARD,OUTPUT_FINISHED } output_state;

class FIR_config_output extends uvm_object;
    
      `uvm_object_utils(FIR_config_output)

      bit seq_item_state;


      function new(string name="FIR_config_output");
        super.new(name);

        seq_item_state=1;

      endfunction


endclass 

endpackage