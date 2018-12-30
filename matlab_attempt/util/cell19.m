function [choices,problem_values] = cell19()
%Function CELL19: Creates answers for QMB problem 'cell19'
%
%   [choices,problem_values] = cell19()


% Pick 5 random long words
while true 
    words = sample_random_words(5); 
    lengths = cellfun(@length,words); 
    if all(lengths>5) 
        break 
    end 
end 

%Pick one of the words to be the answer
ansWordIndex = randi(5,1);
ansWord = words{ansWordIndex};
[ansColonStr,ansSubIndex] = pick_indices(ansWord);
ansSubstr = ansWord(ansSubIndex);

% Add correct choice to choices cell array
choices{1} = sprintf('$myArray{%d}(%s)/$',ansWordIndex,ansColonStr);

% Pick other choices (make sure the substring it returns is unique
while length(choices)<5

    % Pick a random word and indices
    wordIndex = randi(5,1);
    
    % Make sure that at least one index matches the correct choice so it 
    % isn't too easy for the students 
    if length(choices)==1
        wordIndex=ansWordIndex;
    end
    
    % Pick out the substring
    word = words{wordIndex};
    [colonStr,subIndex] = pick_indices(word);
    substr = word(subIndex);
    
    % Only add if the choice is new AND the substring returned is different 
    % from the answer
    possible_choice = sprintf('$myArray{%d}(%s)/$',wordIndex,colonStr);
    if ~ismember(possible_choice,choices) && ~strcmp(substr,ansSubstr)
        choices{end+1} = possible_choice;
    end
end

problem_values = {words,ansSubstr,ansWord,ansWordIndex,ansSubIndex};

end

function [output_string,output_values] = pick_indices(input_string)
% Usage:
%
%   [output_string,output_values] = pick_indices(input_string)
%
% This picks some random indexes that can be used to return a substring of
% the input string.

start = randi(3,1);
stop = randi([4 length(input_string)-1],1);
output_string = sprintf('%d:%d',start,stop);
output_values = start:stop;

end

