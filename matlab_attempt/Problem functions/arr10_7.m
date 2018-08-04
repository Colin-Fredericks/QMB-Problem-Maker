function [answers,correctness,explanation] = arr10_7(chance_none)
% ARR10_7 - Problem function for QMB problem arr10.7
%
%   [correct,incorrect,explanation] = arr10_7() 
%

%List of possible places
places = {'workspace', ...
          'current folder', ...
          'first folder on the path', ...
          'second folder on the path', ...
          'third folder on the path', ...
          'subfolder in the first folder on the path', ...
          'subfolder in the second folder on the path', ...
          'subfolder in the current folder'};
      
%Indices for all the different possible orderings of answers
choices_ind = nchoosek(1:length(places),4);
      
%Need to specify which are wrong answers. There are two possible ways have
% an incorrect answer. 
% (1) Has a completely wrong place
% (2) Right places are in the wrong order
% First, we assume every choice is correct
is_correct = true(size(choices_ind,1),1);

% Remove the wrong places
wrong_places = [6,7,8];
for ii = wrong_places
    wrong_ind = sum(choices_ind == ii,2) > 0;
    is_correct(wrong_ind) = false;
end

% Remove the wrong orders
for ii = 1:size(choices_ind,1)
    is_ascending = all(diff(choices_ind(ii,:)) > 0);
    if ~is_ascending
        is_correct(ii) = false;
    end
end


% Explanation beginnning
explanation_start = 'The first place Matlab will look is the Workspace for a variable named $Hello/$. Next, it will search the current folder for a file named $Hello/$. Lastly, it will look sequentially in the folders on the path, again for a file named $Hello/$. Matlab does NOT look in subfolders. This is why there is a "Add with Subfolders..." button in the Set Path window. ';

% Determine if a correct answer is present
if rand > chance_none
    
    % Choose 4 answers. Some of the time, make sure these is one correct
    % answer. Otherwise, make sure there is more than one correct answer
    answer_ind = randsample(size(choices_ind,1),4);
    if rand < 0.5
        while sum(is_correct(answer_ind))~=1
            answer_ind = randsample(size(choices_ind,1),4);
        end
    else
        while sum(is_correct(answer_ind))<2
            answer_ind = randsample(size(choices_ind,1),4);
        end
    end
    
    %Assemble answers and correctness
    for ii = 1:4
        answers{ii} = ['<pre>' strjoin(places(choices_ind(answer_ind(ii),:)),char(10)) '</pre>'];
        correctness{ii} = convert_logical(is_correct(answer_ind(ii)));
    end
    answers{5} = 'None of these are correct';
    correctness{5} = 'FALSE';
    
    %Assemble the explanation
    if sum(is_correct(answer_ind))>1
        explanation = [explanation_start 'Therefore, the correct answers are:<br/>'];
        for ii = find(is_correct(answer_ind))'
             explanation = [explanation '<br/>' answers{ii}];
        end
    else
        explanation = [explanation_start 'Therefore the only correct answer is:<br/><br/>' ...
            answers{is_correct(answer_ind)}];
    end

else
    % Choose 4 answers. Make sure none are correct
    answer_ind = randsample(size(choices_ind,1),4);
    while any(is_correct(answer_ind))
        answer_ind = randsample(size(choices_ind,1),4);
    end
    
    %Assemble answers and correctness
    for ii = 1:4
        answers{ii} = ['<pre>' strjoin(places(choices_ind(answer_ind(ii),:)),char(10)) '</pre>'];
        correctness{ii} = convert_logical(is_correct(answer_ind(ii)));
    end
    answers{5} = 'None of these are correct';
    correctness{5} = 'TRUE';
    
    explanation = [explanation_start '<br/><br/>None of these choices have valid places Matlab will look in the correct order. Therefore, the correct answer is "None of these are correct"'];
end
    


    
        
        
