clear
close all
T = readtable('three_letter_words.txt');
words = T{:,1}; clear T

% Functions to use with cellfun
removeFirst = @(x) x(2:end);
onlyFirst = @(x) x(1);

% Split up words to first and last letters
endOfWords = cellfun(removeFirst,words,'UniformOutput',false);
firstLetters = cellfun(onlyFirst,words,'UniformOutput',false);

% Count number of unique two-letter endings
uniqueEnds = unique(endOfWords);
counts = countmember(uniqueEnds,endOfWords);

% Sort counts 
[counts,sort_ind] = sort(counts,'descend');
uniqueEnds = uniqueEnds(sort_ind);

% Pick a subset to output for problems
nWords = 20;

% Join the first letters together and write to file
fid = fopen('three_letter_beginnings.txt','w');
fprintf(fid,'Ending\tFirstLetters\n')
for ii = 1:nWords
    hasEnd = contains(endOfWords,uniqueEnds{ii});
    currentWords = words(hasEnd);
    letters = strjoin(firstLetters(hasEnd),'');
    fprintf(fid,'%s\t%s\n',uniqueEnds{ii},letters);
end

fclose(fid);