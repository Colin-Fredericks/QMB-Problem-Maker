function [correct_answer,incorrect_answers,new_size,ask_values,dim_strings] =  ...
    arr17(array_name,old_size,chance_none,max_increase)
% function ARR17 - Answers for QMB problem arr17
%
%   [correct,incorrect] = arr17(nameA,sizeA,prob_none)
%
%


% Flip a coin to see if row or column size will increase
new_size = old_size;
ask_values = [0 0];
if rand < 0.5
    new_size(1) = new_size(1) + randi(max_increase,1);
    if new_size(1) == new_size(2)
        new_size(1) = new_size(1)+1;
    end
    ask_values(1) = new_size(1);
    possible_values = 1:new_size(2)-1;
    possible_values(possible_values==new_size(1)) = [];
    ask_values(2) = randsample(possible_values,1);
    dim_strings = {'rows','columns'};
else
    new_size(2) = new_size(2) + randi(max_increase,1); 
    if new_size(1) == new_size(2)
        new_size(2) = new_size(2)+1;
    end
    ask_values(2) = new_size(2);
    possible_values = 1:new_size(1)-1;
    possible_values(possible_values==new_size(2)) = [];
    ask_values(1) = randsample(possible_values,1);    
    dim_strings = {'columns','rows'};
end


format = '$$size(%s) = \n\t%d %d/$$';

if rand > chance_none
    correct_answer = sprintf(format,array_name,new_size);
    incorrect_answers{1} = sprintf(format,array_name,fliplr(new_size));
    incorrect_answers{2} = sprintf(format,array_name,old_size);
    incorrect_answers{3} = sprintf(format,array_name,fliplr(old_size));
    incorrect_answers{4} = 'None of these';
    incorrect_answers{5} = sprintf(format,array_name,ask_values);
else
    correct_answer = 'None of these';
    incorrect_answers{1} = sprintf(format,array_name,fliplr(new_size));
    incorrect_answers{2} = sprintf(format,array_name,old_size);
    incorrect_answers{3} = sprintf(format,array_name,fliplr(old_size));
    incorrect_answers{4} = sprintf(format,array_name,ask_values);
    incorrect_answers{5} = sprintf(format,array_name,fliplr(ask_values));
end
    
    

