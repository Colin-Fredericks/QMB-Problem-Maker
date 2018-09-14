function [answers, correctness, display_str, explanation] = writeloops1(array)
% function WRITELOOPS1 - code for QMB problem writeloops1
%
%   [answers, correctness, explanation] = writeloops1(values)
%

% Get strings of array to insert into answers
array_str = mat2string(array);
permute_array_str = mat2string(array(randperm(length(array))));


%Display string for the questionText
display_str = sprintf([repmat('%d, ',1,length(array)-1) 'and %d'],array);

% Set up the 3 correct answers
right_answers{1} = sprintf(['$$myArray = %s;\n' ...
                    'for i = 1:length(myArray)\n'  ...
                    '     myArray(i)\n' ...
                    'end/$$'], array_str);
right_answers{2} = sprintf(['$$myArray = %s;\n' ...
                    'for i = myArray\n'  ...
                    '     i\n' ...
                    'end/$$'], array_str);
right_answers{3} = sprintf(['$$for i = %s\n'  ...
                   '     i\n' ...
                   'end/$$'], array_str);
               
right_explanations = {'Yes. Declaring the loop variable with the colon operator allows you to index back into the array within the loop. This is particularly useful when you need to index multiple arrays at the same time.', ...
    'Yes. Declaring the array first and then assigning the loop variable to the array allows you to access the values by simply calling the variable $i/$.', ...
    'Yes. Declaring the loop variable as the values directly allows you to access the values by simply calling the variable $i/$.'};
               
% Set up the wrong answers               
wrong_answers{1} = sprintf(['$$for i = myArray\n'  ...  %No array declaration
                    '     i\n' ...
                    'end/$$']);
wrong_answers{2} = sprintf(['$$for i = 1:length(myArray)\n'  ... %No array declaration
                    '     myArray(i)\n' ...
                    'end/$$']); 
wrong_answers{3} = sprintf(['$$myArray = %s;\n' ... %Double indexing
                    'for i = myArray\n'  ...
                    '     myArray(i)\n' ...
                    'end/$$'], array_str); 
wrong_answers{4} = sprintf(['$$for i = %s\n'  ... %Double indexing
                   '     myArray(i)\n' ...
                   'end/$$'], array_str);
wrong_answers{5} = sprintf(['$$myArray = %s;\n' ... %Wrong array
                    'for i = 1:length(myArray)\n'  ...
                    '     myArray(i)\n' ...
                    'end/$$'], permute_array_str);
wrong_answers{6} = sprintf(['$$myArray = %s;\n' ... %Wrong array
                    'for i = myArray\n'  ...
                    '     i\n' ...
                    'end/$$'], permute_array_str);
wrong_answers{7} = sprintf(['$$for i = %s\n'  ... %Wrong array
                   '     i\n' ...
                   'end/$$'], permute_array_str);
wrong_answers{8} = sprintf(['$$myArray = %s;\n' ... %Printing out 1:10
                    'for i = 1:length(myArray)\n'  ...
                    '     i\n' ...
                    'end/$$'], array_str);
wrong_answers{9} = sprintf(['$$for i = 1:length(%s)\n'  ... %Printing out 1:10
                    '     i\n' ...
                    'end/$$'], array_str);
                
wrong_explanations = {'No. This answer does not initialize the variable $myArray/$.', ...
    'No. This answer does not initialize the variable $myArray/$.', ...
    'No. This answer declares $myArray/$ correctly, but then tries to index back into $myArray/$ using the values themselves. This will cause an "Array index out of bounds" error', ...
    'No. This answer declares the loop variable $i/$ correctly, but then tries to index back into an array with the values themselves. This will probably cause an "Array index out of bounds" error depending on the values in $myArray/$ and the current value of $i/$.', ...
    'No. This value will print out the correct values, but in the wrong order', ...
    'No. This value will print out the correct values, but in the wrong order', ...
    'No. This value will print out the correct values, but in the wrong order', ...
    'No. This will print out the indexes $1/$, $2/$, $3/$, etc. but not the array values', ...
    'No. This will print out the indexes $1/$, $2/$, $3/$, etc. but not the array values'};


%Pick 1-3 correct answers
iRight = randsample(length(right_answers),randi(3,1));
answers = right_answers(iRight);
explanation = [];
for ii = iRight'
    explanation = [explanation '<li>' right_answers{ii} '<br/> ' ...
        right_explanations{ii} '</li>'];
end

%Add incorrect answers to make 5 answers
iWrong = randsample(length(wrong_answers), 5-length(iRight));
answers = [answers wrong_answers(iWrong)];
for ii = iWrong'
    explanation = [explanation '<li>' wrong_answers{ii} '<br/> ' ...
        wrong_explanations{ii} '</li>'];
end
   
%Assemble correctness
correctness = convert_logical([true(1,length(iRight)) false(1,length(answers)-length(iRight))]);