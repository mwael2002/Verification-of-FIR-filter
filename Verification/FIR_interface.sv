interface FIR_interface(input clk);
    
    parameter N = 16;								// bit resolution

    logic reset ;
    logic signed [N-1:0] noisy_signal , filtered_signal;


endinterface