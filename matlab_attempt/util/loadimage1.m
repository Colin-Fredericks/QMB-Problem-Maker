function [answer,fname,solution] = loadimage1(choice,fname_base,sizes)
% LOADIMAGE1 - Problem for QMB problem loadimage1    
%
%    [answer,fname,solution] = loadimage1(fname_base,sizes)  
%

%Pick random size
answer_ind = randsample(length(sizes),2);
size_im = sizes(answer_ind);

%Assemble file name
id = (answer_ind(1)-1)*length(sizes) + answer_ind(2);
fname = [fname_base '_gray_resized_' num2str(id) '.jpg'];

%Get answer based on choice
if strcmp(choice,'rows')
    answer = size_im(1);
else
    answer = size_im(2);
end

% Get solution
solution = sprintf('<p>When the image is loaded to your Workspace, there should be a variable named $%s/$. The "Value" should say something like $%dx%d uint8/$. These first two numbers are the dimensions of the array and the $uint8/$ refers to the type of the number in the array. It stands for "unsigned 8-bit integer" but you''ll learn more about that later.</p><br/><p>Since this problem asks for the number of %s, the answer is $%d/$.</p>', ...
    [fname_base '_gray_resized_' num2str(id)],size_im,choice,answer);