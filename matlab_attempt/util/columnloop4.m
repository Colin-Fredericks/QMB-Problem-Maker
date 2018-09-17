%% columnloop4
%% questionText
%
% Suppose you have a custom function named $myFunction/$ that takes in
% single number. For example, $myFunction(291)/$ might do something like
% load an image named "IM_291.jpg" and perform some sort of processing on
% it.
% 
% You also have a variable named $myArray/$ with the following values
% 
% ARRAY_DISPLAY
% 
% You need to index into $myArray/$ inside a For loop and call
% $myFunction/$ on each value. You write the following For loop but
% discover it does not work.
% 
% LOOP_DISPLAY
% 
% It turns out that since $myArray/$ is a single column, the loop only runs
% once and the value of $i/$ is the entire array $myArray/$. Since
% $myFunction/$ expects a single number, this code produces an error.
% 
% Which pieces of code below will successfully index into $myArray/$ in a
% For loop?
%
%% Code
function [answers,correctness,explanation,array_display,loop_display] = ...
    columnloop4()

% Generate values for array display
len = randi([3 8],1);
array = randi(100,len,1);
array_display = ['$$' mimic_array_output(array,'myArray') '/$$'];

% Possible correct answers
right{1} = sprintf([...
    '$$for i = myArray''\n'  ...
    '     myFunction(i);\n' ...
    'end/$$']);
right{2} = sprintf([ ...
    '$$for i = 1:length(myArray)\n'  ...
    '     myFunction(myArray(i));\n' ...
    'end/$$']);
right{3} = sprintf([ ...
    '$$myArray = myArray'';\n' ...
    'for i = myArray\n'  ...
    '     myFunction(i);\n' ...
    'end/$$']);
right{4} = sprintf([ ...
    '$$myArray = myArray'';\n' ...
    '$$for i = 1:length(myArray)\n'  ...
    '     myFunction(myArray(i));\n' ...
    'end/$$']);

% Explanations for correct answers
right_explain{1} = 'Yes. This loop uses the transpose operator $''/$ in order convert the myArry from a column array to a row array, which will work successfully in a For loop.';
right_explain{2} = 'Yes. The loop variable $i/$ is defined here with a colon operator, which creates a single row. Inside the loop, $i/$ will take on single values like 1, 2, 3, etc. Inside the loop, $i/$ is used to index into $myArray/$ before passing the value into $myFunction/$. By doing this, it does not matter that $myArray/$ is a column.';
right_explain{3} = 'Yes. This code intially converts $myArray/$ from a column array to a row array with the transpose operator $''/$. Now, when defining the loop variable as $i = myArray/$, the loop will successfully run with a different single value assinged to $i/$ on each iteration.';
right_explain{4} = 'Yes. The first line uses the transpose oeprator $''/$ to convert $myArray/$ from a row array to a column array, but this is actually unnecessary for this loop. The loop variable $i/$ is defined with the colon operator $i = 1:length(myArray)/$, so the variable $i/$ will take on single values like 1, 2, 3, etc. Inside the loop, $i/$ is used to index into $myArray/$ before passing the value into $myFunction/$. By doing this, it does not matter whether $myArray/$ is a row or column.';

% Wrong answers
wrong{1} = sprintf([...
    '$$for i = myArray\n'  ...
    '     myFunction(i);\n' ...
    'end/$$']);
wrong{2} = sprintf([...
    '$$for i = myArray''\n'  ...
    '     i;\n' ...
    'end/$$']);
wrong{3} = sprintf([...
    '$$for i = 1:length(myArray)\n'  ...
    '     myArray(i);\n' ...
    'end/$$']);
wrong{4} = sprintf([ ...
    '$$myArray = myArray'';\n' ...
    'for i = 1:length(myArray)\n'  ...
    '     myFunction(i);\n' ...
    'end/$$']);
wrong{5} = sprintf([ ...
    '$$myArray = myArray'';\n' ...
    'for i = myArray''\n'  ...
    '     myFunction(i);\n' ...
    'end/$$']);
wrong{6} = sprintf([...
    '$$for i = myArray''\n'  ...
    '     myArray(i);\n' ...
    'end/$$']);
wrong{7} = sprintf([...
    '$$for i = myArray\n'  ...
    '     myFunction(i'');\n' ...
    'end/$$']);

% Loop display is the first wrong answer
loop_display = wrong{1};

% Explanations for wrong problems
wrong_explain{1} = 'No. This code is unchanged and will repeat the mistake of setting the loop variable $i/$ to an entire column.';
wrong_explain{2} = 'No. While this code does convert $myArray/$ to a single row with the transpose operator $''/$, it does not call the function $myFunction/$. This will merely print out the value of $i/$';
wrong_explain{3} = 'No. This code will index into $myArray/$ successfully, but it does not call the function $myFunction/$';
wrong_explain{4} = 'No. While this code does convert $myArray/$ to a single row with the transpose operator $''/$, it assigns the loop variable $i/$ with a colon operator. The statment inside the loop does not index back into $myArray/$. It will call $myFunction/$ on the integers 1, 2, 3 instead of the values in $myArray/$.';
wrong_explain{5} = 'No. This code does convert $myArray/$ to a single row with the transpose operator $''/$, it then converts it back into a single column by transposing it again in the loop definition. This will cause the same error as the original code.';
wrong_explain{6} = 'No. This code does convert $myArray/$ to a single row with the transpose operator $''/$, but inside the loop it will try to index back into $myArray/$ using the values of $myArray/$. This will cause an out-of-bounds error.';
wrong_explain{7} = 'No. This code defines the loop variable $i/$ in the same way as the original code. Therefore, inside the loop $i/$ will be the entire array $myArray/$ instead of a single value. The array is then transposed inside the call to $myFunction/$, but this will not matter. The problem states that $myFunction/$ expects a single value, not an array.';

% Pick 1-3 correct answers
iRight = randsample(length(right),randi([1 3],1));
answers = right(iRight);
explanation = [];
for ii = iRight'
    explanation = [explanation '<li>' right{ii} '<br/> ' ...
        right_explain{ii} '</li>'];
end

%Add incorrect answers to make 5 answers
iWrong = randsample(length(wrong), 5-length(iRight));
answers = [answers wrong(iWrong)];
for ii = iWrong'
    explanation = [explanation '<li>' wrong{ii} '<br/> ' ...
        wrong_explain{ii} '</li>'];
end
   
%Assemble correctness
correctness = convert_logical([true(1,length(iRight)) false(1,length(answers)-length(iRight))]);

%% Variables
% ARRAY_DISPLAY = array_display;
% LOOP_DISPLAY = loop_display;
% ANS1 = answers{1};
% ANS2 = answers{2};
% ANS3 = answers{3};
% ANS4 = answers{4};
% ANS5 = answers{5};
% CORRECT1 = correctness{1};
% CORRECT2 = correctness{2};
% CORRECT3 = correctness{3};
% CORRECT4 = correctness{4};
% CORRECT5 = correctness{5};
% EXPLAIN = explanation;
%% Answers
% * ANS1 = CORRECT1
% * ANS2 = CORRECT2
% * ANS3 = CORRECT3
% * ANS4 = CORRECT4
% * ANS 5 = CORRECT5
%% Solution Text
% There are several ways you write this loop.
% 
% The possible answers here are:
% 
% <ul>EXPLAIN</ul>
%% Other Properties
% * Problem Type = Checkbox
% * Knowledge Components = L13, L14
% * Dynamic = True
% * Difficulty = 1
