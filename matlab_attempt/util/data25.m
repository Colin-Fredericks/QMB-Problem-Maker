function [correct,incorrect,problem_values,explanation] = data25()
% function DATA22 - QMB problem data25
%
%   [correct,incorrect,problem_values,explanation] = data25()
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
action_word = func_words{choice_ind};

%Pick a dimension
dim_choices = {'column','row'};
dim_ind = randi(2,1);
dim_word = dim_choices{dim_ind};
other_word = dim_choices{1:2~=dim_ind};

%Assemble the command to display
is_var = choice_ind==5 | choice_ind==6;
if is_var
    command = sprintf('%s(%c,0,%d)',func_str,array_name,dim_ind);
else
    command = sprintf('%s(%c,%d)',func_str,array_name,dim_ind);
end
    

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
    
    %Different answer depending on the dimension index
    if dim_ind==1
        correct_ind = 1;  
        incorrect = randsample(answers(2:5),3);
    else
        correct_ind = 4;  
        incorrect = randsample(answers([1:3 5]),3);        
    end
    
    % Add in formatting and "None of these"
    correct = ['$$' mimic_array_output(answers{correct_ind}) '/$$'];  
    for ii = 1:length(incorrect)
        incorrect{ii} = ['$$' mimic_array_output(incorrect{ii}) '/$$'];
    end    
    incorrect{end+1} = 'None of these';
    
    explanation = '';
else
    
    % Correct answer not shown
    correct = 'None of these';
    
    % Incorrect answers depend on the dimension index
    if dim_ind==1
        correct_ind = 1;  
        incorrect = answers(2:5);
    else
        incorrect = answers([1:3 5]);
        correct_ind = 4;  
    end
    for ii = 1:length(incorrect)
        incorrect{ii} = ['$$' mimic_array_output(incorrect{ii}) '/$$'];
    end
    
    explanation = ['<br/><p>However, this is not one of the choices. Therefore, the correct answer is: "None of these".</p>'];
end

%Problem values: reference answer, array display, etc.
reference_answer = ['$$' mimic_array_output(answers{correct_ind}) '/$$'];
array_display = ['$$' mimic_array_output(array,array_name) '/$$'];
problem_values = {command,array_display,func_str,reference_answer, ...
    action_word,dim_ind,dim_word,other_word};


       
       
       


