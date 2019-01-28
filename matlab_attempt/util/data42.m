function [correct,incorrect,problem_values,explanation] = data42()
% function data42 - Generate answers for QMB problem data42
%
%   [correct,incorrect,problem_values,explanation] = data42()


% Get map of ID to mean and stddev
stddevs = [1 5 10];
means = 10:10:100; 
map = [collapse(repmat(stddevs,length(means),1)), ...
       collapse(repmat(means',length(stddevs),1))];

  
%Pick an img_id and get reference mean and stddev
img_id = randi(size(map,1),1);
ref_mean = map(img_id,2);
ref_std = map(img_id,1);

% Find the answers that are almost right, e.g. with the right mean or right
% stddev but not both. These are the near-misses
mean_ind = map(:,2)==ref_mean & map(:,1)~=ref_std;
nearMiss_ind(1) = randsample(find(mean_ind),1);
std_ind = map(:,1)==ref_std & map(:,2)~=ref_mean;
nearMiss_ind(2) = randsample(find(std_ind),1);

% Two string formats to be used with sprintf
alt_format = 'A histogram of some normally-distributed data. The data is centered around the value %d, with around 95%% of the data between %d and %d';
ans_format = '<a href="/static/normhist_%d.png" target="_blank"><img src="/static/normhist_%d.png" alt="%s"/></a>';

% Decide if the correct answer is present or "None of these"
chance_none = 0.2;
if rand>chance_none
    
    % Correct answer is correct line.
    alt_text = sprintf(alt_format,ref_mean,ref_mean-2*ref_std,ref_mean+2*ref_std);
    correct = sprintf(ans_format,img_id,img_id,alt_text);  
    
    % Get indices of incorrect answers. First 2 are the near misses, and
    % then pick one randomly
    other_ind = find(~ismember(1:size(map,1),[img_id nearMiss_ind]));
    incorrect_ind = [nearMiss_ind randsample(other_ind,1)];
    for ii = 1:3
        incorrect_mean = map(incorrect_ind(ii),2);
        incorrect_std = map(incorrect_ind(ii),1);
        alt_text = sprintf(alt_format,incorrect_mean, ...
            incorrect_mean-2*incorrect_std,incorrect_mean+2*incorrect_std);
        incorrect{ii} = sprintf(ans_format, ...
            incorrect_ind(ii),incorrect_ind(ii),alt_text);  
    end    
    
    % Last incorrect is "None of these"
    incorrect{4} = 'None of these';
    
    % No extra explanation needed
    explanation = '';
else
    
    % Correct answer is "None of these". First two incorrects are the
    % "near-misses"
    correct = 'None of these';
    
    % Get indices of incorrect answers. First 2 are the near misses, and
    % then pick 2 randomly
    other_ind = find(~ismember(1:size(map,1),[img_id nearMiss_ind]));
    incorrect_ind = [nearMiss_ind randsample(other_ind,2)];
    for ii = 1:4
        incorrect_mean = map(incorrect_ind(ii),2);
        incorrect_std = map(incorrect_ind(ii),1);
        alt_text = sprintf(alt_format,incorrect_mean, ...
            incorrect_mean-2*incorrect_std,incorrect_mean+2*incorrect_std);
        incorrect{ii} = sprintf(ans_format, ...
            incorrect_ind(ii),incorrect_ind(ii),alt_text);  
    end  
    
    % Extra explanation
    explanation = '<br/><p>However, this image is not one of the above choices. Therefore, the correct answer is "None of these".</p>';
end

% Reference answer to put in solution.
ref_alt_text = sprintf(alt_format,ref_mean,ref_mean-2*ref_std,ref_mean+2*ref_std);
ref_ans = sprintf(ans_format,img_id,img_id,ref_alt_text);

% Output values needed to display the problem and solution
problem_values = {ref_std,ref_mean,ref_ans};



    