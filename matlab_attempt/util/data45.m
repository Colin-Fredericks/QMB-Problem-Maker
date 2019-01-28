function [array_name,func_str,array_input,array_output] = data45()
% function data45 - Generate answers for QMB problem data45
%
%   [answer,problem_values] = data45()

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
    
    % To check if the 3 results are unique, calculate pairwise distances
    % between the arrays. Two arrays are equal if the distance is 0
    distances = pdist([result{1}(:) result{2}(:) result{3}(:)]');    
    if all(distances>0)
        break;
    end
end
    
% Displays used in problem
array_input = ['$$' mimic_array_output(array_vals,array_name) '/$$'];
answer_ind = strcmp(func_choices,func_str);
array_output = ['$$' mimic_array_output(result{answer_ind}) '/$$'];



    