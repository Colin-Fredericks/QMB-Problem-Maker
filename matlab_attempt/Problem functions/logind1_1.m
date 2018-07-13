function [correct_answer,incorrect_answers,array1,array2,comparator,number,help_str] = ...
    logind1_1(array_name,len_array,max_value,chance_none)
% function ARR20_1 - Answers for QMB problem arr20.1
%
%   [correct_answer,incorrect_answerss,display,ask_str] = ...
%           arr20_1(array_name,array_vals,chance_none)
%
%


% Pick arrays. Make sure they return different logical arrays
while true
    
    %Sample values without replacement
    values = randsample(max_value,2*len_array);
    array1 = values(1:len_array)';
    array2 = values(len_array+1:end)';
    
    %Pick an inequality and number for comparison    
    comparator = randsample({'<','>','<=','>='},1);
    comparator = comparator{1};
    number = randi(max_value,1);
    
    % Create the logical arrays
    ind1 = eval([mat2str(array1) comparator num2str(number)]); 
    ind2 = eval([mat2str(array2) comparator num2str(number)]); 
    
    % Break if all conditions are met. Otherwise repeat loop 
    condition1 = any(ind1 ~= ind2); %Arrays are different from each other
    condition2 = any(ind1) & any(ind2); %Neither are all false
    condition3 = ~all(ind1) & ~all(ind2); %Neither are all true
    if condition1 && condition2 && condition3
        break;
    end
end

%Correct answer
actual_answer = array2(ind1);

%Choices for wrong answers. The error checking above should ensure all of
%these answers are distinct
other_choices{1} = array2(~ind1);
other_choices{2} = array1(ind1);
other_choices{3} = array1(~ind1);
other_choices{4} = array2(ind2);
other_choices{5} = array2(~ind2);
other_choices{6} = array1(ind2);
other_choices{7} = array1(~ind2);
other_choices{8} = array1;
other_choices{9} = array2;


% Chooses whether correct answer is present of 'None of these'
if rand > chance_none
    correct_answer = ['$$' mimic_array_output(actual_answer,array_name) '/$$'];
    
    %Pick three wrong choices
    choice_ind = randsample(length(other_choices),3);
    incorrect_answers{1} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(1)},array_name) '/$$'];
    incorrect_answers{2} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(2)},array_name) '/$$'];
    incorrect_answers{3} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(3)},array_name) '/$$'];

    %Add 'None of these' and empty array [] so they always show up
    incorrect_answers{4} = 'None of these';
    incorrect_answers{5} = ['$$' sprintf('%s = \n\n%7s',array_name,'[]') '/$$'];
else
    %Actual answer will be missing
    correct_answer = 'None of these';
    
    %Pick 4 wrong answers
    choice_ind = randsample(length(other_choices),4);
    incorrect_answers{1} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(1)},array_name) '/$$'];
    incorrect_answers{2} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(2)},array_name) '/$$'];
    incorrect_answers{3} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(3)},array_name) '/$$'];
    incorrect_answers{4} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(4)},array_name) '/$$'];
    
    %Add Empty array choice so it always shows up.
    incorrect_answers{5} = ['$$' sprintf('%s = \n\n%7s',array_name,'[]') '/$$'];
end
    

% Create the help string for the solution
ord_list = ordinal_string(find(ind1));
if sum(ind1) == 1
    help_str = [ord_list ' value. The value at that index'];
elseif sum(ind1) == 2    
    help_str = [ord_list{1} ' and ' ord_list{2} ' values. The values at those indices'];
else
    help_str = [strjoin(ord_list(1:end-1),', ') ', and ' ord_list{end} ' values. The values at those indices'];
end

