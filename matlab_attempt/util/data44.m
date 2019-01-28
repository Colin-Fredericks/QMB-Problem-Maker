function [correct,incorrect,problem_values] = data44()
% function data44 - Generate answers for QMB problem data44
%
%   [correct,incorrect,problem_values,explanation] = data44()

% Pick an array name
array_name = randsample('ABCDEFGHKLMNPQRSTUVWXYZ',1);

% Pick a function
func_choices = {'round','floor','ceil'};
func_str = func_choices{randi(length(func_choices),1)};

% Get an array make sure that the four functions return different results
array_size = randsample(1:4,2);
while true
    array_vals = rand(array_size)*100-50;
    result{1} = round(array_vals);
    result{2} = floor(array_vals);
    result{3} = ceil(array_vals);
    result{4} = fix(array_vals);
    
    % To check if the 4 results are unique, calculate pairwise distances
    % between the arrays. Two arrays are equal if the distance is 0
    distances = pdist([result{1}(:) result{2}(:) result{3}(:) result{4}(:)]');    
    if all(distances>0)
        break;
    end
end
    
% Display used in problem
array_disp = ['$$' mimic_array_output(array_vals,array_name) '/$$'];

% Four choices
for ii = 1:length(result)
    choices{ii} = ['$$' mimic_array_output(result{ii}) '/$$'];
end

% Decide which is correct answer
answer_ind = find(strcmp(func_choices,func_str));
correct = choices(answer_ind);
incorrect = choices(1:4~=answer_ind);
incorrect{4} = 'None of these';

% Output values needed to display the problem and solution
problem_values = {array_name,func_str,array_disp};



    