function [code_snippet,is_correct,solution_str] = figure2(num_images)
% FIGURE1 -  generates info for CQMB problem figure2
%
%   [code_snippet,is_correct,solution_str] = figure2(num_images)
%


%Initialize first line of snippet
code_snippet = sprintf('figure\nimage(im%d)\n',1);


is_correct = {};
count = 1;
for ii = 1:num_images-1
    if rand>0.5
        code_snippet = [code_snippet sprintf('figure\n',1)];
        is_correct{ii} = 'TRUE';
        count = count+1;
    else
        is_correct{ii} = 'FALSE';
    end
    code_snippet = [code_snippet sprintf('imshow(im%d)\n',ii+1)];
end

%Last image will always be shown
is_correct{num_images} = 'TRUE';


%Format solution string
im_nums = find(strcmp(is_correct,'TRUE'));
if length(im_nums) == 1
    im_list = sprintf('only $im%d/$ will be shown',im_nums(1));
elseif length(im_nums)==2
    im_list = sprintf('$im%d/$ and $im%d/$ will be shown',im_nums);
else
    im_list = [sprintf('$im%d/$, ',im_nums(1:end-1)) ...
               sprintf('and $im%d/$ will be shown',im_nums(end))];
end    
    
solution_str = ['This code snippet will show ' num2str(count) ...
    ' images after it runs. The last image before a $figure/$ command' ...
    ' will be shown because that image will not be overwritten. Therefore ' ...
    im_list '.'];


