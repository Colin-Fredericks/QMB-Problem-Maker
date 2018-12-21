function [display,correct,incorrect,reference,explanation] = function3()
% Function FUNCTION3 - QMB problem function3
%
%   [display,correct,incorrect,reference,explanation] = function3()
%       
%
%

% Pick number of inputs and outputs
nInputs = randi([2 6],1);
nOutputs = randi([2 6],1);

% Pick variable names
inLetters = randsample('abcdfghklmn',nInputs);
outLetters = randsample('pqrstuvwxyz',nOutputs);
inString = strjoin(num2cellstr(inLetters),',');
outString = strjoin(num2cellstr(outLetters),',');


%Pick a random variable type for one of the wrong answers
variableType = randsample({'double','int','string','single'},1);
wrongInString = [variableType{1} ' ' ...
    strjoin(num2cellstr(inLetters),[', ' variableType{1} ' '])];
wrongOutString = [variableType{1} ' ' ...
    strjoin(num2cellstr(outLetters),[', ' variableType{1} ' '])];
    

displays = {['function [' outString '] = myFunction(' inString ')'], ...
            ['function (' outString ') = myFunction(' inString ')'], ...
            ['function [' outString '] = myFunction[' inString ']'], ...
            ['[' outString '] = myFunction(' inString ')'], ...
            ['function [' outString '] = myFunction(' strjoin(num2cellstr(inLetters),';') ')'], ...
            ['function [' strjoin(num2cellstr(outLetters),';') '] = myFunction(' inString ')'], ...
            ['function [' outString '] = myFunc(' inString ')'], ...
            ['def [' outString '] = myFunction(' inString ')'], ...
            ['function [' outString '] = _myFunction(' inString ')'], ...
            ['function [' wrongOutString '] = myFunction(' wrongInString ')'], ...
            ['public function [' outString '] = myFunction(' inString ')'], ...
            ['function [' outString '] = (' inString ')'], ...
            };
        
choices = {'This definition has no mistakes', ...
           'This definition encloses the outputs in parenetheses instead of square brackets', ...
           'This definition encloses the inputs in square brackets instead of parentheses', ...
           'This definition is missing the word $function/$', ...
           'This definition uses the wrong delimiter for the inputs', ...
           'This definition uses the wrong delimiter for the outputs', ...
           'The function name does not match the file name, but it will still run', ...
           'This function uses the wrong keyword instead of $function/$', ...
           'The function name does not match the file name, and it will cause an error', ...
           'This definition has unncessary variable types for the inputs and outputs', ...
           'This definition has has unneccesary keywords before $function/$', ...
           'This definition has no function name' };
       
       
explanations = {'', ...
    'Inputs must be enclosed in parentheses, and outputs must be enclosed in square brackets.', ...
    'Inputs must be enclosed in parentheses, and outputs must be enclosed in square brackets.', ...
    'You must begin every function definition with the keyword $function/$. If you type this line, Matlab will treat this as any other line of code and think you are trying to call a function defined elsewhere.' ...
    'Both inputs and outputs must be delimited with commas.', ...
    'Both inputs and outputs must be delimited with commas.', ...
    'This function will still run, but you will have to use the filename when calling the function, e.g. $myFunction()/$. Typing $myFunc/$ will produce an error (unless it is defined elsewhere). You should always make sure the function name in the definition matches the filename.', ...
    'Matlab functions must begin with the keyword $function/$. Other languages have other syntaxes. Python, for example, uses the keyword $def/$.', ...
    'This function will not run because the function name begins with an underscore. Matlab has the same restrictions for function names that is has for variables, i.e. it must begin with a letter, and then only contain letters, numbers and underscores after that.', ...
    'Matlab does not require you to define variable types, whether it''s in function definitions or regular code. Some programming languages like C and Java are more strict and require to specify a variable type like $int/$, $single/$, $double/$, or $string/$.', ...
    'Matlab functions should only begin with the keyword $function/$. Some programming languages have other types of keywords, like $public/$ or $private/$ to help define a function''s scope.', ...
    'Don''t forget to include a function name!'};


% Pick one choice to display        
ind = randi(length(displays),1);
display = displays{ind};

if ind==1
    explanation = '';
else
    explanation = ['<br/><p>The function definition in the question statement has a mistake. ' explanations{ind} '</p>'];
end

 
% Get the right answer
correct = choices{ind};

%Pick 4 wrong answers 
other_ind = randsample([1:ind-1 ind+1:length(choices)],4);
incorrect = choices(other_ind);

%Reference is the correct way to define the function (first display)
reference = displays{1};



