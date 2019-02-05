function [choice, html_str,T] = data70()
% function data70 - Generate answers for QMB problem data70
%
%   [choice, html_str] = data70()
%


% Make the table with 3 columns
varNames =  {'Age','Height','ID'};
nRow = 20;
T = make_random_table('variableNames',varNames,'rangeObservations',[nRow nRow]);

% Do replacement for each variable
for varName = varNames
    
    % Convert to cell array of strings to make the replacement easier    
    T.(varName{1}) = num2cellstr(T.(varName{1}));

    % Pick how many entries to replace
    nQuestion = randi([1 4],1);

    % Which rows to replace
    indices = randsample(nRow,nQuestion);

    % Do the replacements
    T{indices,varName{1}} = repmat({'?'},nQuestion,1);
    
end

% Make the html version of the table. The [] input means no width is
% specified
html_str = make_html_table(T,[]);

% Pick one of the variables to ask about
choice = varNames{randi(length(varNames),1)};

