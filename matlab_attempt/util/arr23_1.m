function [append_str,delim_display,correct_answer,new_size] = arr23_1(array_size,max_value,ask_str)
% Function ARR23 - generate info for QMB problem 23_1
%
%   [append_str,delimiter,answer] = arr23_1(array_size,max_value,ask_str)
%

%Pick a delimiter
delim_display = randsample(',;',1);

% Choice 1: We want to append a column
if delim_display == ','
    
    %Answer depends on whether the number of rows or columns was asked
    if strcmp(ask_str,'rows')
        correct_answer = array_size(1);
    else
        correct_answer = array_size(2)+1;
    end
    
    %Create a correctly formatted vector to append
    append_str = mat2string(randi(max_value,array_size(1),1));
    
    %Size of new array
    new_size = [array_size(1) array_size(2)+1];
    
% Choice 2: We want to append a row
elseif delim_display == ';'
    
    %Answer depends on whether the number of rows or columns was asked
    if strcmp(ask_str,'rows')
        correct_answer = array_size(1)+1;
    else
        correct_answer = array_size(2);
    end
    
    %Create a correctly formatted vector to append
    append_str = mat2string(randi(max_value,1,array_size(2)));
    
    %Size of new array
    new_size = [array_size(1)+1 array_size(2)];
end
    
