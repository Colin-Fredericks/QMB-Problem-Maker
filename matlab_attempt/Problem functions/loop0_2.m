function [correct,incorrect] = loop0_2(ind1,ind2,loop_var_name,chance_none)
% Function PATH3 - QMB problem loop0.1
%
%   [correct,incorrect] = loop0_2(ind1,ind2,loop_var_name,chance_none)
%       Generates the answers for QMB problem loop0.2. 
%
%



line_break = char([10 32 32 32 32]);
ind_str = sprintf('%d:%d',ind1,ind2);
off_str = sprintf('%d:%d',ind1,ind2-1);
right_choice = ['$$for ii = ' ind_str line_break 'ii' char(10) 'end/$$'];
wrong_choices ={['$$ii = ' ind_str line_break 'ii' char(10) 'end/$$'], ...
                ['$$for ' ind_str line_break 'ii' char(10) 'end/$$'], ...
                ['$$for ii == ' ind_str line_break 'ii' char(10) 'end/$$'], ...
                ['$$for ii = ' ind_str line_break 'ii' char(10) '/$$'], ...
                ['$$for ii' line_break 'ii' char(10) 'end/$$'], ...
                ['$$for ii = ' ind_str char(10) 'end/$$'], ...
                ['$$for ii = ' off_str line_break 'ii' char(10) 'end/$$'], ...
                ['$$for ii = ' ind_str ' {' line_break 'ii' char(10) '}/$$'], ...
                ['$$for ii in ' ind_str line_break 'ii' char(10) 'end/$$'], ...
                ['$$for ii < length(' ind_str ')' line_break 'ii' char(10) 'end/$$']};
  

% Determine if "None of these is the correct answer        
if rand < chance_none
    
    % Get the right answer
    correct = 'None of these';

    %Pick 3 wrong answers and "None of these"
    incorrect = randsample(wrong_choices,4);
    incorrect = strrep(incorrect,'ii',loop_var_name);
else
     
    correct = right_choice;
    correct = strrep(correct,'ii',loop_var_name);
    
    % Pick 3 wrong answers    
    incorrect = randsample(wrong_choices,3);
    incorrect = strrep(incorrect,'ii',loop_var_name);
    incorrect{end+1} = 'None of these';
end
    



