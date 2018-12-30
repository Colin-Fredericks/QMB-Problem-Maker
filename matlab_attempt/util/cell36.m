function [answers,correctness,problem_values,explanation] = cell36()
% function CELL36 - Generate answers for QMB problem cell36
%
%   [correct,incorrect,problem_values,explanation] = cell36()
%

dims = randsample(2:8,2);

words = {'row','column'};
choice = words{randi(2,1)};

%Decide if row or column
if strcmp(choice,'row')
    
    %Pick a row index
    ind = randi(dims(1),1);
    
    % Four correct answers
    right_answers{1} = sprintf('$myArray(%d,:)/$',ind);
    right_answers{2} = sprintf('$myArray(%d,1:end)/$',ind);
    right_answers{3} = sprintf('$myArray(%d,1:%d)/$',ind,dims(2));
    right_answers{4} = sprintf('$myArray(%d,%s)/$',ind,mat2string(1:dims(2)));

    % First four wrong answers are the same, but flipped
    wrong_answers{1} = sprintf('$myArray(:,%d)/$',ind);
    wrong_answers{2} = sprintf('$myArray(1:end,%d)/$',ind);
    wrong_answers{3} = sprintf('$myArray(1:%d,%d)/$',dims(1),ind);
    wrong_answers{4} = sprintf('$myArray(%s,%d)/$',mat2string(1:dims(1)),ind);
    
    % Other wrong answers are the same as the previous 8, but with curly braces
    wrong_answers{5} = sprintf('$myArray{:,%d}/$',ind);
    wrong_answers{6} = sprintf('$myArray{1:end,%d}/$',ind);
    wrong_answers{7} = sprintf('$myArray{1:%d,%d}/$',dims(1),ind);
    wrong_answers{8} = sprintf('$myArray{%s,%d}/$',mat2string(1:dims(1)),ind);
    wrong_answers{9} = sprintf('$myArray{%d,:}/$',ind);
    wrong_answers{10} = sprintf('$myArray{%d,1:end}/$',ind);
    wrong_answers{11} = sprintf('$myArray{%d,1:%d}/$',ind,dims(2));
    wrong_answers{12} = sprintf('$myArray{%d,%s}/$',ind,mat2string(1:dims(2)));
 
% Repeat if column    
else
    
    %Pick a column index
    ind = randi(dims(2),1);
    
    % Four correct answers
    right_answers{1} = sprintf('$myArray(:,%d)/$',ind);
    right_answers{2} = sprintf('$myArray(1:end,%d)/$',ind);
    right_answers{3} = sprintf('$myArray(1:%d,%d)/$',dims(1),ind);
    right_answers{4} = sprintf('$myArray(%s,%d)/$',mat2string(1:dims(1)),ind);

    % First four wrong answers are the same, but flipped
    wrong_answers{1} = sprintf('$myArray(%d,:)/$',ind);
    wrong_answers{2} = sprintf('$myArray(%d,1:end)/$',ind);
    wrong_answers{3} = sprintf('$myArray(%d,1:%d)/$',ind,dims(2));
    wrong_answers{4} = sprintf('$myArray(%d,%s}/$',ind,mat2string(1:dims(2)));
    
    % Other wrong answers are the same as the previous 8, but with curly braces
    wrong_answers{5} = sprintf('$myArray{%d,:}/$',ind);
    wrong_answers{6} = sprintf('$myArray{%d,1:end}/$',ind);
    wrong_answers{7} = sprintf('$myArray{%d,1:%d}/$',ind,dims(2));
    wrong_answers{8} = sprintf('$myArray{%d,%s}/$',ind,mat2string(1:dims(2)));
    wrong_answers{9} = sprintf('$myArray{:,%d}/$',ind);
    wrong_answers{10} = sprintf('$myArray{1:end,%d}/$',ind);
    wrong_answers{11} = sprintf('$myArray{1:%d,%d}/$',dims(1),ind);
    wrong_answers{12} = sprintf('$myArray{%s,%d}/$',mat2string(1:dims(1)),ind);
    
end


%Pick 1-3 correct answers. Always include the : one
nRight = randi(3,1);
iRight = [1 randsample(2:length(right_answers),nRight-1)];
answers = right_answers(iRight);

%Explanation is just a list of the right answers
explanation = '<ul>';
for ii = iRight
    explanation = [explanation '<li>' right_answers{ii} '</li>'];
end
explanation = [explanation '</ul>'];

%Add incorrect answers to make 6 total answers. Make sure to include the
%flipped one
nTotal = 6;
iWrong = [1 randsample(2:length(wrong_answers), nTotal-length(iRight)-1)];
answers = [answers wrong_answers(iWrong)];

%Assemble correctness
correctness = convert_logical([true(1,length(iRight)) ...
                               false(1,length(answers)-length(iRight))]);

% Problem values
problem_values = {dims,choice,ind,right_answers};
