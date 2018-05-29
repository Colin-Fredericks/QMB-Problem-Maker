function [correct_answer,incorrect_answers] = arr10_3(array_name,array_size,chance_none)
% function ARR10_3 - generate answers for QMB problem arr10.3
% 
% [correct,incorrect] = arr10_3(array_name,array_size,chance_none)
%   array_name: string with name, e.g. 'A', or 'myArray'
%   array_size: 1x2 vector returned by size function
%   chance_none: Probability of answer being 'None of these'


%Format
format = '$$>> size(%s)\nans = \n\t%2d %2d/$$';

%Possible answers: correct, flipped, just rows, just columns, size - 1
correct = sprintf(format,array_name,array_size);
flipped = sprintf(format,array_name,fliplr(array_size));
row = sprintf('$$>> size(%s)\nans = \n\t%2d/$$',array_name,array_size(1));
col = sprintf('$$>> size(%s)\nans = \n\t%2d/$$',array_name,array_size(2));
minus1 = sprintf(format,array_name,fliplr(array_size)-1);

%Fill answers
if rand > chance_none
    correct_answer = correct;
    incorrect_answers = {'None of these',flipped,row,col};
else
    correct_answer = 'None of these';
    incorrect_answers = {flipped,row,col,minus1};
end
