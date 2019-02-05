function names = sample_random_lastnames(num_names)
% SAMPLE_RANDOM_LASTNAMES - pick random last names
%
%
%   names = sample_random_lastnames(n) will sample n names from the top
%   500 most common last names from 2010

%Open list of words
load Data\top500lastnames_2010 surnameTable

%use randsample to sample without replacement
rows = randsample(size(surnameTable,1),num_names);
names = surnameTable{rows,'Surname'};

%Return just the string if only one word is sampled
if num_names==1
    names = names{1};
end

