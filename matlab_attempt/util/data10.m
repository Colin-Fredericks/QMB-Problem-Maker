function [correct,incorrect,array_str,img_id,alt_txt,explanation] = data10()
% function DATA10 - QMB problem data10
%
%   [correct,incorrect,img_id,alt_txt,explanation] = data10()
%
%

%Chance of answer being 'None of these'
chance_none = 0.2;

% Load data
load Data\linematch_data array_values
num_plot = length(array_values);

%Pick an id
img_id = randi(num_plot,1);

% Write the alt_txt
first_values = array_values{img_id}(:,1);
alt_txt =  sprintf('A plot with four lines numbered 1 to 4. Each line has points with x-values that range from 1 to 10 and y-values that range from 1 to 100. The first point in each line (i.e. at x=1) is at a y-value of: Line1=%d, Line2=%d, Line3=%d, and Line4=%d.',first_values); 

choices = {'Line 1','Line 2','Line 3','Line 4'};
if rand<chance_none
    %Get a new array. Make sure it is very different from the other lines
    unused_values = find(~ismember(1:100,unique(array_values{img_id}(:))))
    new_array = randsample(unused_values,10);
    
    %Make display for question
    array_str = mat2string(new_array);
    
    %Assemble answers
    correct = 'None of these';
    incorrect = choices;
    
    %Write explanation
    explanation = sprintf('the array $%s/$ has values that do not match up to any of the lines in the plot',array_str);
else
    % Pick one of the lines to be the correct answer
    answer_ind = randi(4,1);
    
    %Make display for question    
    array_str = mat2string(array_values{img_id}(answer_ind,:));
    
    %Assemble answers
    correct = choices{answer_ind};
    incorrect = [choices(1:4~=answer_ind) {'None of these'}];
    
    %Write explanation
    explanation = sprintf('the array $%s/$ has values that best match up with Line %d',array_str,answer_ind);
end
    
   