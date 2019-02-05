function [correct,incorrect,problem_values] = data59()
% function data59 - Generate answers for QMB problem data59
%
%   [answer, html_str,rand_str] = data59()
%


%Pick a variable
varNames =  {'Age','Height','ID'};
varName = varNames{randi(length(varNames),1)};

% Make the table with a single column
T = make_random_table('variableNames',{varName},'rangeObservations',[9 12]);

% Convert to cell array of strings to make the replacement easier
T.(varName) = num2cellstr(T.(varName));

% Pick how many entries to replace
nQuestion = randi([1 2],1);
nBlank = randi([1 2],1);

% Which rows to replace
nReplace = nQuestion + nBlank;
indices = randsample(size(T,1),nReplace);

% Do the replacements
T{indices(1:nQuestion),1} = repmat({'?'},nQuestion,1);
T{indices(nQuestion+1:nReplace),1} = repmat({'<br/>'},nBlank,1);

% Make the html version of the table. The [] input means no width is
% specified
html_str = make_html_table(T,[]);

% Convert back to double to get array with NaNs
right_array = str2double(T{:,1});
correct = ['$$' mimic_array_output(right_array,'x','%6d') '/$$'];

% Wrong arrays
wrong_array{1} = right_array(~isnan(right_array)); % Only the non-NaN values
wrong_array{2} = right_array; 
wrong_array{2}(indices(1:nQuestion)) = 0; %Replace the ? with zeros
wrong_array{3} = right_array; 
wrong_array{3}(indices(nQuestion+1:nReplace)) = 0; %Replace the blanks with zeros

% Various incorrect answers
for ii = 1:length(wrong_array)
    incorrect{ii} = ['$$' mimic_array_output(wrong_array{ii},'x','%6d') '/$$'];
end
incorrect{4} = 'Matlab can''t import this data';

%Organize output
problem_values = {html_str,nReplace};

