// Code your testbench here
// or browse Examples
module dummy;
  

  logic signed[15:0] fixed_point[];
  string input_sig;
  int file_handle,i;

  initial begin
    
    fixed_point=new[221];

    file_handle=$fopen("input_sig_half_KHz.txt","r");


    while (fixed_point[0]===16'hxxxx)
    $fscanf(file_handle,"%d",fixed_point[0]);

    i=1;

    while (!$feof(file_handle)) begin

    $fscanf(file_handle,"%d",fixed_point[i]);
    i++;

    end 


    $display("%p ",fixed_point);  
   

    $fclose(file_handle);
  
    file_handle=$fopen("input_sig_half_KHz.txt","w");
    $fclose(file_handle);

  
  end
  
endmodule