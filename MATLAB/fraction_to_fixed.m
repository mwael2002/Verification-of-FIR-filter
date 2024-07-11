function [fixed_point_number] = fraction_to_fixed(sig)

len=size(sig);

fixed_point_number=zeros(len(1),len(2));

for i=1:len(2)
    
    if(sig(i)>=0)
       sig_int=floor(sig(i));
       fixed_point_number(i)=int16( ceil( ((2^14) -1)* ( sig(i)-sig_int) ) + 2^14*sig_int) ;   
    else
       sig_int=ceil(sig(i));
       fixed_point_number(i)=int16(floor( ( (2^14) -1)* ( sig(i)-sig_int) ) + (2^14)*sig_int) ;
       
    end    
    
end