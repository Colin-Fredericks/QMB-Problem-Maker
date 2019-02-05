function [correct,incorrect,problem_values,explanation] = data66()
% function data66 - Generate answers for QMB problem data66
%
%   [correct,incorrect,problem_values,explanation] = data66()
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

% Pick a row
rowInd = randsample(size(T,1),1);


% Correct answer depends on variable type
if is_str
    rightAnswer = sprintf('$%s.%s{%d}/$',tableName,varName,rowInd);
    wrongAnswer = sprintf('$%s.%s(%d)/$',tableName,varName,rowInd);
else
    rightAnswer = sprintf('$%s.%s(%d)/$',tableName,varName,rowInd);
    wrongAnswer = sprintf('$%s.%s{%d}/$',tableName,varName,rowInd);
end

% Possible choices for wrong answers
wrong_answers = {sprintf('$%s(%d).%s/$',tableName,rowInd,varName), ...
                 sprintf('$%s{%d}.%s/$',tableName,rowInd,varName), ...
                 sprintf('$%s(''%s'')(%d)/$',tableName,varName,rowInd), ...
                 sprintf('$%s[''%s''][%d]/$',tableName,varName,rowInd), ...
                 sprintf('$%s{''%s''}(%d)/$',tableName,varName,rowInd), ...
                 sprintf('$%s{''%s''}{%d}/$',tableName,varName,rowInd), ...               
                 sprintf('$%s.%s{%d}/$',varName,tableName,rowInd), ...
                 sprintf('$%s.%s(%d)/$',varName,tableName,rowInd), ...
                 sprintf('$%s.%s.%d/$',tableName,varName,rowInd), ...
                 sprintf('$%s{%s}{%d}/$',tableName,varName,rowInd) };
                 
% Decide if correct answer is present            
if rand>chance_none
     correct = rightAnswer;
     
     % Always incude the wrong answer with just the wrong brackets. Sample the others 
     incorrect = [wrongAnswer randsample(wrong_answers,2)];
     incorrect{4} = 'None of these';
     
     % No extra explanation needed
     explanation = '';
     
else
    
    % rightAnswer is missing, so correct is "None of these"
    correct = 'None of these';
    
    % Always incude the wrong answer with just the wrong brackets. Sample the others 
     incorrect = [wrongAnswer randsample(wrong_answers,3)];
    
    % Add the explanation line
    explanation = '<br/><p>However, this statement is not one of the above choices. Therefore, the correct answer is "None of these".</p>';
end
 
 
% Problem values
problem_values = {tableName,varName,rowInd,htmlString,rightAnswer,is_str,T
     }; 