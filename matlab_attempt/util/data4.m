function [choices,correctness,problem_values] = data4()
% function DATA3 - QMB problem data3
%
%   [correct,incorrect,problem_values,explanation] = data3()
%
%

% Pick name and length
array_name = randsample('ABCDEFGHKLMNPQRTUVWXYZ',1);
array_length = randi([5 7],1);

% Pick dimension order (row or column array)
array_dim = [1 array_length];
if rand>0.5 
    array_dim = fliplr(array_dim);
end

% Make sure the 6 stats return a different value (at least to 4 decimal
% places)
while true
    
    %Pick array
    array_values = randi(10,array_dim) + randi(100,1);
    
    % Calc stats and round to nearest ten thousandth place
    stats = [mean(array_values), median(array_values), ...
             std(array_values), var(array_values), ...
             min(array_values), max(array_values) ];
    stats = round(stats*1e4)/1e4;
    
    %Only break if all 6 values are unique
    if length(unique(stats))==6
        break
    end
end

% Pick a value to be the display output
choice_ind = randi([1 6],1);
output_display = ['$$' mimic_array_output(stats(choice_ind)) '/$$'];

% Choices
func_choices = {'mean','median','std','var','min','max'};
choices = {};
for ii = 1:6
    choices{ii} = ['$' func_choices{ii} '(' array_name ')/$'];
end

%Explanation string
func_explain_choices = {'the $mean()/$ function, which calculates the mean, or average.', ...
    'the $median()/$ function, which calculates the median, i.e. the 50th percentile.', ...
    'the $std()/$ function, which calculate the standard deviation, i.e. the square root of the variance.', ...
    'the $var()/$ function, which calculates the variance, i.e. the square of the standard deviation.', ...
    'the $min()/$ function, which returns the smallest number from an input array, i.e. the minimum.', ...
    'the $min()/$ function, which returns the largest number from an input array, i.e. the maximum.'};
func_explain = func_explain_choices{choice_ind};
            
% Array display
array_disp = ['$$' mimic_array_output(array_values,array_name) '/$$'];

% Get correctness of each answer
correctness = convert_logical(1:6==choice_ind);
correct_ans = choices{choice_ind};
output_value = num2str(stats(choice_ind));

% Organize the values for displaying the problem
problem_values = {array_name,array_disp,output_display,func_explain, ...
    correct_ans,output_value};

