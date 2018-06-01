function [correct_answer,incorrect_answers,new_size,ask_values,dim_strings,disp_string] =  ...
    arr17_1(old_size,chance_none,max_increase,new_value)
% function ARR17 - Answers for QMB problem arr17_1
%
%   [correct,incorrect] = arr17(nameA,sizeA,prob_none)
%
%


% Flip a coin to see if row or column size will increase
new_size = old_size;
ask_values = [0 0];
if rand < 0.5
    
    %Increase row size
    new_size(1) = new_size(1) + randi(max_increase,1);
    if new_size(1) == new_size(2)
        new_size(1) = new_size(1)+1;
    end
    
    %Generate values that will be used in command to increase rows
    ask_values(1) = new_size(1);
    possible_values = 1:new_size(2)-1;
    possible_values(possible_values==new_size(1)) = [];
    ask_values(2) = randsample(possible_values,1);
    
    %Strings for displaying the question
    dim_strings = {'rows','columns'};
    disp_string = [ordinal_string(new_size(1)) ' row'];
    
    %Strings for answers
    format = repmat('%d ',1,new_size(2));
    ans_last = sprintf(format,[zeros(1,new_size(2)-1),new_value]);
    ans_correct = sprintf(format, ...
        [zeros(1,ask_values(2)-1), new_value, zeros(1,new_size(2)-ask_values(2))]);
    ans_short = sprintf(format, ...
        [zeros(1,ask_values(2)-1), new_value]);
    ans_values = sprintf(format,repmat(new_value,1,new_size(2)));
    ans_zeros = sprintf(format,zeros(1,new_size(2)));
 else
    
    %Increase column size
    new_size(2) = new_size(2) + randi(max_increase,1); 
    if new_size(1) == new_size(2)
        new_size(2) = new_size(2)+1;
    end
    
    %Generate values that will be used in command to increase columns
    ask_values(2) = new_size(2);
    possible_values = 1:new_size(1)-1;
    possible_values(possible_values==new_size(2)) = [];
    ask_values(1) = randsample(possible_values,1);    
    
    %Strings for displaying the question
    disp_string = [ordinal_string(new_size(2)) ' column'];
    dim_strings = {'columns','rows'};  
    
    %String for answers
    format = '%d\n';
    ans_last = sprintf(format,[zeros(new_size(1)-1,1);new_value]);
    ans_correct = sprintf(format,[zeros(ask_values(1)-1,1); ...
        new_value; zeros(new_size(1)-ask_values(1),1)]);
    ans_short = sprintf(format,[zeros(ask_values(1)-1,1); new_value]);
    ans_values = sprintf(format,repmat(new_value,new_size(1),1));
    ans_zeros = sprintf(format,zeros(new_size(1),1));
end

%Dsiplay correct answer if rand > chance_none
if rand > chance_none        
    correct_answer = ['$$' ans_correct '/$$'];
    incorrect_answers{1} = ['$$' ans_short '/$$'];
    incorrect_answers{2} = ['$$' ans_last '/$$'];
    incorrect_answers{3} = ['$$' ans_values '/$$'];
    incorrect_answers{4} = 'None of these';
    incorrect_answers{5} = ['There is no ' disp_string '. This code produces an error'];
else    
    correct_answer = 'None of these';
    incorrect_answers{1} = ['$$' ans_short '/$$'];
    incorrect_answers{2} = ['$$' ans_last '/$$'];
    incorrect_answers{3} = ['$$' ans_values '/$$'];
    incorrect_answers{4} = ['$$' ans_zeros '/$$']; 
    incorrect_answers{5} = ['There is no ' disp_string '. This code produces an error'];
end
    
    

