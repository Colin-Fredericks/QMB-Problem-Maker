function [correct,incorrect,problem_values,explanation] = data75()
% function data75 - Generate answers for QMB problem data75
%
%  [correct,incorrect,problem_values,explanation] = data75()
%


%% Make the column

%Pick a variable
varNames =  {'Age','Height','ID'};
varName = varNames{randi(length(varNames),1)};

% Make the table with a single column
nRow = 20;
T = make_random_table('variableNames',{varName},'rangeObservations',[nRow nRow]);

% Convert to cell array of strings to make the replacement easier
T.(varName) = num2cellstr(T.(varName));

% Pick how many entries to replace
nQuestion = randi([1 2],1);
nLetter = randi([1 2],1);
nBlank = randi([1 2],1);

% Which rows to replace
nReplace = cumsum([nQuestion nBlank nLetter]);
indices = randsample(nRow,nReplace(end));

letter = randsample('ABCDEFGHKMNPQRTUVWXYZ',1);

% Do the replacements
T{indices(1:nReplace(1)),1} = repmat({'?'},nQuestion,1);
T{indices(nReplace(1)+1:nReplace(2)),1} = repmat({'<br/>'},nBlank,1);
T{indices(nReplace(2)+1:nReplace(3)),1} = repmat({letter},nLetter,1);

% Make the html version of the table. The [] input means no width is
% specified
html_str = make_html_table(T,[]);


%% Organize answers

% Correct answer
rightAnswer = sprintf('${''?'',''%c''}/$',letter);

wrongAnswers = {'$''?''/$', ...
    sprintf('$''%c''/$',letter), ...
     '$''''/$', ...   
    sprintf('$''?'',''%c''/$',letter), ... 
    sprintf('$''?'',''%c'',''''/$',letter), ...
    sprintf('${''?'',''%c'',''''}/$',letter), ...
    sprintf('$[''?'',''%c'']/$',letter), ...
    sprintf('$[''?'',''%c'','''']/$',letter), ...
    sprintf('${?,%c}/$',letter), ...
    sprintf('${?,%c,''}/$',letter)};

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
problem_values = {html_str,reference,letter};

