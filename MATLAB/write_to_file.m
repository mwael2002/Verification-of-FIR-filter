function write_to_file(filename,data,write_length)
    % Open file for writing
    fid = fopen(filename, 'w');
    if fid == -1
        error('Unable to open file for writing.');
    end
    
    if(write_length==1)
        fprintf(fid, '%s\n', dec2hex(length(data)));
    end
    
    % Write data to file in hexadecimal format
    for i = 1:numel(data)
        fprintf(fid, '%s\n', hex(data(i)));
    end
    
    % Close file
    fclose(fid);
end