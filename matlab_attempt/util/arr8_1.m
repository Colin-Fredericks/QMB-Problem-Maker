function [correct_answer,incorrect_answers] = arr8_1(array_name,chance_none)
% function ARR8_1 - Generate answers for qmb PROBLEM arr8.1
%
%   [correct_answer,incorrect_answers] = arr8_1(array_name,chance_wrong)
%        chance_wrong: probability that answer will be "None of these"


%List of answers I came up with
right_answer = 'AA = []';
wrong_list = {'AA = ()','AA[]','AA()','AA{}','AA = empty[]', ...
    'AA[] = 1','AA() = 1','AA{} = 1','AA = 0','AA = 1','[] = AA', ...
    '() = AA','{} = AA','set(AA,empty)','AA.empty()','AA.[]','AA.()', ...
    'AA.{}','AA = [0]','AA = (0)','AA = {0}','AA = empty()'};

%Replace array with correct name
right_answer = strrep(right_answer,'AA',array_name);
wrong_list = strrep(wrong_list,'AA',array_name);

%Decide if right answer is present
if rand > chance_none    
    correct_answer = ['$' right_answer '/$'];
    incorrect_answers = randsample(wrong_list,3);
    for ii = 1:3
        incorrect_answers{ii} = ['$' incorrect_answers{ii} '/$'];
    end
    incorrect_answers{end+1} = 'None of these';       
else
    correct_answer = 'None of these';
    incorrect_answers = randsample(wrong_list,4);
    for ii = 1:4
        incorrect_answers{ii} = ['$' incorrect_answers{ii} '/$'];
    end       
end