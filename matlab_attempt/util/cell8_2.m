function [display,correctness,array_name,explanation] = cell8_2()
% function CELL8_2 - Generate answers for qmb PROBLEM cell8.2
%
%   [display,correctness,array_name,explanation] = cell8_2()
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


% Decide if answer is true or false
if rand>0.5
    ind = randi(length(right_answers),1);
    display = ['$$' array_name ' = ' right_answers{ind} '/$$'];
    explanation = 'Since this line uses curly craces, it successfully creates a cell array. The answer is "True".';
    correctness = convert_logical([1 0]);
else
    ind = randi(length(wrong_answers),1);
    display = ['$$' array_name ' = ' wrong_answers{ind} '/$$'];
    correct = ['$' array_name ' = {' wrong_answers{ind}(2:end-1) '}/$'];
    explanation = ['This line does not create a cell array because it uses square brackets. The line should instead be:' correct '. The answer is "False".'];
    correctness = convert_logical([0 1]);
end

 
