function [correct,incorrect,solution_str] = subplot4(grid_size,ask_size,chance_none)
% Function SUBPLOT2 - QMB problem subplot4
%
%   [correct,incorrect,solution_str] = subplot4(grid_size,ask_size,chance_none) 
%       Generates the answers for QMB problem subplot2. 
%


%Assemble answers
format = '$subplot(%d,%d,%d)/$';

%Index for linear indexing vs. subplot indexing
linear_ind = grid_size(1)*(ask_size(2)-1) + ask_size(1);
right_ind = grid_size(2)*(ask_size(1)-1) + ask_size(2);

right_answer = sprintf(format,grid_size(1),grid_size(2),right_ind);
wrong_answers{1} = sprintf(format,grid_size(1),grid_size(2),linear_ind);
wrong_answers{2} = sprintf(format,grid_size(2),grid_size(1),right_ind);
wrong_answers{3} = sprintf(format,grid_size(2),grid_size(1),linear_ind);
wrong_answers{4} = sprintf(format,ask_size(1),ask_size(2),right_ind);
wrong_answers{5} = sprintf(format,ask_size(1),ask_size(2),linear_ind);
wrong_answers{4} = sprintf(format,ask_size(2),ask_size(1),right_ind);
wrong_answers{5} = sprintf(format,ask_size(2),ask_size(1),linear_ind);

%String for helping explain the answer
solution_str = right_answer;

%Ppick which ones to output
if rand > chance_none
    correct = right_answer;
    incorrect(1:3) = randsample(wrong_answers,3);
    incorrect{4} = 'None of these';
else
    correct = 'None of these';
    incorrect(1:4) = randsample(wrong_answers,4);
    
    solution_str = [solution_str '. This choice is not present, so the correct answer is "None of these"'];
end



