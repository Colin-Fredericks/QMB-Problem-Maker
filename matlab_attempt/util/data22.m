function [correct,incorrect,problem_values,explanation] = data22()
% function DATA22 - QMB problem data22
%
%   [correct,incorrect,problem_values,explanation] = data22()
%
%

% Probability of answer being 'None of these';
chance_none = 0.2;

% Pick array name, length, and values
array_name = randsample('ABCDEFGHKLMNPQRTUVWXYZ',1);
array_size = randsample(2:6,2);
array = randi(100,array_size);

%Pick a function
func_choices = {'min','max','mean','median','std','var'};
func_words = {'minimum','maximum','mean','median','standard deviation','variance'};
choice_ind = randi([1 6],1);
func_str = func_choices{choice_ind};
word = func_words{choice_ind};

% Make the callable function
func_handle = str2func(['@(x)' func_str '(x)']);

% Assemble the answers. 1st choice is correct
answers = {func_handle(array), ...
           func_handle(array'), ...
           func_handle(array)', ...
           func_handle(array')', ...
           func_handle(array(:))};

%Pick answers
if rand > chance_none
    
    correct = ['$$' mimic_array_output(answers{1}) '/$$'];
    
    incorrect = randsample(answers(2:end),3);
    for ii = 1:length(incorrect)
        incorrect{ii} = ['$$' mimic_array_output(incorrect{ii}) '/$$'];
    end
    
    incorrect{end+1} = 'None of these';
    
    explanation = '';
else
    
    correct = 'None of these';
    incorrect = answers(2:5);
    for ii = 1:length(incorrect)
        incorrect{ii} = ['$$' mimic_array_output(incorrect{ii}) '/$$'];
    end
    
    explanation = ['<br/><p>However, this is not one of the choices. Therefore, the correct answer is: "None of these".</p>'];
end

%Problem values: reference answer, array display, etc.
reference_answer = ['$$' mimic_array_output(answers{1}) '/$$'];
array_display = ['$$' mimic_array_output(array,array_name) '/$$'];
problem_values = {array_name,array_display,func_str,reference_answer,word};


       
       
       


