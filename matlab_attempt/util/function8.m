function [choices,correct_strings,input,explanation,correct] = function8()
% Function FUNCTION8 - QMB problem function8
%
%   [correct, incorrect, input, explanation] = function8()
%       
%
% r = mod(x,10) + 1;
% if r < 3
%     y = r * (r+1) / 2;
% elseif r < 5
%     y = [1:r, r:-1:1];
% elseif r < 7
%     y = eye(r); 
% elseif r < 9
%     letters = 'abcdefghijklmnopqrstuvwxyz';
%     y = letters(r:2*r);
% else
%     y = r > 9
% end

% Pick number to ask about
input = randi(1000,1);
r = mod(input,10) + 1;

% 5 answer types
answers{1} = r * r(+1) / 2;
answers{2} = [1:r, r:-1:1];
answers{3} = eye(r);
answers{4} = extract('a':'z',r:2*r);
answers{5} = r > 9;


% Get String output for displaying choices
choices = cell(size(answers));
for ii = 1:length(answers)
    choices{ii} = ['$$' mimic_array_output(answers{ii}) '/$$'];
end

% Fix last choice to make sure they know it's logical
choices{5} = [choices{5} char(10) '(logical)'];

% Pick the correct answer
correct_logical = ceil(r/2) == 1:5;
correct_strings = convert_logical(correct_logical);

% 5 explanations
explain_start = ['This will set the input $x = ' num2str(input) '/$. The value $r = mod(' num2str(input) ',10) + 1 = ' num2str(r-1) ' + 1 = ' num2str(r) '/$.'];
explain_ends{1} = ['Since $r < 3$, then the output will be a scalar $y = ' num2str(r) ' * (' num2str(r) '+1) / 2 = ' num2str(answers{1}) '/$.'];
explain_ends{2} = ['Since  $r >= 3/$ but $r < 5/$, then the output will be a vector $y = [1:' num2str(r) ' ' num2str(r) ':-1:1] = ' mat2string(answers{2}) '/$.'] ;
explain_ends{3} = ['Since  $r >= 5/$ but $r < 7/$, then the output will be a matrix $ y = eye(' num2str(r) ')/$. This is a square ' num2str(r) 'x' num2str(r) ' matrix with ones along the diagonal and zeros everywhere else.'];
explain_ends{4} = ['Since  $r >= 7/$ but $r < 9/$, then the output will be a character string. The variable $letters/$ is a string with the alphabet, so $y = letters(r:2*r) = letters(' num2str(r) ':' num2str(2*r) ') = ' answers{4} '/$.'];
explain_ends{5} = ['Since  $r >= 9/$, the $else/$ condition applies. The output will be a logical value $y = r > 9 = ' num2str(r) ' > 9 = ' num2str(r>0) '/$.'];

% Assemble the full explanation
explanation = [explain_start ' ' explain_ends{correct_logical}];

%Also return the correct answer for explanation purposes
correct = choices{correct_logical};
   





