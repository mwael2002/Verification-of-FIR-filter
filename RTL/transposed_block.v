module transposed_block(clk , reset ,normal_signal ,coeff,to_register, summed_signal);

	parameter N = 16;								// bit resolution
	//parameter T = 4;								// number of Taps

 	input clk;
 	input reset;
 	input signed [N-1:0] normal_signal;
 	input signed [N-1:0] coeff;
 	input signed [2*N-1:0] to_register;
 	output signed [2*N-1:0] summed_signal;
	
	wire signed [2*N-1:0] mul;
	(* preserve_for_debug *) reg signed [2*N-1:0] delayed_signal;
	
	always@(posedge clk) begin 
	   if(!reset)
	       delayed_signal <= 0;
	       
	   else 
	       delayed_signal <= to_register ;
	end 
	
	assign mul = coeff * normal_signal ;
	assign summed_signal = mul + delayed_signal ;
endmodule

