function str_output = mimic_array_output(array,name,format)
% function MIMIC_ARRAY_OUTPUT - replicates how matlab prints out arrays
%
%   STR = mimic_array_output(ARRAY) mimics how Matlab prints out
%   arrays to the command window, i.e. if you typed in the array without a 
%   semicolon and pressed enter. 
%
%   STR = mimic_array_output(ARRAY,NAME) will use the string NAME to print
%   out. The default for NAME is 'ans' 
%
%   STR = mimic_array_output(ARRAY,NAME,FORMAT) will use the string spec
%   FORMAT with sprintf to print out the array. The default FORMAT for
%   integers is '%6d' and the default for floats is '%10.4f'


%Handle input
if nargin < 2
    name = 'ans';
end
if nargin < 3
    if all(mod(array(:),1)==0)
        format = '%6d';
    else
        format = '%10.4f';
    end
end

%Assemble output
if ismatrix(array)
    
    % For strings, use to lood to add each row
    if ischar(array)
         str_output = [name ' = ' char(10)];
         for ii = 1:size(array,1)
            str_output = [str_output char([10 32 32 32 32]) '''' array(ii,:) ''''];
         end
         
    % For numeric vectors and 2D matrices, we can get away with a single 
    % sprintf command
    else  
        str_output = [name ' = ' char([10]) ...
            sprintf(['\n' repmat(format,1,size(array,2))],array')];
    end

%For 3D matrices, we need to print multiple "sheets"
elseif ndims(array) == 3
    
    %Get overall format for a single sheet
    array_size = size(array);
    sheet_format = ['%s(:,:,%d) = \n\n' ...
        repmat([repmat(format,1,array_size(2)) '\n'],1,array_size(1)) '\n\n'];
    
    %Now concatenate the sheets togethers
    str_output = [];
    for ii = 1:array_size(3)
        str_output = [str_output sprintf(sheet_format,name,ii,array(:,:,ii)')];
    end
    
    %Remove the last three characters (all newlines)
    str_output = str_output(1:end-3);
else
    error('Only works for arrays with 1, 2 , or 3 dimensions');
end



