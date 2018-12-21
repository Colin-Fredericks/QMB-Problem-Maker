function [answers,correctness,problem_values] = cell4()
%Function CELL4: Creates answers for QMB problem 'cell4'
%
%   [answers,correctness,problem_values] = cell4() 


% Sample a array and vector name
letters = randsample('ABCDEFGHPQRSTUVWXYZ',2);
letters(2) = lower(letters(2));
cell_name = letters(1);
var_name = letters(2);

% Displays for the variables
num_words = 5;
words = sample_random_words(num_words);
cell_str = ['{''' strjoin(words,''', ''') '''}'];
int_value = randi(100,1);
 

%Pick random integers for indices
max_size = 10;
index = randi(max_size,1,1);

% Four choices 
choices{1} = sprintf('%c{%d} = %c;',cell_name,index,var_name);
choices{2} = sprintf('%c(%d) = %c;',cell_name,index,var_name);
choices{3} = sprintf('%c = %c{%d};',var_name,cell_name,index);
choices{4} = sprintf('%c = %c(%d);',var_name,cell_name,index);

% Five answers
answers{1} = sprintf('The number $%d/$ is stored into a cell in the variable $%c/$.',int_value,cell_name);
answers{2} = 'Nothing. This line produces an error.';
answers{3} = sprintf('A string is stored in the variable $%c/$.',var_name);
answers{4} = sprintf('A cell is stored in the variable $%c/$.',var_name);
answers{5} = sprintf('The number $%d/$ is stored in the variable $%c/$, replacing the cell array.',int_value,cell_name);


% Pick a display
ind_choice = randi(length(choices),1);
display = choices{ind_choice};

% Correctness of each answer
correctness = convert_logical(1:5==ind_choice);


% Get left and right for explanation
parts = strsplit(display);
left = parts{1};
right = parts{3}(1:end-1);

% Assemble explanation
explain_start = sprintf('The statement $%s/$ attempts to store $%s/$ into $%s/$.',display(1:end-1),right,left);
explain{1} = sprintf('The curly braces indicate that the number $%d/$ will be placed into the contents of the cell. This is prefectly valid, even though the cell previously contained a string.',int_value);
explain{2} = sprintf('However, $%s/$ is a cell because of the use of parentheses, so the only thing that can be stored into it are other cells. This line will produce an error. It could be fixed by adding curly braces around the integer, e.g. $%c(%d) = {%c}/$.',left,cell_name,index,var_name); 
explain{3} = sprintf('The curly braces indicate the contents of the cell is retrieved from the cell array. The variable $%c/$ will now contain a string.',var_name) ;
explain{4} = sprintf('The parentheses indicate the entire cell is retrieved from the cell array. The variable $%c/$ will now contain a cell.',var_name) ;
explain_end = sprintf('Therefore, the correct answer is "%s".',answers{ind_choice});
explanation = {explain_start,explain{ind_choice},explain_end};

% Assemble variables needed for the problem
problem_values = {display,letters,cell_str,int_value,explanation};

