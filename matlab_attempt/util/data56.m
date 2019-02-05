function [correct,incorrect,problem_values,explanation] = data56()
% function data56 - Generate answers for QMB problem data56
%
%   [correct,incorrect,problem_values,explanation] = data56()

% Pick an array name
array_name = randsample('abcdfghkmnpqrtvwxyz',1);

% Create array
array_length = randi([7 12],1);
array = randi(100,1,array_length);

% Which indices to repalce with NaNs
nReplace = randi([1 6],1);
indReplace = randsample(array_length,nReplace);

% Change values and make display
array(indReplace) = NaN;
array_display = mimic_array_output(array,'ans','%6d');

% Make an "other array for possible wrong answers"
while true
    other_array = zeros(size(array));
    other_array(randsample(array_length,nReplace)) = 1;
    if any(isnan(array)~=other_array) && any(~isnan(array)~=other_array)
        break
    end
end

chance_none = 0.2;
if rand>chance_none
    correct = ['$$' mimic_array_output(isnan(array),'ans','%6d') '/$$'];
    incorrect{1} = ['$$' mimic_array_output(~isnan(array),'ans','%6d') '/$$'];
    incorrect{2} = ['$$' mimic_array_output(other_array,'ans','%6d') '/$$'];
    incorrect{3} = ['$$' mimic_array_output(~other_array,'ans','%6d') '/$$'];
    incorrect{4} = 'None of these';
    
    % No extra explanation needed
    explanation = '';
else
    
    correct = 'None of these';
    incorrect{1} = ['$$' mimic_array_output(~isnan(array),'ans','%6d') '/$$'];
    incorrect{2} = ['$$' mimic_array_output(other_array,'ans','%6d') '/$$'];
    incorrect{3} = ['$$' mimic_array_output(~other_array,'ans','%6d') '/$$'];
    incorrect{4} = ['$$' mimic_array_output(zeros(size(array)),'ans','%6d') '/$$'];
    
    % Extra explanation
    explanation = '<br/><p>However, this output is not one of the above choices. Therefore, the correct answer is "None of these".</p>';
end

reference = ['$$' mimic_array_output(isnan(array),'ans','%6d') '/$$'];
problem_values = {array_name,nReplace,array_display,reference};



    