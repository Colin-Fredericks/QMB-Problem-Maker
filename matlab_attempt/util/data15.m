function [correct,incorrect,explanation,names,reference_answer] = data15()
% function DATA15 - QMB problem data15
%
%   [display,correct,incorrect,explanation,names,reference] = data15()
%
%

%  Chance for 'None of these' to be the correct answer.
chance_none = 0.125;

% Pick variable names
names = randsample('ABCDEFGHKLMNPQRSTUVWZ',2);
header = sprintf('figure() \nplot(%s,%s,''.'')', ...
    names(1),names(2));

% Key:
% 1. No mistake
% 2. Brackets 
% 3. No quotation marks
% 4. Switch x/y
% 5. No num2str 
% 6. Wrong function name
% 7. Not labeled at all
% 8. Label y but not both

% Displays
choices{1} = sprintf('%s \nxlabel(''Variable %s'') \nylabel(''Variable %s'')', ...
        header,names(1),names(2)); 
choices{2} = sprintf('%s \nxlabel[''Variable %s''] \nylabel[''Variable %s'']', ...
        header,names(1),names(2));    
choices{3} = sprintf('%s \nxlabel(Variable %s) \nylabel(Variable %s)', ...
        header,names(1),names(2)); 
choices{4} = sprintf('%s \nxlabel(''Variable %s'') \nylabel(''Variable %s'')', ...
        header,names(2),names(1)); 
choices{5} = sprintf('%s \nxlabel([''Variable #'',1]) \nylabel([''Variable #'',2])', ...
        header);    
choices{6} =  sprintf('%s \nlabelx(''Variable %s'') \nlabely(''Variable %s'')', ...
        header,names(1),names(2));
choices{7} = sprintf('%s',header);
choices{8} = sprintf('%s \nylabel(''Variable %s'')',header,names(2)); 

% Answer explain_start
explain_start{1} = 'None of these. This code is correct';
explain_start{2} = 'This code uses square brackets with the label functions';
explain_start{3} = 'This code does not enclose the inputs to the label functions in quotation marks';
explain_start{4} = 'This code has the x-axis labeled with the variable plotted on the y-axis and vice versa';
explain_start{5} = 'This code does not use $num2str/$ to add a number in an axis label';
explain_start{6} = 'This code uses the wrong function names to label the axes';
explain_start{7} = 'This code does not label the axes at all';
explain_start{8} = 'This code labels one axis but not the other';

%Explanations
explain_end{1} = 'It uses the $xlabel/$ and $ylabel/$ functions properly to create appropriate labels';  
explain_end{2} = sprintf('The proper syntax uses parentheses, e.g. $xlabel(''Variable %s'')/$',names(1));
explain_end{3} = sprintf('The input arguments to the label functions must be strings, e.g. $xlabel(''Variable %s'')/$',names(1));
explain_end{4} = sprintf('These are the wrong labels, since $%s/$ is the independent variable and $%s/$ is the dependent variable. The $xlabel/$ and $ylabel/$ should be switched',names(1),names(2));
explain_end{5} = 'It attempts to concatenate a string $''Variable #''/$ with a number $1/$. This will cause an error because they are different variable types. You should convert the number to a string first, e.g. $[''Variable #'' num2str(1)]/$';
explain_end{6} = 'The proper spelling is $xlabel/$ instead of $labelx/$';
explain_end{7} = sprintf('It plots the data correctly, but it should include $xlabel(''Variable %s'')/$ and $ylabel(''Variable %s'')/$',names(1),names(2));
explain_end{8} = sprintf('It should also include the line $xlabel(''Variable %s'')/$',names(1));

% Assemble answers
if rand>chance_none
    
    %Get correct answer
    correct =  ['$$' choices{1} '/$$'];
    
    %Pick incorrect answers
    choice_ind = randsample(2:8,3);
    incorrect = choices(choice_ind);    
    
    %Add $$ around answers and assemble explanation
    explanation = [];
    for ii = 1:length(incorrect)
        incorrect{ii} = ['$$' incorrect{ii} '/$$'];
        explanation = [explanation '<li>' incorrect{ii} '<br/> ' ...
            explain_start{choice_ind(ii)} '. ' ...
            explain_end{choice_ind(ii)} '.</li>'];
    end
    
    % Add none of these
    incorrect{4} = 'None of these are correct';
else
    
    % Correct is none of these
    correct = 'None of these are correct';
    
    % Pick 4 incorrect answers
    choice_ind = randsample(2:8,4);
    incorrect = choices(choice_ind);
    
    %Add $$ around answers and assemble explanation
    explanation = [];    
    for ii = 1:length(incorrect)
        incorrect{ii} = ['$$' incorrect{ii} '/$$'];
        explanation = [explanation '<li>' incorrect{ii} '<br/> ' ...
            explain_start{choice_ind(ii)} '. ' ...
            explain_end{choice_ind(ii)} '.</li>'];
    end
end

% Output reference answer 
reference_answer = ['$$' choices{1} '/$$'];
     
