function [code_snippet,answer] = figure1(num_images)
% FIGURE1 -  generates info for CQMB problem figure1
%
%   [code_snippet,answer] = figure1(num_images)
%


code_snippet = sprintf('figure\nimage(im%d)\n',1);
count = 1;
for ii = 1:num_images-1
    if rand>0.5
        code_snippet = [code_snippet sprintf('figure\n',1)];
        count = count + 1;
    end
    code_snippet = [code_snippet sprintf('imshow(im%d)\n',ii+1)];
end

answer = count;