function [correct_answer,incorrect_answers,old_array,comparator,compare_num,logical_array, new_array] = ...
    logind6(array_name,size_array,max_value,chance_none)
% function LOGIND6 - Answers for QMB problem logind6
%
%   [correct_answer,incorrect_answers,display,comp,num,help_str] = ...
%           logind6(array_name,array_vals,chance_none)
%
%



% Pick array. Make sure the logical statement is not all ones or zeros
while true

    %Pick value for array and format string for display
    array = randi(max_value,size_array);

    %Pick an inequality and number for comparison. Make sure the compare 
    %num isnt already in the array because it will possible make one of
    %other_choices below a repeat
    comparator = randsample({'<','>','<=','>='},1);
    comparator = comparator{1};
    possibles = min(array(:))+1:max(array(:))-1;
    rm_ind = ismember(possibles,unique(array(:)));
    compare_num = randsample(possibles(~rm_ind),1); 

    replace_ind = eval([mat2str(array) comparator num2str(compare_num)]);
    
    %Check for all zeros or all ones. Break if not
    if ~all(replace_ind(:)) && any(replace_ind(:))
        break
    end
end


%Correct answer
actual_answer = array;
actual_answer(replace_ind) = 0;

%Choices for wrong answers. First three are the same every time
other_choices{1} = array; other_choices{1}(~replace_ind) = 0;
other_choices{2} = array;
other_choices{3} = zeros(size(array));

% Now generate 7 more random answers by replacing random values with zeros
num_needed = 10;
while length(other_choices) < num_needed
    
    %Pick random indices
    ind = randsample(size_array^2,randi(size_array^2-1,1));
    
    %Replace values with zeros
    possible_choice = array;
    possible_choice(ind) = 0;
    
    %Now make sure it's different from the other choices (and the answer
    do_keep = true;
    for ii = 1:length(other_choices)
        if isequal(possible_choice,other_choices{ii})
            do_keep = false;
        end
    end
    if isequal(possible_choice,actual_answer)
        do_keep = false;
    end
    
    if do_keep
        other_choices{end+1} = possible_choice;
    end
end

    
% %Choices for wrong answers. The error checking above should ensure all of
% %these answers are distinct
% other_choices{1} = array;
% other_choices{4} = zeros(size(array));
% other_choices{5} = array; other_choices{5}(ind) = compare_num;
% other_choices{6} = array; other_choices{6}(~ind) = compare_num;
% other_choices{7} = array; other_choices{7}(~ind) = 0;
% 
% %For extracted values, reshape into a 2D matrix just for appearance's sake
% values = array(ind);
% new_size = ceil(sqrt(length(values)));
% num_extra_zeros = new_size^2 - length(values);
% other_choices{2} = reshape([values; zeros(num_extra_zeros,1)],new_size+[0 0]);
% 
% % Doe the same for the wrong extracted values
% values = array(~ind);
% new_size = ceil(sqrt(length(values)));
% num_extra_zeros = new_size^2 - length(values);
% other_choices{3} = reshape([values; zeros(num_extra_zeros,1)],new_size+[0 0]);

% Chooses whether correct answer is present of 'None of these'
if rand > chance_none
    correct_answer = ['$$' mimic_array_output(actual_answer,array_name) '/$$'];
    
    %Pick 4 wrong choices
    choice_ind = randsample(length(other_choices),4);
    incorrect_answers{1} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(1)},array_name) '/$$'];
    incorrect_answers{2} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(2)},array_name) '/$$'];
    incorrect_answers{3} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(3)},array_name) '/$$'];
    incorrect_answers{4} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(4)},array_name) '/$$'];

    %Add 'None of these' and 'Error' so they always show up
    incorrect_answers{5} = 'None of these';
else
    %Actual answer will be missing
    correct_answer = 'None of these';
    
    %Pick 5 wrong answers
    choice_ind = randsample(length(other_choices),5);
    incorrect_answers{1} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(1)},array_name) '/$$'];
    incorrect_answers{2} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(2)},array_name) '/$$'];
    incorrect_answers{3} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(3)},array_name) '/$$'];
    incorrect_answers{4} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(4)},array_name) '/$$'];
    incorrect_answers{5} = ['$$' mimic_array_output( ...
        other_choices{choice_ind(5)},array_name) '/$$'];

end
    
%Handle output
old_array = array;
new_array = actual_answer;
logical_array = replace_ind;
