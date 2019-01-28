function [correct,incorrect,letter,number] = data30(func_choice,dim_choice)
% function data30 - Generate answers for QMB problem data30
%
%   [correct,incorrect,letter,number] = data30(func_choice,dim_choice)
%       func_choice: 'rand' or 'randn'
%       dim_choice: 1 or 2 (i.e. 1D or 2D)


% Pick a letter. Make it uppercase for the 2D array
letter = randsample('abcdefghkmnpqrtuvwxyz',1);
if dim_choice==2
    letter = upper(letter);
end

% Pick a size
number = 100*randi(50,1);

% Possible choices
choices = {sprintf('$%c = rand(%d,1);/$',letter,number), ...
           sprintf('$%c = rand(1,%d);/$',letter,number), ...
           sprintf('$%c = rand(%d,%d);/$',letter,number,number), ...
           sprintf('$%c = rand(%d);/$',letter,number), ...
           sprintf('$%c = randn(%d,1);/$',letter,number), ...
           sprintf('$%c = randn(1,%d);/$',letter,number), ...
           sprintf('$%c = randn(%d,%d);/$',letter,number,number), ...
           sprintf('$%c = randn(%d);/$',letter,number)};

% Pick which answers are correct and incorrect based on the input choices.
if dim_choice==1      
    if strcmp(func_choice,'rand')
        correct = choices([1 2]);
        incorrect = randsample(choices(3:8),4);
    elseif strcmp(func_choice,'randn')
        correct = choices([5 6]);
        incorrect = randsample(choices([1:4 7:8]),4);
    end
elseif dim_choice == 2
    if strcmp(func_choice,'rand')
        correct = choices([3 4]);
        incorrect = randsample(choices([1:2 5:8]),4);
    elseif strcmp(func_choice,'randn')
        correct = choices([7 8]);
        incorrect = randsample(choices(1:6),4);
    end
end
    
        
       
        
        


