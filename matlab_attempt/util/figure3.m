function [answers,correctness,solution] = figure3(num_images)
% FIGURE3 - creates answers for QMB problem figure3
%
% [answers,correctness,solution] = figure3(num_images)
%
%




%Add all possibilities of figure presence/absence. For example
%
%   figure
%   imshow(image1)
%   imshow(image2)
%   figure
%   imshow(image3)
%
code_snippets = {};
for ii = 1:2^(num_images-1)
    places = dec2bin(ii-1,num_images-1);
    code_snippet = sprintf('figure\nimshow(image%d)',1);
    for jj = 1:length(places)
        if places(jj) == '1'
            code_snippet = [code_snippet sprintf('\nfigure',1)];
    
        end
        code_snippet = [code_snippet sprintf('\nimshow(image%d)',jj+1)];
    end
    code_snippets{ii} = ['$$' code_snippet '/$$'];
end

%The only correct should be the last one where all the figure lines are
%present
is_correct = false(size(code_snippets));
is_correct(end) = true;


%Add semicolon variants. For example
%
%   figure;
%   imshow(image1);
%   imshow(image2);
%   figure;
%   imshow(image3);
%
with_semicolons = cell(1,2^(num_images-1));
for ii = 1:2^(num_images-1)
    with_semicolons{ii} = strrep(code_snippets{ii},char(10)',[';' char(10)]);
end

%Add single line variants. For example
%
%   figure, imshow(image1), imshow(image2), figure, imshow(image3)
%
single_lines = cell(1,2^(num_images-1));
for ii = 1:2^(num_images-1)
    single_lines{ii} = collapse_code(code_snippets{ii});
end

%Add single line semicolon variants. For example
%
%   figure; imshow(image1); imshow(image2); figure; imshow(image3)
%

semi_single = cell(1,2^(num_images-1));
for ii = 1:2^(num_images-1)
    semi_single{ii} = collapse_code(with_semicolons{ii});
end

%Make variants with only image1. For example
%
%   figure
%   imshow(image1)
%   imshow(image1)
%   figure
%   imshow(image1)
%
only_image1 = cell(1,2^(num_images-1));
for ii = 1:2^(num_images-1)
    only_image1{ii} = regexprep(code_snippets{ii},'image[1-9]','image1');
end

% Make single line variants with only image1. For example
%
%   figure, imshow(image1), imshow(image1), figure, imshow(image1)
%
single_line_image1 = cell(1,2^(num_images-1));
for ii = 1:2^(num_images-1)
    single_line_image1{ii} = collapse_code(only_image1{ii});
end


%Combine everything together to an answer cell. 
possible_answers = [code_snippets, with_semicolons, single_lines, ...
                    semi_single, only_image1, single_line_image1];

%Combine correctness as well. For ones with only image1, they are all false
possible_correctness = [is_correct, is_correct, is_correct, is_correct, ...
                        false(size(is_correct)), false(size(is_correct))];

%Pick 5 answers. Make sure there is at least one correct answer
answer_ind = randsample(length(possible_answers),5);
while ~any(possible_correctness(answer_ind))
    answer_ind = randsample(length(possible_answers),5);
end

%Select these answers for output
answers = possible_answers(answer_ind);
correctness_ind = possible_correctness(answer_ind);

%Change correctness from [1 0 0] to {'TRUE','FALSE','FALSE'} used by excel
correctness = convert_logical(correctness_ind);

% Lastly. Write out the solution

if sum(correctness_ind) == 1
    solution = ['Therefore, the only correct answer is:' answers{correctness_ind}];
else
    temp_answers = answers(correctness_ind);
    solution = ['Therefore, the correct answers are:' strjoin(temp_answers,' ')];    
end





end

function str = collapse_code(str)
% COLLAPSE_CODE - puts a string code snippet with multiple line onto 1 line
%
%   new_str = collapse_code(STR) will take a string STR that has lines of
%   code with newline characters and compresses them to a single line. If
%   the lines are terminated with semicolons or commas, they are kept, but
%   lines without an ending character will insert commas
%
%   For example
%   ['x = 1' char(10) 'y = 2']  will become 'x = 1, y = 2'
%   ['x = 1;' char(10) 'y = 2;']  will become 'x = 1; y = 2;'
%

str = strrep(str,[',' char(10)],', ');
str = strrep(str,[';' char(10)],'; ');
str = strrep(str,char(10),', ');

end