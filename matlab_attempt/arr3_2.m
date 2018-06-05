function [answers,is_correct] = arr3_2(array_name,array_size,num,chance_none)
% function ARR3_2 - Answers for QMB problem arr3.2
%
%   [answers,is_correct] = arr3_2(array_name,array_size,num,chance_none)
%
%

if array_size(1) == array_size(2)
    error('Row and column dimensions must be different')
end

%Whether each answer is correct (1:3 are correct)
correctness = [true(1,3) false(1,10)];

% Various choices
choices{1} = ['$' array_name ' = ' num2str(num) ' + ' mat2string(zeros(array_size)) '/$'];
choices{2} = ['$' array_name ' = ' num2str(num) ' * ' mat2string(ones(array_size)) '/$'];
choices{3} = ['$' array_name ' = ' mat2string(num+zeros(array_size)) '/$'];
choices{4} = ['$' array_name ' = ' num2str(num) ' + ' mat2string(zeros(1,prod(array_size))) '/$'];
choices{5} = ['$' array_name ' = ' num2str(num) ' + ' mat2string(zeros(prod(array_size),1)) '/$'];
choices{6} = ['$' array_name ' = ' num2str(num) ' * ' mat2string(ones(1,prod(array_size))) '/$'];
choices{7} = ['$' array_name ' = ' num2str(num) ' * ' mat2string(ones(prod(array_size),1)) '/$'];
choices{8} = ['$' array_name ' = ' mat2string(num+zeros(1,prod(array_size))) '/$'];
choices{9} = ['$' array_name ' = ' mat2string(num+zeros(prod(array_size),1)) '/$'];
choices{10} = ['$' array_name ' = ' num2str(num) ' + ' mat2string(zeros(fliplr(array_size))) '/$'];
choices{11} = ['$' array_name ' = ' num2str(num) ' * ' mat2string(ones(fliplr(array_size))) '/$'];
choices{12} = ['$' array_name ' = ' mat2string(num+zeros(fliplr(array_size))) '/$'];
choices{13} = 'None of these';


%Pick answers
if rand > chance_none
    %Make sure there is at least one correct
    choice_ind(1) = randsample(3,1);    
    
    %Now select 4 more answers
    choice_ind(2:5) = randsample([1:choice_ind(1)-1 choice_ind(1)+1:10],4);
    
else
    %Make sure 'None of these is in the answers'
    choice_ind(1) = 13;
    
    %Now select 4 wrong answers
    choice_ind(2:5) = randsample(4:12,4);
end 

%Assemble for output
answers = choices(choice_ind);
is_correct = cell(1,5);
is_correct(correctness(choice_ind)) = {'TRUE'};
is_correct(~correctness(choice_ind)) = {'FALSE'};
    
end

function str = mat2string(mat)
% Function that uses mat2str with commas
 
str = strrep(mat2str(mat),' ',',');

end
