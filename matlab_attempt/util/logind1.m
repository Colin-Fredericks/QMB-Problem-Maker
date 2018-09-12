function [correct_answer,incorrect_answers,help_str] = ...
    logind1(array,comparator,number,chance_none)
% function ARR20_1 - Answers for QMB problem arr20.1
%
%   [correct_answer,incorrect_answerss,display,ask_str] = ...
%           arr20_1(array_name,array_vals,chance_none)
%
%

%Aseemble list of answers
ans1 = eval([mat2str(array) comparator num2str(number)]); %Logical array: 1 1 0 0
ans2 = ~ans1; %Opposite logical array: 0 0 1 1
ans3 = array(ans1); %Correct answer, the right values
ans4 = array(ans2); %Wrong values
ans5 = array; %All values (can't be right based on problem design)


% Chooses whether correct answer is present of 'None of these'
if rand > chance_none
    correct_answer = ['$$' mimic_array_output(ans3) '/$$'];
    
    incorrect_answers{1} = ['$$' mimic_array_output(ans1) '/$$'];
    incorrect_answers{2} = ['$$' mimic_array_output(ans2) '/$$'];
    incorrect_answers{3} = ['$$' mimic_array_output(ans4) '/$$'];
    incorrect_answers{4} = 'None of these';
else
    correct_answer = 'None of these';
    
    incorrect_answers{1} = ['$$' mimic_array_output(ans1) '/$$'];
    incorrect_answers{2} = ['$$' mimic_array_output(ans2) '/$$'];
    incorrect_answers{3} = ['$$' mimic_array_output(ans4) '/$$'];
    incorrect_answers{4} = ['$$' mimic_array_output(ans5) '/$$'];
end
    

% Create the help string for the solution
ord_list = ordinal_string(find(ans1));
if sum(ans1) == 1
    help_str = [ord_list ' value. The value at that index'];
elseif sum(ans1) == 2    
    help_str = [ord_list{1} ' and ' ord_list{2} ' values. The values at those indices'];
else
    help_str = [strjoin(ord_list(1:end-1),', ') ', and ' ord_list{end} ' values. The values at those indices'];
end

