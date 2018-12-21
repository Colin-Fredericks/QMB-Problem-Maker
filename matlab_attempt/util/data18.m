function [correct,incorrect,problem_values] = data18()
% function DATA18 - QMB problem data18
%
%   [correct,incorrect,problem_values] = data18()
%
%

%Chance of answer being none of these
chance_none = 0.2;

%Choices of shape and xscale factor
shapes = {'uniform','exponential','normal'};
factors = [1 10:10:100];

% Pick a random img to display the data
shape_id = randi(length(shapes),1);
factor_id = randi(length(factors),1);

% Convert these two ids to the linear index used for numbering the images
img_id = length(factors)*(shape_id-1) + factor_id;

%Make alt text for this image
data_alt_txt = sprintf('A raw data plot with a dot for each value in the array. The data appears to have a %s distribution and has values that range between 0 and %d.', ...
    shapes{shape_id},factors(factor_id));

% Make the reference answer
correct_alt_txt = sprintf('A histogram of the data. The x-axis ranges from 0 to %d and the distribution appears to have a %s shape.', ...
    factors(factor_id),shapes{shape_id});
reference = sprintf('<a href="/static/betarnd_hist_%d.png" target="_blank"><img src="/static/betarnd_hist_%d.png" alt="%s"/></a>', ...
    img_id,img_id,correct_alt_txt);

%Pick answers
if rand>chance_none
    
    % Correct answer is the matching histogram of the data
   correct = reference;
    
    % Pick 3 wrong answers   
    incorrect = {};
    while length(incorrect)<3
        
        % Sample a shape and factor. Only add to the answers if different
        % from the right answer
        wrong_shape_id = randi(length(shapes),1);
        wrong_factor_id = randi(length(factors),1);
        if wrong_shape_id==shape_id && wrong_factor_id==factor_id
            continue;
        end
        
        % Add to incorrect answers
       wrong_img_id = length(factors)*(wrong_shape_id-1) + wrong_factor_id;
        incorrect_alt_txt = sprintf('A histogram of the data. The x-axis ranges from 0 to %d and the distribution appears to have a %s shape.', ...
            factors(wrong_factor_id),shapes{wrong_shape_id});
        incorrect{end+1} = sprintf('<a href="/static/betarnd_hist_%d.png" target="_blank"><img src="/static/betarnd_hist_%d.png" alt="%s"/></a>', ...
            wrong_img_id,wrong_img_id,incorrect_alt_txt);
        
    end
    
    %Add none of these to the last incorrect
    incorrect{4} = 'None of these';
    
    %explanation
    explanation = sprintf('The histogram that best matches these assumptions is </p><br/><p>%s</p><br/><p>It appears to show a %s distribution, and the values are all between 0 and %d.', ...
        correct,shapes{shape_id},factors(factor_id));
    
else
    % Matching histogram is not present, so correct answer is:
    correct = 'None of these';
    
    %Fill 4 incorrect answers
    incorrect = {};
    while length(incorrect)<4
        
        % Sample a shape and factor. Only add to the answers if different
        % from the right answer
        wrong_shape_id = randi(length(shapes),1);
        wrong_factor_id = randi(length(factors),1);
        if wrong_shape_id==shape_id && wrong_factor_id==factor_id
            continue;
        end
        
        % Add to incorrect answers
        wrong_img_id = length(factors)*(wrong_shape_id-1) + wrong_factor_id;
        incorrect_alt_txt = sprintf('A histogram of the data. The x-axis ranges from 0 to %d and the distribution appears to have a %s shape.', ...
            factors(wrong_factor_id),shapes{wrong_shape_id});
        incorrect{end+1} = sprintf('<a href="/static/betarnd_hist_%d.png" target="_blank"><img src="/static/betarnd_hist_%d.png" alt="%s"/></a>', ...
            wrong_img_id,wrong_img_id,incorrect_alt_txt);
        
    end
    
    explanation = sprintf('None of the histograms here have a matching distribution shape and range of values. Therefore, the correct answer is: "None of these".</p><br/><p>A better match would be the following. Notice the range of the x-axis.</p><br/><p>%s', ...
        reference);
    
end

%Assemble problem values for output
problem_values = {img_id,data_alt_txt,shapes{shape_id},factors(factor_id), ...
    explanation};
    


