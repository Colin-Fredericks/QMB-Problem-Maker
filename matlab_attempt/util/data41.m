function [correct,incorrect,problem_values,explanation] = data41()
% function data41 - Generate answers for QMB problem data41
%
%   [correct,incorrect,problem_values,explanation] = data41()


% Get map of ID to mean and stddev
stddevs = [1 5 10];
means = 10:10:100; 
map = [collapse(repmat(stddevs,length(means),1)), ...
       collapse(repmat(means',length(stddevs),1))];

% Get string versions for answers
choices = cell(size(map,1),1);
for ii = 1:size(map,1)
    choices{ii} = sprintf('$$y = %d * x + %d;/$$',map(ii,1),map(ii,2));
end
   
%Pick an img_id
img_id = randi(size(map,1),1);

% Alt text for image
alt_text = sprintf('A histogram of some normally-distributed data. The data is centered around the value %d, with around 95%% of the data between %d and %d', ...
    map(img_id,2),map(img_id,2)-2*map(img_id,1),map(img_id,2)+2*map(img_id,1));

% Find the answers that are almost right, e.g. with the right mean or right
% stddev but not both. These are the near-misses
mean_ind = map(:,2)==map(img_id,2) & map(:,1)~=map(img_id,1);
nearmiss_ind(1) = randsample(find(mean_ind),1);
std_ind = map(:,1)==map(img_id,1) & map(:,2)~=map(img_id,2);
nearmiss_ind(2) = randsample(find(std_ind),1);

% Decide if the correct answer is present or "None of these"
chance_none = 0.2;
if rand>chance_none
    
    % Correct answer is correct line. First two incorrects are the
    % "near-misses"
    correct = choices{img_id};
    incorrect(1:2) = choices(nearmiss_ind);
    
    % For the third incorrect, just pick one randomly
    other_ind = ~ismember(1:size(map,1),[img_id nearmiss_ind]);
    incorrect(3) = randsample(choices(other_ind),1);
    
    % Last incorrect is "None of these"
    incorrect{4} = 'None of these';
    
    % No extra explanation needed
    explanation = '';
else
    
    % Correct answer is "None of these". First two incorrects are the
    % "near-misses"
    correct = 'None of these';
    incorrect(1:2) = choices(nearmiss_ind);
    
    % 3rd and 4th incorrect are picked randomly
    other_ind = ~ismember(1:size(map,1),[img_id nearmiss_ind]);
    incorrect(3:4) = randsample(choices(other_ind),2);    
    
    % Extra explanation
    explanation = '<br/><p>However, this statement is not one of the above choices. Therefore, the correct answer is "None of these".</p>';
end

% Output values needed to display the problem and solution
reference = choices{img_id};
problem_values = {img_id,map(img_id,1),map(img_id,2),reference,alt_text};



    