function [arrays,array_size] = data36()
% function data36 - Generate answers for QMB problem data36
%
%   [correct,incorrect,problem_values] = data36()

% Size of array
array_size = randi([4 8],1);

% Format for display
format = '%10.4f';

% Arrays to be used for display.
arrays = {randn(array_size), ... % Correct
          zeros(array_size), ... % Zeros
          randi(10,array_size)-5, ... % Integers
          5*randn(array_size), ... % Large variance
          randn(array_size) + randi([3 5],1)*randsample([-1 1],1)}; %Shift mean
      
% Cheat a bit for arrays{4}: make sure it has at least 1 number >3
while all(abs(arrays{4}(:))<3)
    arrays{4} = 5*randn(array_size);
end

% Cheat a bit for arrays{5}. Make sure all numbers are the same sign
while length(unique(sign(arrays{5})))==2
    arrays{5} = randn(array_size) + randi([3 5],1)*randsample([-1 1],1);
end

% Convert arrays to display strings
for ii = 1:length(arrays)
    arrays{ii} = ['$$' mimic_array_output(arrays{ii},'ans',format) '/$$'];
end

