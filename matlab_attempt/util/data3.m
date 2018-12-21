function [correct,incorrect,problem_values,explanation] = data3()
% function DATA3 - QMB problem data3
%
%   [correct,incorrect,problem_values,explanation] = data3()
%
%

% Pick name and length
array_name = randsample('ABCDEFGHKLMNPQRTUVWXYZ',1);
array_length = randi([5 7],1)

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

% Pick a function
choice_ind = randi([1 6],1);
func_choices = {'mean','median','std','var','min','max'};
func_str = func_choices{choice_ind};
func_explain_choices = {'The $mean()/$ function calculates the mean, or average.', ...
    'The $median()/$ function calculates the median, i.e. the 50th percentile.', ...
    'The $std()/$ function calculate the standard deviation, i.e. the square root of the variance.', ...
    'The $var()/$ function calculates the variance, i.e. the square of the standard deviation.', ...
    'The $min()/$ function returns the smallest number from an input array, i.e. the minimum.', ...
    'The $min()/$ function returns the largest number from an input array, i.e. the maximum.'};
func_explain = func_explain_choices{choice_ind};
            
% Format the answer displays
ans_displays = {};
for ii = 1:6
    ans_displays{ii} = ['$$' mimic_array_output(stats(ii)) '/$$'];
end
array_disp = ['$$' mimic_array_output(array_values,array_name) '/$$'];

% Organize into correct and incorrect
correct = ans_displays{choice_ind};
incorrect = ans_displays([1:choice_ind-1 choice_ind+1:6]);

% Organize the values for displaying the problem
problem_values = {array_name,array_disp,func_str,func_explain};

explanation = '';
