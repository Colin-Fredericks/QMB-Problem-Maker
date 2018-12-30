% Make 1D data arrays for summary statistics

addpath ..\util
num_words = 50;
num_repeats = 50;

% Pick out the words
base_words = sample_random_words(num_words);
myArray = {};

% Select repeats of each word
for ii = 1:num_words
    reps = randi([2 num_repeats],1);
    myArray = [myArray; repmat(base_words(ii),reps,1)];
end

% Shuffle
myArray = myArray(randperm(length(myArray)));

% Save
save random_words_with_repeats myArray