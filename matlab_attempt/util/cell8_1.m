function [answers,correctness,array_name,explanation] = cell8_1()
% function CELL8_1 - Generate answers for qmb PROBLEM cell8.1
%
%   [answers,correctness,array_name,explanation] = cell8_1()
%


% Pick an array name
array_name = randsample('ABCDEFGHKMNPQRTUVWXYZ',1);

% Create str for an array with numbers
nRow = randi(3,1);
nCol = randi([2 5],1);
temp_str = mat2string(randi(10,nRow,nCol));
num_array_str = temp_str(2:end-1); %Remove the brackets

% Create str for an array with strings
nWords = randi([2 5],1);
words = sample_random_words(nWords);
word_array_str = ['''' strjoin(words,''', ''') ''''];

% Create the array with different variable types
integer = num2str(randi(100,1));
decimal = num2str(rand);
string = ['''' randsample('a':'z',randi([3 6],1)) ''''];
array =	mat2string(randsample(1:10,randi([2 4],1)));
mixed_cell = {integer, decimal, string, array, '[]'};
mixed_array_str = strjoin(mixed_cell(randperm(length(mixed_cell))),', ');

% Empties
empty_cell = '{}';
empty_array = '[]';

%Now create the right and wrong versions with the two different delims
right_answers = { ['{' num_array_str '}'],['{' word_array_str '}'], ...
    ['{' mixed_array_str '}'],empty_cell};
wrong_answers = { ['[' num_array_str ']'],['[' word_array_str ']'], ...
    ['[' mixed_array_str ']'],empty_array}; 


%Pick 1-3 correct answers
iRight = randsample(length(right_answers),randi(3,1));
answers = right_answers(iRight);

%Add incorrect answers to make 5 answers
iWrong = randsample(length(wrong_answers), 5-length(iRight));
answers = [answers wrong_answers(iWrong)];

% Add in the assignment part of the answers
for ii = 1:length(answers)
    answers{ii} = ['$$' array_name ' = ' answers{ii} '/$$'];
end

%Assemble correctness
correctness = convert_logical([true(1,length(iRight)) ...
    false(1,length(answers)-length(iRight))]);

%Make explanation
explanation = '<ul>';
for ii = find(strcmp(correctness,'TRUE'))
    explanation = [explanation '<li>' answers{ii} '</li>'];
end
explanation = [explanation '</ul>'];
   


 
