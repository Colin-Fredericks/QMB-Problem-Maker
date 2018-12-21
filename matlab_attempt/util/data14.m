function [display,correct,incorrect,explanation,names,reference_answer] = data14()
% function DATA14 - QMB problem data14
%
%   [display,correct,incorrect,explanation,names,reference] = data14()
%
%

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
displays{1} = sprintf('%s \nxlabel(''Variable %s'') \nylabel(''Variable %s'')', ...
        header,names(1),names(2)); 
displays{2} = sprintf('%s \nxlabel[''Variable %s''] \nylabel[''Variable %s'']', ...
        header,names(1),names(2));    
displays{3} = sprintf('%s \nxlabel(Variable %s) \nylabel(Variable %s)', ...
        header,names(1),names(2)); 
displays{4} = sprintf('%s \nxlabel(''Variable %s'') \nylabel(''Variable %s'')', ...
        header,names(2),names(1)); 
displays{5} = sprintf('%s \nxlabel([''Variable #'',1]) \nylabel([''Variable #'',2])', ...
        header);    
displays{6} =  sprintf('%s \nlabelx(''Variable %s'') \nlabely(''Variable %s'')', ...
        header,names(1),names(2));
displays{7} = sprintf('%s',header);
displays{8} = sprintf('%s \nylabel(''Variable %s'')',header,names(2)); 

% Answer choices
choices{1} = 'None of these. This code is correct';
choices{2} = 'This code uses square brackets instead of parentheses with the label functions';
choices{3} = 'This code does not enclose the inputs to the label functions in quotation marks';
choices{4} = 'This code has the x-axis labeled with the variable plotted on the y-axis and vice versa';
choices{5} = 'This code does not use $num2str/$ to add a number in an axis label';
choices{6} = 'This code uses the wrong function names to label the axes';
choices{7} = 'This code does not label the axes at all';
choices{8} = 'This code labels one axis but not the other';

%Explanations
explanations{1} = 'It uses the $xlabel/$ and $ylabel/$ functions properly to create appropriate labels';  
explanations{2} = sprintf('The proper syntax uses parentheses instead of brackets, e.g. $xlabel(''Variable %s'')/$',names(1));
explanations{3} = sprintf('The input arguments to the label functions must be strings, e.g. $xlabel(''Variable %s'')/$',names(1));
explanations{4} = sprintf('These are the wrong labels, since $%s/$ is the independent variable and $%s/$ is the dependent variable. The $xlabel/$ and $ylabel/$ should be switched',names(1),names(2));
explanations{5} = 'It attempts to concatenate a string $''Variable #''/$ with a number $1/$. This will cause an error because they are different variable types. You should convert the number to a string first, e.g. $[''Variable #'' num2str(1)]/$';
explanations{6} = 'The function names are spelled incorretly, e.g. $labelx/$ instead of $xlabel/$';
explanations{7} = sprintf('It plots the data correctly, but does not label the axes with statements like $xlabel(''Variable %s'')/$ and $ylabel(''Variable %s'')/$',names(1),names(2));
explanations{8} = sprintf('It only labels the y-axis. It should also include the line $xlabel(''Variable %s'')/$',names(1));
 
% Choose an integer
choice = randi(8,1);
correct = choices{choice};

% Pick incorrect answers. Make sure 'None of these' is always one of the
% incorrect answers.
if choice == 1
    incorrect = randsample(choices(2:8),4);
else
    incorrect = [choices(1), choices(randsample([2:choice-1 choice+1:8],3))];
end

%Pick out display and explanation
display = displays{choice};
explanation = explanations{choice};
reference_answer = displays{1};
     
