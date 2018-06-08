function [ask_indices,ask_values,display] = arr18_1(array_name,array_size,max_value)
% function ARR18_1 - Answers for QMB problem arr18.1
%
%   [ask_indices,indices,display] = arr18_1(array_name,array_size,max_value)
%
%

%Assemble array
array = reshape(randsample(max_value,prod(array_size)),array_size);

%Which indices will be asked for
ask_indices = zeros(3,2);
ask_indices(1,:) = randi(array_size(1),1,2); 
ask_indices(2,:) = randi(array_size(2),1,2); 
ask_indices(3,1) = randi(array_size(3),1); 
ask_indices(3,2) = randsample([1:ask_indices(3,1)-1 ask_indices(3,1)+1:array_size(3)],1);

%Values which are used to ask for the answer
ask_values(1) = array(ask_indices(1,1),ask_indices(2,1),ask_indices(3,1));
ask_values(2) = array(ask_indices(1,2),ask_indices(2,2),ask_indices(3,2));

%Display
sheet_format = ['%s(:,:,%d) = \n\n' ...
    repmat(['\t' repmat('%4d ',1,array_size(2)) '\n'],1,array_size(1)) '\n\n'];
display = [];
for ii = 1:array_size(3)
    display = [display sprintf(sheet_format,array_name,ii,array(:,:,ii)')];
end
%Pick ask values for row and column (less than current dims)