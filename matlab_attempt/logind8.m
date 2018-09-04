function [answers,correctness,explanation,phrase] = logind8(name1,name2,value1,value2)
% Function twodee_func4 -twodee_func4
%
%   [answers,correctness,explanations] = twodee_func4(FUNC,NAME)
%       Generates the answers for twodee_func4 given a function name
%       FUNC and an array name NAME
%
%


comparators = {'<','>';'>=','<='};
phrases = {'less than','greater than'};
ind = randi([1 2],1);
choice = comparators{1,ind};
anti_choice = comparators{2,ind};
phrase = phrases{ind};


right_answers = {'$$AA(BB < CC) = DD;/$$', ...
                 '$$AA(~(BB >= CC) = DD;/$$', ...
                 ['$$myIndex = BB < CC;' char(10) 'AA(myIndex) = DD;/$$'], ...
                 ['$$myIndex = ~(BB >= CC);' char(10) 'AA(myIndex) = DD;/$$']};
             

wrong_answers = {'$$AA(BB) = DD;/$$', ...
                 '$$AA(BB < CC);/$$', ...
                 '$$AA(~(BB >= CC);/$$', ...
                 '$$AA(BB >= CC) = DD;/$$', ...
                 '$$AA(~(BB < CC) = DD;/$$', ...
                 '$$AA(AA < CC) = DD;/$$', ...
                 '$$myIndex = AA < CC;<br/>AA(myIndex) = DD;/$$', ...
                 '$$myIndex = ~(BB < CC);<br/>AA(myIndex) = DD;/$$'};
             

        
right_explanations = {'Yes. The statement $BB < CC/$ creates a logical array which is used to index into $AA/$', ...
    'Yes. Since we directly ask for the statemen $BB < CC/$, we can also index using $~(BB >= CC)/$. The statement $BB >= CC/$ is the opposite of what you want, so you can is use the $~/$ operator to flip ones to zeros and the zeros to ones.', ...
    'Yes. This code saves the logical array to a variable, but it is the same as typing $AA(BB < CC) = DD;/$.', ...
    'Yes. This code saves the logical array to a variable, but it is the same as typing $AA(~(BB >= CC) = DD;/$.'};
   

wrong_explanations = {'No. This statement does not use logical indexing.', ...
    'No. This line would extract the values from $AA/$, not replace them with a different value.', ...
    'No. This line would extract the values from $AA/$, not replace them with a different value.', ...
    'No. This line uses the wrong logical statement.', ...
    'No. This line uses the wrong logical statement by including the $~/$ operator.', ...
    'No. This line indexes from the array $AA/$ itself and not from the array $BB/$.', ...
    'No. This line indexes from the array $AA/$ itself and not from the array $BB/$.', ...
    'No. This line uses the wrong logical statement by including the $~/$ operator.'};
    
  

%Pick 1-3 correct answers
iRight = randsample(length(right_answers),randi(2,1));
answers = right_answers(iRight);
explanation = [];
for ii = iRight'
    explanation = [explanation '<li>' right_answers{ii} ' ' ...
        right_explanations{ii} '</li>'];
end

%Add incorrect answers to make 5 answers
iWrong = randsample(length(wrong_answers), 5-length(iRight));
answers = [answers wrong_answers(iWrong)];
for ii = iWrong'
    explanation = [explanation '<li>' wrong_answers{ii} ' ' ...
        wrong_explanations{ii} '</li>'];
end
 
% Insert names into answer and explanation
answers = strrep(answers,'AA',name1);
explanation = strrep(explanation,'AA',name1);
answers = strrep(answers,'BB',name2);
explanation = strrep(explanation,'BB',name2);

% Replace operation with correct choice
answers = strrep(answers,'<',choice);
explanation = strrep(explanation,'<',choice);
answers = strrep(answers,'>=',anti_choice);
explanation = strrep(explanation,'>=',anti_choice);

%Replace numbers with correct choice
answers = strrep(answers,'CC',value1);
explanation = strrep(explanation,'CC',value1);
answers = strrep(answers,'DD',value2);
explanation = strrep(explanation,'DD',value2);



%Assemble correctness
correctness = convert_logical([true(1,length(iRight)) false(1,length(answers)-length(iRight))]);
