function [wrong_answer,delim_display] = arr23(array_size,max_value)
% Function ARR23 - generate info for QMB problem 23
%
%   [wrong_answer,delimiter] = arr23(array_size,max_value)
%

%Pick a delimiter
delim_display = randsample(',;',1);

%Pick another to choose what the question will attempt to append (row or column)
delim_choice = randsample(',;',1);


% Choice 1: We want to append a column
if delim_display == ','
    
    % Try appending a row vector (always wrong)
    if delim_choice == ','
        num_vals = randi(array_size(1),1);
        wrong_answer = mat2string(randi(max_value,1,num_vals));
        
    %Try appending a column vector (only right if using the correct number
    %of rows, which we don't
    elseif delim_choice == ';'
        num_vals = randi(array_size(1)-1,1);
        wrong_answer = mat2string(randi(max_value,num_vals,1));        
    end
    
% Choice 2: We want to append a row
elseif delim_display == ';'
    
    % Try appending a row vector (only right if using the correct number of
    % columns, which we don't here)
    if delim_choice == ','
        num_vals = randi(array_size(2)-1,1);
        wrong_answer = mat2string(randi(max_value,1,num_vals));
    
    % Try appending a column vector (always wrong)
    elseif delim_choice == ';'
        num_vals = randi(array_size(2),1);
        wrong_answer = mat2string(randi(max_value,num_vals,1));
    end        
end
    
