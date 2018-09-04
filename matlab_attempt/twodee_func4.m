function [answers,correctness,explanation] = twodee_func4(func,name)
% Function twodee_func4 -twodee_func4
%
%   [answers,correctness,explanations] = twodee_func4(FUNC,NAME)
%       Generates the answers for twodee_func4 given a function name
%       FUNC and an array name NAME
%
%



right_answers = {'$sum(%s(:))/$', ...
                 '$sum(sum(%s))/$', ...
                 '$sum(%s(1:end))/$', ...
                 '$sum(sum(sum(%s)))/$', ...
                 '$sum(sum(%s(:)))/$'};
            
wrong_answers = {'$sum(%s(1:end,1:end))/$', ...
                 '$sum(%s(:,:))/$', ...
                 '$sum(%s)/$', ...
                 '$sum(%s(1,:)/$', ...
                 '$sum(%s(:,1)/$', ...
                 '$sum(%s())/$'};
             

        
right_explanations = {'Yes. The command $%s(:)/$ will linearize the array, meaning it will return every element in a single column array. This will make the the $sum()/$ function return a single value.', ...
    'Yes. Since $%s/$ is a 2D array, you can call the function twice. The first call will return a value for each column, and the second call will return a single value.', ...
    'Yes. Similar to $%s(:)/$, the command $%s(1:end)/$ will return all values in the array in a single column. This will make the the $sum()/$ function return a single value.', ...
    'Yes. This line is actually redundant since $sum(sum(%s))/$ will return the correct value, but passing this single number to $sum/$ again will simply return the same number.', ...
    'Yes. This line is actually redundant since $sum(%s(:))/$ will return the correct value, but passing this single number to $sum/$ again will simply return the same number.'};

wrong_explanations = {'No. The line $%s(1:end,1:end)/$ will return the full array $%s/$, so $sum(%s(1:end,1:end))/$ is equivalent to $sum(%s)/$, which will return an array of numbers, one for each column.', ...
    'No. The line $%s(:,:)/$ will return the full array $%s/$, so $sum(%s(:,:))/$ is equivalent to $sum(%s)/$, which will return an array of numbers, one for each column.', ...
    'No. This will return an array of numbers, one for each column in $%s/$', ...
    'No. This will only return the $sum/$ of the first row.', ...
    'No. This will only return the $sum/$ of the first column.', ...
    'No. The line $%s()/$ will return the full array $%s/$, so $sum(%s())/$ is equivalent to $sum(%s)/$, which will return an array of numbers, one for each column.'};

   
 

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
 
% Insert name into answer and explanation
answers = strrep(answers,'%s',name);
explanation = strrep(explanation,'%s',name);

% Replace sum with the correct function
answers = strrep(answers,'sum',func);
explanation = strrep(explanation,'sum',func);

%Assemble correctness
correctness = convert_logical([true(1,length(iRight)) false(1,length(answers)-length(iRight))]);
