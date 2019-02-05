function [correct,incorrect,problem_values,explanation] = data74()
% function data74 - Generate answers for QMB problem data74
%
%    [correct,incorrect,problem_values,explanation] = data74()
%

%% Make the table

% Make the table with 5 columns: 2 text and 3 numeric
varNames =  {'FirstName','LastName','Age','Height','ID'};
nRow = 15;
T = make_random_table('variableNames',varNames,'rangeObservations',[nRow nRow]);

% Replace an element in each numberic column with a different type of
% character. 
replaceOptions = {'?','<br/>','X'};
replaceOptions = replaceOptions(randperm(3));

% Do replacement for each numeric variable
numberVars = {'Age','Height','ID'};
for iVar = 1:length(numberVars)
    
    % Get variable name and string to replace with
    varName = numberVars{iVar};
    replaceCell = replaceOptions(iVar);
    
    % Convert to cell array of strings to make the replacement easier
    T.(varName) = num2cellstr(T.(varName));

    % Pick how many entries to replace
    nReplace = randi([1 2],1);

    % Which rows to replace
    indices = randsample(nRow,nReplace);

    % Do the replacements
    T{indices,varName} = repmat(replaceCell,nReplace,1);

end

% Replace one of the last and first names with a -1
T{randi(nRow,1),'LastName'} = {'-1'};
T{randi(nRow,1),'FirstName'} = {'-1'};

% Make the html version of the table. The [] input means no width is
% specified
htmlStr = make_html_table(T,[]);

%% Organize answers

% Pick a file name
fileNames = {'data','results','info','experiment','report','details'};
number_suffix = sprintf('%02d',randi(10,1));
fileName = [fileNames{randi(length(fileNames),1)} number_suffix '.txt'];

% Correct answer
rightAnswer = sprintf('$$myTable = readtable(''%s'',''TreatAsEmpty'',{''?'',''X''});/$$',fileName);

wrongAnswers = {sprintf('$$myTable = readtable(''%s'',''TreatAsEmpty'',''?'');/$$',fileName), ...
    sprintf('$$myTable = readtable(''%s'',''TreatAsEmpty'',''X'');/$$',fileName), ...
    sprintf('$$myTable = readtable(''%s'',''TreatAsEmpty'','''');/$$',fileName), ...
    sprintf('$$myTable = readtable(''%s'',''TreatAsEmpty'',''?'','''');/$$',fileName), ...
    sprintf('$$myTable = readtable(''%s'');/$$',fileName), ...
    sprintf('$$myTable = readtable(''%s'',''TreatAsEmpty'',''?'');/$$',fileName), ...
    sprintf('$$myTable = readtable(''%s'',''TreatAsEmpty'',{''?'',''X'',-1});/$$',fileName), ...
    sprintf('$$myTable = readtable(''%s'',''TreatAsEmpty'',-1);/$$',fileName), ...
    sprintf('$$myTable = readtable(''%s'',''TreatAsEmpty'',[''?'',''X'']);/$$',fileName), ...
    sprintf('$$myTable = readtable(''%s'',''TreatAsEmpty'',''?'',''X'');/$$',fileName), ...
    sprintf('$$myTable = readtable(''%s'',''TreatAsEmpty'',''?'',''X'',-1);/$$',fileName), ...
    sprintf('$$myTable = readtable(''%s'',''TreatAsEmpty'',{?,X});/$$',fileName), ...
    sprintf('$$myTable = readtable(''%s'',''TreatAsEmpty'',{?,X,-1});/$$',fileName)};

% Decide if the correct answer is present or "None of these"
chance_none = 0.2;
if rand>chance_none
    
    % Correct answer is correct line. 
    correct = rightAnswer;

    % For the incorrect, just pick randomly
    incorrect = randsample(wrongAnswers,3);
    
    % Last incorrect is "None of these"
    incorrect{4} = 'None of these';
    
    % No extra explanation needed
    explanation = '';
else
    
    % Correct answer is "None of these". 
    correct = 'None of these';
    
    % For the incorrect, just pick randomly
    incorrect = randsample(wrongAnswers,4);  
    
    % Extra explanation
    explanation = '<br/><p>However, this statement is not one of the above choices. Therefore, the correct answer is "None of these".</p>';
end

% Output values needed to display the problem and solution
reference = rightAnswer;
problem_values = {fileName,htmlStr,reference};
