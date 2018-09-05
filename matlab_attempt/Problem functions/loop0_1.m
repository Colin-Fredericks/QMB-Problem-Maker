function [display,correct,incorrect] = loop0_1(ind1,ind2,loop_var_name,chance_none)
% Function PATH3 - QMB problem loop0.1
%
%   display,correct,incorrect] = loop0_1(ind1,ind2,loop_var_name)
%       Generates the answers for QMB problem loop0.1. 
%
%



line_break = char([10 32 32 32 32]);
ind_str = sprintf('%d:%d',ind1,ind2);
off_str = sprintf('%d:%d',ind1,ind2-1);
displays ={['for ii = ' ind_str line_break 'ii' char(10) 'end'], ...
           ['ii = ' ind_str line_break 'ii' char(10) 'end'], ...
           ['for ' ind_str line_break 'ii' char(10) 'end'], ...
           ['for ii == ' ind_str line_break 'ii' char(10) 'end'], ...
           ['for ii = ' ind_str line_break 'ii' char(10)], ...
           ['for ii' line_break 'ii' char(10) 'end'], ...
           ['for ii = ' ind_str char(10) 'end'], ...
           ['for ii = ' off_str line_break 'ii' char(10) 'end'], ...
           ['for ii = ' ind_str ' {' line_break 'ii' char(10) '}'], ...
           ['for ii in ' ind_str line_break 'ii' char(10) 'end'], ...
           ['for ii < length(' ind_str ')' line_break 'ii' char(10) 'end']};
           
% Define the multiple choices
choices =  {'None of these. This code has no mistakes', ...
            'This code is missing the $for/$ keyword', ...
            'This code is missing the loop variable $ii/$', ...
            'This code defines $ii/$ incorrectly with $==/$', ...
            'This code is missing the $end/$ keyword', ...
            'This code does not set any values to the loop variable $ii/$', ...
            'This code is missing a statement inside the for loop', ...
            'This does not does not print the right values', ...
            'This code uses the wrong syntax to enclose the loop statement', ...
            'This code defines $ii/$ incorrectly with $in/$', ...
            'This code uses a logical statment in the for loop definition'};

% Determine if "None of these is the correct answer        
if rand > chance_none
    
    % Pick one choice to display        
    ind = randi([2 length(displays)],1);
    display = ['$$' displays{ind} '/$$'];
    display = strrep(display,'ii',loop_var_name);

    % Get the right answer
    correct = choices{ind};
    correct = strrep(correct,'ii',loop_var_name);

    %Pick 3 wrong answers and "None of these"
    other_ind = randsample([2:ind-1 ind+1:length(choices)],3);
    incorrect = choices(other_ind);
    incorrect(end+1) = choices(1);
    incorrect = strrep(incorrect,'ii',loop_var_name);
else
    
    %Correct answer is None of these
    display = ['$$' displays{1} '/$$'];
    display = strrep(display,'ii',loop_var_name);
    
    correct = choices{1};
    correct = strrep(correct,'ii',loop_var_name);
    
    % Pick 4 wrong answers
    other_ind = randsample(2:length(choices),4);
    incorrect = choices(other_ind);
    incorrect = strrep(incorrect,'ii',loop_var_name);
end
    



