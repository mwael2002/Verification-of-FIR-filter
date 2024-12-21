// UVM sequence items
`ifndef FIR_SEQ_ITEM_SV
`define FIR_SEQ_ITEM_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

typedef enum bit { FILE_NOT_AVAILABLE,FILE_AVAILABLE } file_state;

class FIR_seq_item extends uvm_sequence_item;

    `uvm_object_utils(FIR_seq_item)

    parameter N=16;

    static local int unsigned sig_length = 1;

    rand logic reset ;    
    //Array of input signal points
    rand logic signed [N-1:0] noisy_signal [] ;
    // Array of output signal points
    rand logic signed [2*N-1:0] filtered_signal [];

    bit seq_item_state=1;

    constraint c_reset{reset==0;};

    constraint c_noisy_signal{
        foreach (noisy_signal[i]) {
            noisy_signal[i]==0;
        }
    };

    constraint c_filtered_signal{
        foreach (filtered_signal[i]) {
            filtered_signal[i]==0;
        }
    };

    function new(string name="FIR_seq_item");
        super.new(name);
        this.noisy_signal=new[sig_length];
        this.filtered_signal=new[sig_length];
        this.reset=1;
    endfunction


    function file_state get_sig(string file_name);
        
        int file_handle,i ;

        file_handle=$fopen(file_name,"r");
        
        if(!file_handle)
        `uvm_fatal("File Reading", $sformatf("Couldn't open the file: %s",file_name))

        i=0;

        while (!$feof(file_handle)) begin
        
        if(i==0) begin

            $fscanf(file_handle,"%h\n",this.sig_length);
            this.noisy_signal=new[sig_length];
            this.filtered_signal=new[sig_length];
        end 
        
        else begin
            
            $fscanf(file_handle,"%h\n",noisy_signal[i-1]);
        end


        i++;
        end 

        $fclose(file_handle);
  
        //file_handle=$fopen(file_name,"w");
        //$fclose(file_handle);

        get_sig=FILE_AVAILABLE;
        return get_sig;
    endfunction

    static function  void reset_sig_length();
        
        sig_length=1;

    endfunction

endclass


`endif 