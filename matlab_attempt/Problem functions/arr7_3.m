function [correct_answer,incorrect_answers,array_strings,solution_string] = arr7_3(image_size,chance_none)
% function ARR7_1 - Function for QMB problem arry7.3
%
% [correct,incorrect,array_strs,solution_str] = arr7_3(image_size,chance_none)
%       image_size: Size of square image in pixels
%       chance_none: Chance the answer is 'None of these'
%

%Generate 3 high and 3 low value arrays
bright_values = randi([225 255],image_size,image_size,3);
dark_values = randi([0 30],image_size,image_size,3);

answer_strings = {'The image will be mostly red', ...
                  'The image will be mostly green', ...
                  'The image will be mostly blue'};
colors = {'red','green','blue'};

% Choose if correct answer is present or not
if rand < chance_none
    
    correct_answer = 'None of these';
    incorrect_answers = answer_strings;
    
    %Multiple display possibilities for wrong answers
    %   1. all high 
    %   2. all low 
    %   3. Two high, one low
    choice = randi(3,1);
    if choice == 1
        choice_values = bright_values;
        solution_string = ['Since all three arrays have high values, ' ...
            'there will be no predominant color. The image will be close to white'];
    elseif choice == 2
        choice_values = dark_values;
        solution_string = ['Since all three arrays have low values, ' ...
            'there will be no predominnt color. The image will be close to black'];
    elseif choice == 3
        choice_values = cat(3,bright_values(:,:,1:2),dark_values(:,:,1));
        choice_values = choice_values(:,:,randperm(3));
        solution_string = ['Since two of the arrays have high values, ' ...
            'the predominant color will not be red, blue, or green. ' ...
            'It will be some other color, likely cyan, yellow, or magenta'];
    end
    
else
    
    %Pick one color to be the bright values. The others are dark    
    choice = randi(3,1);
    other_choices = [1:choice-1 choice+1:3];
    correct_answer = answer_strings{choice};
    incorrect_answers = [answer_strings(other_choices) ...
        {'None of these'}];
    
    choice_values = zeros(image_size,image_size,3);
    choice_values(:,:,choice) = bright_values(:,:,1);
    choice_values(:,:,other_choices) = dark_values(:,:,1:2);
    
    solution_string = ['Since the ' colors{choice} ...
        ' array has the highest values, the image will be mostly ' ...
        colors{choice} '.']; 
end

% Format used by sprintf. Use transpose when printing
format = ['\n\t' repmat(' %3d',1,image_size)];
array_strings{1} = sprintf(format,choice_values(:,:,1));
array_strings{2} = sprintf(format,choice_values(:,:,2));
array_strings{3} = sprintf(format,choice_values(:,:,3));


