function [correct_answer,incorrect_answer] = arr21_1(name,columns,number,chance_none)
% function ARR21_1 - Answers for QMB problem arr21.1
%
%   [correct,incorrect] = arr21_1(array_name,num_columns,num,chance_none)
%
%

% General wrong answers that aren't problem specific
choices{1} = ['$' name ' = ' name ' + ' num2str(number) '/$'];
choices{2} = ['$' name ' = ' name '[' num2str(number) ']/$'];
choices{3} = ['$' name ' = [' name ' + ' num2str(number) ']/$'];    
choices{4} = ['$' name ' = ' name ' + [' num2str(number) ']/$'];    
choices{5} = ['$' name ' = ' name '(' num2str(number) ')/$'];  
choices{6} = ['$' name '(+1) = ' num2str(number) '/$'];  
choices{7} = ['$' name '(' num2str(number) ') = []/$'];  
choices{8} = ['$' name ' = (' name '; ' num2str(number) ')/$'];
choices{9} = ['$' name ' = (' name ', ' num2str(number) ')/$'];

% Column or row vector specifc answers
if columns == 1
    right_answer = ['$' name ' = [' name '; ' num2str(number) ']/$'];
    wrong_answer = ['$' name ' = [' name ', ' num2str(number) ']/$'];
else
    right_answer = ['$' name ' = [' name ', ' num2str(number) ']/$'];
    wrong_answer = ['$' name ' = [' name '; ' num2str(number) ']/$'];
end

%Now assemble the answers to be shown
if rand > chance_none
    correct_answer = right_answer;
    incorrect_answer{1} = wrong_answer;
    incorrect_answer{2} = 'None of these';
    incorrect_answer(3:4) = randsample(choices,2);
else
    correct_answer = 'None of these';
    incorrect_answer{1} = wrong_answer;
    incorrect_answer(2:4) = randsample(choices,3);    
end