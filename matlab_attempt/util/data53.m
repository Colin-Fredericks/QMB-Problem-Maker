function [html_str,rand_str] = data53()
% function data53 - Generate answers for QMB problem data53
%
%   [html_str,rand_str] = data53()
%



%Pick a variable
varNames = {'FirstName','LastName','City','EyeColor','HairColor', ...
    'RandomString','RandomWord'};
varName = varNames{randi(length(varNames),1)};

% Make the table with a single column
T = make_random_table('variableNames',{varName},'rangeObservations',[30 30]);

% Pick how many entries to replace
nQuestion = randi([1 3],1);
nBlank = randi([1 3],1);
nNegOne = randi([1 2],1);
nRand = randi([1 2],1);

% Which rows to replace
nReplace = cumsum([nQuestion nBlank nNegOne nRand]);
indices = randsample(30,nReplace(4));

% Do the replacements
T{indices(1:nReplace(1)),1} = repmat({'?'},nQuestion,1);
T{indices(nReplace(1)+1:nReplace(2)),1} = repmat({'<br/>'},nBlank,1);
T{indices(nReplace(2)+1:nReplace(3)),1} = repmat({'-1'},nNegOne,1);
T{indices(nReplace(3)+1:nReplace(4)),1} = num2cellstr(rand(nRand,1));

% Return one of the random numbers so it can be used in the explanation
rand_str = T{indices(end),1}{1};

% Make the html version of the table. The [] input means no width is
% specified
html_str = make_html_table(T,[]);

