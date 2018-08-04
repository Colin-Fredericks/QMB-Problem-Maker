function [correct_answer,incorrect_answers,ask_indices,ask_value,display] = ...
    arr18_2(array_name,array_size,max_value,chance_none)
% function ARR18_2 - Answers for QMB problem arr18.2
%
%   [ask_indices,indices,display] = arr18_1(array_name,array_size,max_value)
%
%

%Assemble array
array = reshape(randsample(max_value,prod(array_size)),array_size);

%Which indices will be asked for. First pick sheet since it is the smallest
ask_indices(3) = randi(array_size(3),1); 

%Row choice
possible_ind = 1:array_size(1)-1;
possible_ind = possible_ind(~ismember(possible_ind,ask_indices(3)));
if length(possible_ind) == 1
    ask_indices(1) = possible_ind;
else
    ask_indices(1) = randsample(possible_ind,1);
end
    

%Col choice
possible_ind = 1:array_size(2);
possible_ind = possible_ind(~ismember(possible_ind,ask_indices([1 3])));
if length(possible_ind) == 1
    ask_indices(2) = possible_ind;
else
    ask_indices(2) = randsample(possible_ind,1);
end


%Values which are used to ask for the answer
ask_value = array(ask_indices(1),ask_indices(2),ask_indices(3));

%Display
sheet_format = ['%s(:,:,%d) = \n\n' ...
    repmat(['\t' repmat('%4d ',1,array_size(2)) '\n'],1,array_size(1)) '\n\n'];
display = [];
for ii = 1:array_size(3)
    display = [display sprintf(sheet_format,array_name,ii,array(:,:,ii)')];
end


% Set up answers
long_format = '$%s(%d,%d,%d)/$';
short_format = '$%s(%d,%d)/$';
if rand > chance_none
    correct_answer = sprintf(long_format,array_name,ask_indices);
    incorrect_answers{1} = 'None of these';
    incorrect_answers{2} = sprintf(long_format,array_name,ask_indices([3 2 1]));
    incorrect_answers{3} = sprintf(short_format,array_name,ask_indices(1:2));
    incorrect_answers{4} = sprintf(long_format,array_name,array_size);
else
    correct_answer = 'None of these';
    incorrect_answers{1} = sprintf(short_format,array_name,ask_indices(1:2));
    incorrect_answers{2} = sprintf(long_format,array_name,ask_indices([3 2 1]));
    incorrect_answers{3} = sprintf(short_format,array_name,array_size(1:2));
    incorrect_answers{4} = sprintf(long_format,array_name,array_size);
end
    
