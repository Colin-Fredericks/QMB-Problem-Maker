function names = sample_random_firstnames(num_names)
% SAMPLE_RANDOM_FIRSTNAMES - pick random first names
%
%
%   names = sample_random_firstnames(n) will sample n names from the top
%   500 most common first names between 1963 and 2017 

%Open list of words
load Data\top500firstnames_1963to2017.mat nameTable

%use randsample to sample without replacement
rows = randsample(size(nameTable,1),num_names);
names = nameTable{rows,'Name'};

%Return just the string if only one word is sampled
if num_names==1
    names = names{1};
end

