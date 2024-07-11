// UVM sequence items
`ifndef FIR_SEQ_ITEM_SV
`define FIR_SEQ_ITEM_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class FIR_seq_item extends uvm_sequence_item;

    `uvm_object_utils(FIR_seq_item)

    parameter N=16,sig_length = 221;

    rand logic reset ;
    logic signed [N-1:0] noisy_signal [] , filtered_signal;
    

    function new(string name="FIR_seq_item");
        super.new(name);
    endfunction


    function void get_sig(string file_name);
        
        int file_handle,i ;
        int sig_length=noisy_signal.size();

        noisy_signal=new[sig_length];

        file_handle=$fopen(file_name,"r");


        while (noisy_signal[0]==={N{1'bx}})
        $fscanf(file_handle,"%d",noisy_signal[0]);

        i=1;

        while (!$feof(file_handle)) begin

        $fscanf(file_handle,"%d",noisy_signal[i]);
        i++;

        end 

        $fclose(file_handle);
  
        file_handle=$fopen(file_name,"w");
        $fclose(file_handle);

    endfunction

endclass

`endif 