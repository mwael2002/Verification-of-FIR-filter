// UVM Sequence Component
`ifndef FIR_SEQUENCE_SV
`define FIR_SEQUENCE_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "FIR_seq_item.sv"
import FIR_config_output_pkg::*;


class FIR_sequence extends uvm_sequence #(FIR_seq_item);
    `uvm_object_utils(FIR_sequence)


    FIR_seq_item reset_seq_item;
    FIR_seq_item freq_1_KHz_seq_item;
    FIR_seq_item freq_3_KHz_seq_item;
    FIR_seq_item freq_half_KHz_seq_item;
    FIR_seq_item audio_seq_item;

    function new(string name="seq0");
        super.new(name);
    endfunction

    task body;

    reset_seq_item=FIR_seq_item::type_id::create("seq_item_reset");
    freq_half_KHz_seq_item=FIR_seq_item::type_id::create("seq_item_half_KHz");
    freq_1_KHz_seq_item=FIR_seq_item::type_id::create("seq_item_1_KHz");
    freq_3_KHz_seq_item=FIR_seq_item::type_id::create("seq_item_3_KHz");
    audio_seq_item=FIR_seq_item::type_id::create("audio_seq_item");

    /**********************Reset frequency item***************************************************/
    
    assert(reset_seq_item.randomize());
    start_item(reset_seq_item);
    finish_item(reset_seq_item);

    `uvm_info("SEQ_ITEM", "Reset item has run successfully", UVM_MEDIUM)


    /**********************First frequency item***************************************************/


    while(freq_half_KHz_seq_item.get_sig("input_sig_half_KHz.txt")==FILE_NOT_AVAILABLE);
    
    `uvm_info("FILE_READING", "First file has been read successfully", UVM_MEDIUM)

    start_item(freq_half_KHz_seq_item);
    finish_item(freq_half_KHz_seq_item);


    `uvm_info("SEQ_ITEM", "First item has run successfully", UVM_MEDIUM)

    /**********************Second frequency item***************************************************/

    //Reset the flip flops before sending the second item
    FIR_seq_item::reset_sig_length();
    assert(reset_seq_item.randomize());
    start_item(reset_seq_item);
    finish_item(reset_seq_item);


    while(freq_1_KHz_seq_item.get_sig("input_sig_1_KHz.txt")==FILE_NOT_AVAILABLE);

    `uvm_info("FILE_READING", "Second file has been read successfully", UVM_MEDIUM)

    start_item(freq_1_KHz_seq_item);
    finish_item(freq_1_KHz_seq_item);

    `uvm_info("SEQ_ITEM", "Second item has run successfully", UVM_MEDIUM)

    /**********************Third frequency item***************************************************/

    //Reset the flip flips before sending the second item
    FIR_seq_item::reset_sig_length();
    assert(reset_seq_item.randomize());
    start_item(reset_seq_item);
    finish_item(reset_seq_item);


    
    while(freq_3_KHz_seq_item.get_sig("input_sig_3_KHz.txt")==FILE_NOT_AVAILABLE);

    `uvm_info("FILE_READING", "Third file has been read successfully", UVM_MEDIUM)

    start_item(freq_3_KHz_seq_item);
    finish_item(freq_3_KHz_seq_item);

    `uvm_info("SEQ_ITEM", "Third item has run successfully", UVM_MEDIUM)
 
    /**********************Audio frequency item***************************************************/
    //Reset the flip flips before sending the second item
    FIR_seq_item::reset_sig_length();
    assert(reset_seq_item.randomize());
    start_item(reset_seq_item);
    finish_item(reset_seq_item); 


    while(audio_seq_item.get_sig("input_audio.txt")==FILE_NOT_AVAILABLE);

    `uvm_info("FILE_READING", "audio file has been read successfully", UVM_MEDIUM)

    start_item(audio_seq_item);
    finish_item(audio_seq_item);

    `uvm_info("SEQ_ITEM", "audio item has run successfully", UVM_MEDIUM)

    endtask

endclass

`endif // FIR_SEQUENCE_SV
