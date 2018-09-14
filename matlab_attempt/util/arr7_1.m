function [correct_answer,incorrect_answers,file_name,shades] = arr7_1(grays,choices,chance_none,shades)
% function ARR7_1 - Function for QMB problem arry7.1
%
% [correct,incorrect,fname,shades] = arr7_1(grays,choices,chance_none,shades)
%       grays: List of values to be used in array answers (grayscale values)
%       choices: array of indices to be used in array
%       chance_none: chance for "None of these" to be the correct answer
%       chades: cell array of strings used for image alt-text   
%



%Pick 5 choices. First choice will always the image displayed
choice_ind = randsample(size(choices,1),5);
file_name = ['gray_4pixel' num2str(choice_ind(1)), '.jpg'];

%Shades are used for alt-text on image. Rearrange according to chosen image
%shades = {'black','dark gray','light gray','white'};
shades = shades(choices(choice_ind(1),:));

%Get answer strings
choice_strings = cell(5,1);
for ii = 1:5
    im = reshape(grays(choices(choice_ind(ii),:)),2,2);
    choice_strings{ii} = ['<pre><code>im_piece = ' ...
        sprintf('\n\t %3d %3d',im') '</code></pre>'];
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