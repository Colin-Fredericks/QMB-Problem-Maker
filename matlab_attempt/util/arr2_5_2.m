function [correct,incorrect,question_values,solution] = arr2_5_2(varargin)
% ARR2_5_1 - Make asnwers for QMB problem arr2.5.1
%
%   [correct,incorrect,question_strings,solution] = arr2_5_2()
%
%   2.5.2 is only for retrieving values

max_val = 100;
possible_names = 'ABCDEFGHKMNPQRTVWXYZ';
max_row = 10;
max_col = 10;
chance_none = 0.2;

% Parse varargin
unparsed = ParseArgin(varargin{:});
if ~isempty(unparsed)
     error(['Unable to parse input: ''' unparsed{1} '''']);
end

%Randomly select question info
val = randi(max_val,1);
val_str = num2str(val);
name_ind = randi(length(possible_names),1);
name = possible_names(name_ind);
row = randi(max_row,1);
row_str = num2str(row);
col = randsample([1:row-1 row+1:max_col],1);
col_str = num2str(col);

%Combine for output
question_values = {name,row,col};

answers = {'They indexed with (column,row) instead of (row,column)', ...
    'This line stores a value instead of retrieves it', ...
    'They used square brackets instead of parentheses', ...
    'They forgot the row index and only have the column', ...
    'They forgot the column index and only have the row', ...
    'They forgot to close off the set of parentheses', ...
    'They use a semicolon instead of a comma when indexing', ...
    'Both indices have the wrong values', ...
    'The array name is the wrong letter', ...
    'The array name is written as lowercase', ...
    'Nothing. The mistake must be in another place'};


%Now assemble the choices. These are the mistaken lines of code.
choices = {[name '(' col_str ',' row_str ')'], ...
           [name '(' row_str ',' col_str ') = ' val_str], ...           
           [name '[' row_str ',' col_str ']'], ...
           [name '(' col_str ')'], ...
           [name '(' row_str ')'], ...
           [name '(' row_str ',' col_str], ...
           [name '(' row_str ';' col_str ')'], ...
           [name '(' num2str(row-1) ',' num2str(col-1) ')'], ...
           [possible_names(randsample([1:name_ind-1 name_ind+1:length(possible_names)],1)) '(' row_str ',' col_str ')'], ...
           [lower(name) '(' row_str ',' col_str ')'], ...
           [name '(' row_str ',' col_str ')']};


%Explanations
explanations = {['Row-column indexing uses row first, then column. The correct line is $' choices{end} '/$.'], ...
    ['To retrieve a value, you do not need an equals sign (unless you want to reassign the retrieved value to a new variable). The correct line is $' choices{end} '/$.'], ...
    ['Parentheses are used when indexing arrays. The correct line is $' choices{end} '/$. We will learn about the various uses for square brackets later.'], ...
    ['Row-column indexing requires both the row and column index. We will later learn about other types of indexing that use a single value. The correct line is $' choices{end} '/$.'], ...
    ['Row-column indexing requires both the row and column index. We will later learn about other types of indexing that use a single value. The correct line is $' choices{end} '/$.'], ...
    ['Forgetting to close off a set of parentheses is a very common mistake. Remember that you can place your cursor next to parenthesis to see the matching symbol. The correct line is $' choices{end} '/$.'], ...
    ['The row and column must be separated by a comma when indexing. The correct line is $' choices{end} '/$.'], ...
    ['The indices here are off by one. This is a common mistake, usually because other programming languages use different ways of indexing. The correct line is $' choices{end} '/$.'], ...
    ['Mispelling a variable is an easy mistake to make. It''s good practice to use long, descriptive variable names to make finding mistakes like this easier. The correct line is $' choices{end} '/$.'], ...
    ['Array names are case sensitive. It''s good practice to use long, descriptive variable names to make finding mistakes like this easier. The correct line is $' choices{end} '/$.'], ...
    'This line of code is correct, so it does not need to be changed. Keep in mind the other choices, though, because they are easy mistakes to make.'};
    
% See if the line has a mistake or not
if rand > chance_none
    
    %Pick a random answer with a mistake
    choice_ind = randi(length(choices)-1,1);
    
    %Pick out the right answer and choice
    question_values(end+1) = choices(choice_ind);
    correct = answers{choice_ind};
    
    %Pick 3 wrong answers and the 'Nothing is wrong' one
    incorrect_ind = randsample([1:choice_ind-1 choice_ind+1:length(choices)-1],3);
    incorrect = [answers(incorrect_ind) answers(end)];
    
    %Pick correct solution string 
    solution = explanations{choice_ind};
else
    
    %Pick out the answer 'None of the above' and correspoinding choice
    question_values(end+1) = choices(end);
    correct = answers{end};
    
    % Pick 4 wrong answers
    incorrect_ind = randsample(1:length(choices)-1,4);
    incorrect = answers(incorrect_ind);
    
    %Pick correct solution string
    solution = explanations{end};  
    
    
end
    
    
       
       





