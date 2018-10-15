function [checksum_value,problem_values,explanation] = if_else14(array)
% if_else5
%
% [answers,correctness,explanation] = if_else14(array)

%Pick problem values
values = randsample(100,2);
symbols = {'<','>','<=','>=','==','~='};
phrases = {'less than','greater than','less than or equal to', ...
    'greater than or equal to','equal to','not equal to'};
choice_ind = randi(length(symbols),1);
symbol = symbols{choice_ind};
phrase = phrases{choice_ind};
other_ind = randsample([1:choice_ind-1 choice_ind+1:length(symbols)],1);
other_symbol = symbols{other_ind};
other_phrase = phrases{other_ind};

% Evaluate the logical indexing statement that the students will try to
% replicate
logical_statement = sprintf('array(array %s %d) = %d;', ...
    symbol,values(1),values(2));
eval(logical_statement);

% Assemble problem values
problem_values = {'myArray',values(1),values(2),symbol,phrase};

checksum_value = checksum(array);

explanation = sprintf(['<p>' ...
    'To replace the values in $myArray/$, you need to write the correct $if/$ statement in the code. There are multiple ways you could do this, but one correct way is:' ...
    '</p><br/>' ...
    '<p>' ...
    '$$for i = 1:length(myArray)\n'  ...
    '     if myArray(i) %s %d\n' ...
    '          myArray(i) = %d;\n' ...
    '     end\n' ...
    'end/$$</p><br/><p>' ...
    'This will replace the values in myArray with the correct value. The function $replaceValues/$ should now output the answer $%d/$.</p>'], ...
    symbol,values(1),values(2),checksum_value);




function value = checksum(myArray)
% Checksum function for getting a single number from an array. 
%
% DO NOT EDIT THIS FUNCTION
value = sum(myArray(:)) + length(myArray(:));
value = mod(value,500);

   