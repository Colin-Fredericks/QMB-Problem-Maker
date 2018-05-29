function [answers,is_correct] = arr13(num,chance_none,chance_multiple)
% function ARR8_1 - Generate answers for qmb PROBLEM arr8.1
%
%   [answers_is_correct] = arr13(array_name,chance_wrong,chance_multiple)
%        chance_wrong: probability that answer will be "None of these"


%Only works for 1-10 right now
if ~ismember(num,1:10)
    error('Number must be integer from 1 - 10');
end
    
%List of answers I came up with
%   NN is the number, e.g. '5'
%   DD is the english form, e.g 'five'
%   OO is the ordinal number, e.g. '5th'
%
correct_list = {'myArrayNN','my_array_NN','DD_array','myOOArray'};
incorrect_list = {'my Array NN','_my_array_NN','NNarray','myArray#NN', ...
    'DD array','array DD','_my_array_DD','array_#DD' ...
    'OO_array','my OO Array','OOArray','_my_OO_array'};
digit_words = {'one','two','three','four','five','six','seven','eight','nine','ten'};  
    
%Replace NN, DD, and OO with correct strings
correct_list = strrep(correct_list,'NN',num2str(num));
incorrect_list = strrep(incorrect_list,'NN',num2str(num));

digit = digit_words{num};
correct_list = strrep(correct_list,'DD',digit);
incorrect_list = strrep(incorrect_list,'DD',digit);

ordinal = ordinal_string(num);
correct_list = strrep(correct_list,'OO',ordinal);
incorrect_list = strrep(incorrect_list,'OO',ordinal);

%Decide if right answer is present
rand_value = rand;
if rand_value < chance_none
    is_correct = [{'TRUE'} repmat({'FALSE'},1,4)];
    answers = [{'None of these'} randsample(incorrect_list,4)];
elseif rand_value < chance_none + chance_multiple
    num_correct = randi([2 4],1);
    is_correct = [repmat({'TRUE'},1,num_correct), ...
                  repmat({'FALSE'},1,5-num_correct)];
    answers = [randsample(correct_list,num_correct) ...
               randsample(incorrect_list,4-num_correct) ...
               {'None of these'}];    
else %One correct answer
    is_correct = [{'TRUE'} repmat({'FALSE'},1,4)];
    answers(1) = randsample(correct_list,1);
    answers(2:4) = randsample(incorrect_list,3);
    answers(5) = {'None of these'};
end

%Add tags for answers
for ii = 1:length(answers)
    if ~strcmp(answers{ii},'None of these')
        answers{ii} = ['$' answers{ii} '/$'];
    end
end

