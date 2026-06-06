interface FIR_interface(input clk);
    
    parameter N = 16;								// bit resolution

    logic reset ;
    logic signed [N-1:0] noisy_signal ;
    logic signed [2*N-1:0] filtered_signal;


endinterface