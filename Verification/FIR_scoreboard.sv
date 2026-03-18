// UVM Scoreboard Component
`ifndef FIR_SCOREBOARD_SV
`define FIR_SCOREBOARD_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "FIR_seq_item.sv"

class FIR_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(FIR_scoreboard)

    parameter N=16,frac_part=(2*N-3);

    uvm_analysis_export #(FIR_seq_item) sb_export;
    uvm_tlm_analysis_fifo #(FIR_seq_item) sb_fifo ;
    FIR_seq_item sc_seq_item;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        sb_fifo=new("sb_fifo",this);
        sb_export=new("sb_export",this);
    endfunction


    function void connect_phase(uvm_phase phase);
        
        super.connect_phase(phase);
        sb_export.connect(sb_fifo.analysis_export);

    endfunction

    task run_phase(uvm_phase phase);
		super.run_phase(phase);

	 forever begin
            
        string file_names[4]={"output_sig_half_KHz.txt","output_sig_1_KHz.txt","output_sig_3_KHz.txt","output_audio.txt"};
        static int j=0;
        
        int file_handle,file_handle_2,sig_length,dut_int_point,golden_int_point;
        int error_count=0;   
        real golden_filtered_signal_point,dut_filtered_signal_point;
        real x_2=0,x_noise=0,snr;            
        int f;

        sc_seq_item=FIR_seq_item::type_id::create("sc_seq_item",this);

        sb_fifo.get(sc_seq_item);
        `uvm_info("Scoreboard","Scoreboard recieved sequence item successfully",UVM_HIGH);

        if(sc_seq_item.reset==0)begin    
        continue;
        end

        if(j==3)
        file_handle_2=$fopen("output_dut_audio.txt","w");

        // Reading output file
        file_handle=$fopen(file_names[j],"r");
        if(!file_handle)
        `uvm_fatal("Scoreboard", $sformatf("Couldn't open the file: %s",file_names[j]))

        // Compare Output from Matlab w ith the one from DUT
        sig_length=$size(sc_seq_item.noisy_signal);
        for (int i=0;i<sig_length;i++) begin

            $fscanf(file_handle,"%f",golden_filtered_signal_point);
            
            // Round golden point to it 4 decimals after point
            golden_int_point=$rtoi(golden_filtered_signal_point*10000);
            
            // Convert dut signal into real type then round it 4 decimals after point
            dut_filtered_signal_point=(sc_seq_item.filtered_signal[i]*1.0/({1'b1,{frac_part{1'b0}}}));
            dut_int_point=$rtoi(dut_filtered_signal_point * 10000);         
                
                if((golden_int_point>dut_int_point && (golden_int_point-dut_int_point>3)) ||
                   (dut_int_point>golden_int_point && (dut_int_point-golden_int_point>3)))
                begin                
                    error_count++;
                end 
            
            if(j==3) begin          
            $fdisplay(file_handle_2,dut_filtered_signal_point);
            end
         end

         if(error_count>0) begin
            `uvm_error("OUTPUT COMPARISON_FAIL",$sformatf("In signal no. %0d: There are %0d points have difference between DUT and Golden exceeds 0.03%% ,total signal points = %0d, (number of wrong points / total signal points) percentage  = %f",j,error_count,sig_length,(error_count*100.0/sig_length)))
        end

        else begin
            `uvm_info("OUTPUT COMPARISON_SUCCESS",$sformatf("Scoreboaed compared signal no. %0d successfully, all points have difference between DUT and Golden less than 0.03%%",j),UVM_MEDIUM) 
        end
        

        if (j==3)
        $fclose(file_handle_2);
        
        else begin
        $fclose(file_handle);

        // Open file & close it to erase it
        file_handle=$fopen(file_names[j],"w");
        $fclose(file_handle);
        end

        j++;
     end
    endtask

endclass

`endif 
