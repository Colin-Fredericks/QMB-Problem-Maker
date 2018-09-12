function [correct,incorrect,ask_str,solution_str] = subplot3(place,chance_none)
% Function SUBPLOT2 - QMB problem subplot3
%
%   [correct,incorrect,ask_str,sol_str] = subplot3(place,chance_none) 
%       Generates the answers for QMB problem subplot3. 
%

%This question assumes place is never 2, otherwise there will be repeats in
%the answers

%Get ask str for displaying question
if place == 1
    ask_str = 'top left';
elseif place == 2
    error('Place must be 1, 3, or 4')   
elseif place == 3
    ask_str = 'bottom left';
elseif place == 4
    ask_str = 'bottom right';
end
    

%Assemble answers
format = '$subplot(%d,%d,%d)/$';
right_answer = sprintf(format,2,2,place);

%Set up wrong answers
wrong_ind = 1:4;
wrong_ind(place) = [];

wrong_answers{1} = sprintf(format,2,2,wrong_ind(1));
wrong_answers{2} = sprintf(format,2,2,wrong_ind(2));
wrong_answers{3} = sprintf(format,2,2,wrong_ind(3));
wrong_answers{4} = sprintf(format,1,2,2);
wrong_answers{5} = sprintf(format,2,1,2);
wrong_answers{6} = sprintf(format,3,2,2);
wrong_answers{7} = sprintf(format,2,3,2);
wrong_answers{8} = sprintf(format,4,2,2);
wrong_answers{9} = sprintf(format,2,4,2);

%String for helping explain the answer
solution_str = right_answer;

%Pick which ones to output
if rand > chance_none
    correct = right_answer;
    incorrect(1:3) = randsample(wrong_answers,3);
    incorrect{4} = 'None of these';
else
    correct = 'None of these';
    incorrect(1:4) = randsample(wrong_answers,4);
    
    solution_str = [solution_str '. This choice is not present, so the correct answer is "None of these"'];
end



