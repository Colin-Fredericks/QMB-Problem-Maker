function words = sample_random_words(num_words)
% SAMPLE_RANDOM_WORDS - pick random words from a dictionary
%
%
%   words = sample_random_words(n) will sample n words from a dictionary of
%   of common words and 

%Open list of words
fid = fopen('most_common_words_1000.txt','r');
C = textscan(fid,'%s');
C = C{1};

%use randsample to sample without replacement
words = randsample(C,num_words);

%Return just the string if only one word is sampled
if num_words==1
    words = words{1};
end

%Close the file
fclose(fid);