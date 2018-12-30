% Make 1D data arrays for summary statistics

addpath ..\util
fid = fopen('most_common_words_1000.txt','r');
words = textscan(fid,'%s');
words = words{1};

%Remove two letter words
lengths = cellfun(@length,words);
words = words(lengths>2);

%shuffle the words
words = words(randperm(length(words)));

% Save half and half to two different arrays
half = round(length(words)/2);

% Save
myArray = words(1:half);
save random_words1 myArray
myArray = words(half+1:end);
save random_words2 myArray
