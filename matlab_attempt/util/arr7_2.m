function [correct_answer,incorrect_answers,array_str] = arr7_2(grays,choices,chance_none,shades)
% function ARR7_1 - Function for QMB problem arry7.2
%
% [correct,incorrect,array_str] = arr7_2(grays,choices,chance_none,shades)
%       grays: List of values to be used in array answers (grayscale values)
%       choices: array of indices to be used in array
%       chance_none: chance for "None of these" to be the correct answer
%       chades: cell array of strings used for image alt-text   
%


%Pick 5 choices. First choice will always the array displayed
choice_ind = randsample(size(choices,1),5);

%Make display str
im = reshape(grays(choices(choice_ind(1),:)),2,2);
array_str = sprintf('\n\t %3d %3d',im');

%Create answers
choice_strings = cell(5,1);
alt_str_pre = ['A 2 x 2 pixel grayscale image colors ' ...
               '(starting top left and going clockwise): ']; 

%Get image display strings for each image
for ii = 1:5    
    gray_ind = choices(choice_ind(ii),:);
    alt_str = [alt_str_pre strjoin(shades(gray_ind),', ')];    
    file_name = ['gray_4pixel' num2str(choice_ind(ii)), '.jpg'];
    choice_strings{ii} = ['<img src ="/static/' file_name '" alt="' ...
                          alt_str '"/>'];
end

%Now set up answers
if rand<chance_none
    correct_answer = 'None of these';
    incorrect_answers = choice_strings(2:5);
else
    correct_answer = choice_strings{1};
    incorrect_answers = choice_strings(2:4);
    incorrect_answers{4} = 'None of these';    
end