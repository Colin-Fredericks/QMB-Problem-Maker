function [answers,correctness,explanation] = arr10_8(chance_none)
% ARR10_8 - Problem function for QMB problem arr10.8
%
%   [correct,incorrect,explanation] = arr10_8(chance_none) 
%
%
%   This is a simpler version of arr10.7
%   That problem would list an ordering of four places from a choice of 5,
%   so there were multiple possible correct answers. This problem will list
%   all 5, so there is only one correct answer. To add some variability,
%   this problem will sometimes have "None of these" as the correct answer
%
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
choices_ind = nchoosek(1:length(places),5);
      
%Need to specify which are wrong answers. There are two possible ways have
% an incorrect answer. 
% (1) Has a completely wrong place
% (2) Right places are in the wrong order
% Only choices 1:5 are correct, so 1:5 is the only correct ordering
is_correct = ismember(choices_ind,1:5,'rows');

% Explanation beginnning
explanation_start = 'The first place Matlab will look is the Workspace for a variable named $Hello/$. Next, it will search the current folder for a file named $Hello/$. Lastly, it will look sequentially in the folders on the path, again for a file named $Hello/$. Matlab does NOT look in subfolders. This is why there is a "Add with Subfolders..." button in the Set Path window. ';

% Determine if a correct answer is present
if rand > chance_none
    
    %Find correct answer    
    answers{1} = ['<pre>' strjoin(places(choices_ind(is_correct,:)),char(10)) '</pre>'];
    correctness{1} = 'TRUE';
    
    % Choose 3 wrong answers.
    answer_ind = randsample(find(~is_correct),3)';    
    
    %Assemble answers and correctness
    for ii = 1:3
        answers{ii+1} = ['<pre>' strjoin(places(choices_ind(answer_ind(ii),:)),char(10)) '</pre>'];
        correctness{ii+1} = convert_logical(is_correct(answer_ind(ii)));
    end
    answers{5} = 'None of these are correct';
    correctness{5} = 'FALSE';
    
    %Assemble the explanation
    explanation = [explanation_start 'Therefore the only correct answer is:<br/><br/>' ...
        answers{1}];
   

else
    % Choose 4 answers. Make sure none are correct
    answer_ind = randsample(find(~is_correct),4)';    
    
    %Assemble answers and correctness
    for ii = 1:4
        answers{ii} = ['<pre>' strjoin(places(choices_ind(answer_ind(ii),:)),char(10)) '</pre>'];
        correctness{ii} = convert_logical(is_correct(answer_ind(ii)));
    end
    answers{5} = 'None of these are correct';
    correctness{5} = 'TRUE';
    
    explanation = [explanation_start '<br/><br/>None of these choices have valid places Matlab will look in the correct order. Therefore, the correct answer is "None of these are correct"'];
end
    


    
        
        
