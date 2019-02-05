function [answer,funcName,inString,outString,reference] = function4_1()
% Function FUNCTION4_1 - QMB problem function4.1
%
%   [answer,funcName,inString,outString,reference] = function4_1()
%   
%

% Pick number of inputs and outputs
nInputs = randi([2 3],1);
nOutputs = randi([2 3],1);

% Pick variable names
inLetters = randsample('abcdfghklmn',nInputs);
outLetters = randsample('pqrstuvwxyz',nOutputs);

% Function for adding the $ tags or the 
addTag = @(x) ['$' x '/$'];

% Make the strings for the question statement
inCell = arrayfun(addTag,inLetters,'UniformOutput',false);
inString = [strjoin(inCell(1:end-1),', ') ' and ' inCell{end}];

outCell = arrayfun(addTag,outLetters,'UniformOutput',false);
outString = [strjoin(outCell(1:end-1),', ') ' and ' outCell{end}];

% Make the argument strings
inArg = make_argument(inLetters);
outArg = make_argument(outLetters);

% Pick a function name
funcNames = {'myFunc','myFunction','randFunc','randomFunction','doSomething'};
funcName = funcNames{randi(length(funcNames),1)};

% Assemble the answer
answer = ['\s*function\s*\[' outArg '\]\s*=\s*' funcName '\s*\(' inArg '\)\s*'];

% Reference
outRef = strjoin(cellstr(outLetters'),',');
inRef = strjoin(cellstr(inLetters'),',');
reference = ['function [' outRef '] = ' funcName '(' inRef ')'];


end


function argStr = make_argument(letters)
% This function makes the various permutations of the input letters. For 
% example, if the input is 'abc', then we want to accept 'a,b,c', 'b,c,a',
% 'a,c,b', etc.

% Permute the letters
letterPerms = perms(letters);

% Function for adding spaces
addS = @(x) ['\s*' x '\s*'];

% Iterate through permutations, making a string for each
permStr = {};
for iPerm = 1:size(letterPerms,1)
    
    % Use arrayfun to add the optional spaces \s*
    permCell = arrayfun(addS,letterPerms(iPerm,:),'UniformOutput',false);
    
    % Join together with commas
    permStr{iPerm} = strjoin(permCell,',');    
    
end

%Finally, add the | character so any will work in the regex
argStr = ['(' strjoin(permStr,'|') ')'];

end


