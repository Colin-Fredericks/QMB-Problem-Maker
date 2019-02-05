function [answers,correctness,problem_values] = data48()
% function data48 - Generate answers for QMB problem data48
%
%   [answers,correctness,problem_values,explanation] = data48()
%

%Pick an array name
array_name = randsample('abcdefghkmnpqrtuvwxyz',1);

% Pick range of values. Make sure the values are unique so we can use them
% for different wrong answers (e.g. flipping values around)
while true
    value1 = randi([2 10],1);
    value2 = randi([value1+2 15],1);
    range = value2 - value1 + 1;
    wrong_range = value2 -  value1;    
    
    % The four unique values are:
    %   1. min used for floor 
    %   2. min used for ceil and round
    %   3. range used for ceil and floor
    %   4. range used for round
    if length(unique([value1 value1-1 range wrong_range]))==4        
        break
    end    
end


right_answers = {sprintf('$$floor(%c * %d) + %d/$$',array_name,range,value1), ...
                 sprintf('$$ceil(%c * %d) + %d/$$',array_name,range,value1-1)};
 
wrong_answers = {sprintf('$$round(%c * %d) + %d/$$',array_name,wrong_range,value1), ...
    sprintf('$$round(%c * %d) + %d/$$',array_name,range,value1), ...
    sprintf('$$round(%c * %d) + %d/$$',array_name,range,value1-1), ...
    sprintf('$$round(%c * %d) + %d/$$',array_name,wrong_range,value1-1), ...
    sprintf('$$floor(%c * %d) + %d/$$',array_name,range,value1-1), ...
    sprintf('$$floor(%c * %d) + %d/$$',array_name,wrong_range,value1-1), ...'
    sprintf('$$floor(%c * %d) + %d/$$',array_name,wrong_range,value1), ...
    sprintf('$$ceil(%c * %d) + %d/$$',array_name,range,value1), ...    
    sprintf('$$ceil(%c * %d) + %d/$$',array_name,wrong_range,value1-1), ...
    sprintf('$$ceil(%c * %d) + %d/$$',array_name,wrong_range,value1)};


%Pick both correct answers as choices
iRight = [1 2];
answers = right_answers(iRight);

%Add incorrect answers to make 5 total answers. Make sure to include the
%flipped one
nTotal = 5;
iWrong = [1 randsample(2:length(wrong_answers), nTotal-length(iRight)-1)];
answers = [answers wrong_answers(iWrong)];

%Assemble correctness
correctness = convert_logical([true(1,length(iRight)) ...
                               false(1,length(answers)-length(iRight))]);

% Problem values
problem_values = {array_name,value1,value2,range,wrong_range};
