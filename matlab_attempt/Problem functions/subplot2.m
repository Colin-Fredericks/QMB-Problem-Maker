function [correct,incorrect,solution_str] = subplot2(num_row,num_col,chance_none)
% Function SUBPLOT2 - QMB problem subplot2
%
%   [correct,incorrect] = subplot2(num_row,num_col,chance_none) 
%       Generates the answers for QMB problem subplot2. 
%


%Assemble answers
format = '$subplot(%d,%d,%d)/$';
right_answer = sprintf(format,num_row,num_col,1);
wrong_answers{1} = sprintf(format,num_row,num_col,num_row*num_col);
wrong_answers{2} = sprintf(format,num_row,num_col,num_row);
wrong_answers{3} = sprintf(format,num_row,num_col,num_col);
wrong_answers{4} = sprintf(format,num_col,num_row,num_row*num_col);
wrong_answers{5} = sprintf(format,num_col,num_row,1);
wrong_answers{6} = sprintf(format,num_col,num_row,num_row);
wrong_answers{7} = sprintf(format,num_col,num_row,num_col);

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



