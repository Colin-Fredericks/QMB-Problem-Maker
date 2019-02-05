function [correct,incorrect,problem_values,explanation] = data65()
% function data65 - Generate answers for QMB problem data65
%
%   [correct,incorrect,problem_values,explanation] = data65()
%

% Chance of answer being 'None of these'
chance_none = 0.2;

% Decide which variables are in the table
strVar = {'FirstName','LastName','City','EyeColor','HairColor','RandomString','RandomWord'};
numVar = {'Age','Height','ID','RandomDecimal','RandomInteger'};
numInd = randsample(length(numVar),randi([2 3],1));
strInd = randsample(length(strVar),randi([2 3],1));

% Make the table and display
T = make_random_table('variableNames',[strVar(strInd) numVar(numInd)], ...
    'rangeObservations',[4 10]);
htmlString = make_html_table(T,[]);

% Pick a table name
tableNames = {'T','data','myTable','myInfo','myData'};
tableName = tableNames{randi(length(tableNames),1)};

% Pick a variable name
is_str = rand<0.5; 
if is_str 
    varName = strVar{randsample(strInd,1)}; 
else 
    varName = numVar{randsample(numInd,1)}; 
end

% Correct answer
rightAnswer = sprintf('$%s.%s/$',tableName,varName);

% Possible choices for wrong answers
wrong_answers = {sprintf('$%s(%s)/$',tableName,varName), ...
                 sprintf('$%s(''%s'')/$',tableName,varName), ...
                 sprintf('$%s[''%s'']/$',tableName,varName), ...
                 sprintf('$%s{''%s''}/$',tableName,varName), ...
                 sprintf('$%s.(%s)/$',tableName,varName), ...                 
                 sprintf('$%s.%s/$',varName,tableName), ...
                 sprintf('$%s.''%s''/$',tableName,varName), ...
                 sprintf('$%s{%s}/$',tableName,varName), ...                 
                 sprintf('$return(''%s'',''%s'')/$',tableName,varName), ...
                 sprintf('$extract(''%s'',''%s'')/$',tableName,varName) };
                 
% Decide if correct answer is present            
if rand>chance_none
     correct = rightAnswer;     
     incorrect = randsample(wrong_answers,3);
     incorrect{4} = 'None of these';
     explanation = '';
     
else
    correct = 'None of these';
    incorrect = randsample(wrong_answers,4);
    explanation = '<br/><p>However, this statement is not one of the above choices. Therefore, the correct answer is "None of these".</p>';
end
 
 
% Problem values
problem_values = {tableName,varName,rightAnswer,htmlString,T}; 