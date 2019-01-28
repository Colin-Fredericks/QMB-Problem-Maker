function [correct,incorrect,problem_values] = data34()
% function data34 - Generate answers for QMB problem data34
%
%   [correct,incorrect,problem_values] = data34()

% Pikc a a size to ask about and a wrong size for wrong answers
ask_size = randi([3 7],1);
other_size = ask_size + randsample([-1 1],1);

% Choices for argument of randn function
arg_choices = {sprintf('1,%d',ask_size), ...
               sprintf('%d,1',ask_size), ...
               sprintf('%d,%d',ask_size,ask_size), ...
               sprintf('%d',ask_size)};
           
% Size explanatations
explain_choices = {sprintf('The argument $(1,%d)/$ will create a single row of %d numbers',ask_size,ask_size), ...
                   sprintf('The argument $(%d,1)/$ will create a single column of %d numbers',ask_size,ask_size), ...
                   sprintf('The argument $(%d,%d)/$ will create a matrix with %d rows and %d columns',ask_size,ask_size,ask_size,ask_size), ...
                   sprintf('The argument $(%d)/$ will create a matrix with %d rows and %d columns',ask_size,ask_size,ask_size)};
                              
% Make the three "correct" displays
displays = {['$$' mimic_array_output(randn(1,ask_size)) '/$$'], ...
            ['$$' mimic_array_output(randn(ask_size,1)) '/$$'], ...
            ['$$' mimic_array_output(randn(ask_size)) '/$$']};

% Display of wrong arrays
other_displays = {['$$' mimic_array_output(randn(1,other_size)) '/$$'], ...
            ['$$' mimic_array_output(randn(other_size,1)) '/$$'], ...
            ['$$' mimic_array_output(randn(other_size)) '/$$']};
            
           
% Pick one choice for problem display
arg_ind = randi(4,1);
arg_str = arg_choices{arg_ind};

% Pick out reference answer and explanation of size
explain1 = explain_choices{arg_ind};
reference = displays{min(3,arg_ind)};

% Decide if "None of these" is the correct answer
chance_none = 0.2;
if rand>chance_none
    
    % Correct answer is the correct display.
    correct = displays{min(3,arg_ind)};
    incorrect(1:2) = displays(1:3~=min(3,arg_ind));
    incorrect(3) = randsample(other_displays,1);
    incorrect(4) = {'None of these'};
    explain2 = '';
else
    
    % Correct answer is 'None of these'
    correct = 'None of these';
    incorrect(1:2) = displays(1:3~=min(3,arg_ind));
    incorrect(3:4) = randsample(other_displays,2);
    
    % Extra explanation required for this case
    plural_choices = {'','s' ; 's',''; 's','s'; 's','s'}; 
    size_choices = [1,ask_size; ask_size,1 ; ask_size,ask_size; ask_size,ask_size];
    plurals = plural_choices(arg_ind,:);
    sizes = size_choices(arg_ind,:);
    explain2 = sprintf('<br/><p>However, none of the choices have an array of the correct size, i.e. with %d row%s and %d column%s. Therefore, the correct answer is: "None of these".</p>',sizes(1),plurals{1},sizes(2),plurals{2});
end

% Assemble values needed for problem
problem_values = {arg_str,explain1,reference,explain2};