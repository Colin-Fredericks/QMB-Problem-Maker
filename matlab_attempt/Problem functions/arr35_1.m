function [answer,error_string,dim_str,solution_str] = arr35_1(names,size1,size2,delimiter,ask_str)
% Function ARR35_1 - generate info for QMB problem 35.1
%
%   [answer,error_string,dim_str,solution_str] = arr35_1(names,size1,size2,delimiter,ask_str)
%


% Str that has which dimension that needs to match given the delimiter for
% appending arrays
if strcmp(delimiter,',')
    dim_str = 'rows';
else
    dim_str = 'columns';
end

% Determine if an error
is_error = (strcmp(delimiter,';') & size1(2)~=size2(2)) | ...
           (strcmp(delimiter,',') & size1(1)~=size2(1));
       
% If error, return exp(1)
if is_error
    answer = exp(1);
    error_string = 'is not';
    solution_str = 'this code will produce an error and the answer is $e/$';
else
    
    error_string = 'is';
    
    % With no error, size depends on delimiter
    if strcmp(delimiter,',')
        size3 = [size1(1) size1(2)+size2(2)]; 
        help_str = 'side by side';
    else
        size3 = [2*size1(1) size1(2)];
        help_str = 'on top of each other';
    end
    
    % Answer depends on what is asked for
    if strcmp(ask_str,'rows')
        answer = size3(1); 
    else
        answer = size3(2);
    end
    
    solution_str = ['$' names{1} '/$ and $' names{2} '/$ are appended ' ...
        help_str ' and ' '$size(' names{3} ') = ' mat2string(size3) ...
        '/$, making the answer $' num2str(answer) '/$' ];
    
end
    
  
