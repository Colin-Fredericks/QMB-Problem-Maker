function [arrays,array_size] = data37()
% function data37 - Generate answers for QMB problem data37
%
%   [correct,incorrect,problem_values] = data37()

% Size of array
array_size = randi([4 8],1);

% Format for display
format = '%10.4f';

% Arrays to be used for display.
arrays = {rand(array_size), ... % Correct
          randn(array_size), ... % Normal
          randi(10,array_size), ... % Integers
          rand(array_size)*10, ... % Big numbers
          zeros(array_size)}; % zeros

% Make sure arrays{2} has something outside of [0,1]
while all(arrays{2}(:)>0) && all(arrays{2}(:)<1)
    arrays{2} = randn(array_size);
end

% Convert arrays to display strings
for ii = 1:length(arrays)
    arrays{ii} = ['$$' mimic_array_output(arrays{ii},'ans',format) '/$$'];
end

