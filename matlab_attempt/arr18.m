function [correct_answer,incorrect_answers,new_size,ask_values] =  ...
    arr18(array_name,old_size,chance_none,max_sheets)
% function ARR18 - Answers for QMB problem arr17
%
%   [correct,incorrect] = arr18(nameA,sizeA,prob_none)
%
%

%Pick ask values for row and column (less than current dims)
possible_rows = 1:old_size(1)-1;
possible_rows = possible_rows(~ismember(possible_rows,old_size(2)));
ask_values(1) = randsample(possible_rows,1);

possible_cols = 1:old_size(2)-1;
possible_cols = possible_cols(~ismember(possible_cols, ...
    [ask_values(1) old_size(1)]));
ask_values(2) = randsample(possible_cols,1);

%Pick a 3rd dimension that isn't a value already selected
possible_sheets = 2:max_sheets;
possible_sheets = possible_sheets(~ismember(possible_sheets, ...
    [ask_values(1:2) old_size]));
ask_values(3) = randsample(possible_sheets,1);

%Add 3rd dimension to new size
new_size = [old_size ask_values(3)];

%Format for printing answers
long_format = '$$size(%s) = \n\t%d %d %d/$$';
short_format = '$$size(%s) = \n\t%d %d/$$';

if rand > chance_none
    correct_answer = sprintf(long_format,array_name,new_size);
    incorrect_answers{1} = 'None of these';
    incorrect_answers{2} = sprintf(short_format,array_name,old_size);
    incorrect_answers{3} = sprintf(long_format,array_name,ask_values);
    incorrect_answers{4} = sprintf(short_format,array_name,new_size([1 3]));
    
else
    correct_answer = 'None of these';
    incorrect_answers{1} = sprintf(short_format,array_name,old_size);
    incorrect_answers{2} = sprintf(long_format,array_name,ask_values);
    incorrect_answers{3} = sprintf(short_format,array_name,new_size([1 3]));
    incorrect_answers{4} = sprintf(short_format,array_name,new_size([2 3]));
end
