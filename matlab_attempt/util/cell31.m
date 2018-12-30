function [correct,incorrect,problem_values,explanation] = cell31()
% function CELL31 - Generate answers for QMB problem cell31
%
%   [correct,incorrect,problem_values,explanation] = cell31()
%

%change the number
%use parentheses instead of curly braces
%wrong logical symbol

% Pick two indices of cells
cell_ind = randsample(10,2)';

% Pick a random letter
letter = randsample('a':'z',1);


% Pick which symbol is correct
symbols = {'==','~='};
words = {'are','are not'};
symbol_ind = randsample(2,2)';

% Curly braces are always correct so no randomization here
brackets = {'{}','()'};
bracket_ind = 1:2;

% Assemble the possible answers. The first answer will be the correct one
answers = {};
for ii = cell_ind
    for jj = symbol_ind
        for kk = bracket_ind
            answers{end+1} = sprintf('$myArray%c%d%c(myArray%c%d%c %s ''%c'')/$', ...
                brackets{kk}(1),ii,brackets{kk}(2), ...
                brackets{kk}(1),ii,brackets{kk}(2), ...
                symbols{jj},letter);
        end
    end
end

% Decide if the correct answer is 'None of these'
chance_none = 0.2;
if rand>chance_none
    correct = answers{1};
    incorrect = randsample(answers(2:end),3);
    incorrect{4} = 'None of these';
    explanation = '';
else
    correct = 'None of these';
    incorrect = randsample(answers(2:end),4);
    explanation = '<br/><p>However, this statement is not one of the above choices. Therefore, the correct answer is "None of these".</p>';
end
    

% Problem values
problem_values = {cell_ind(1),words{symbol_ind(1)},symbols{symbol_ind(1)},letter};
