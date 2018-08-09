function [correct,incorrect,fname,solution] = loadimage2(fname_base,sizes)
% LOADIMAGE1 - Problem for QMB problem loadimage2    
%
%    [answer,fname,solution] = loadimage2(fname_base,sizes)  
%

%Pick random size
answer_ind = randsample(length(sizes),2);
size_im = sizes(answer_ind);

%Assemble file name
id = (answer_ind(1)-1)*length(sizes) + answer_ind(2);
fname = [fname_base '_gray_resized_' num2str(id) '.jpg'];

if size_im(1)>size_im(2)
    correct = 'The image is vertically taller';
    incorrect = 'The image is horizontallly wider';
    size_strs = {'rows','columns'};
else
    incorrect = 'The image is vertically taller';
    correct = 'The image is horizontallly wider';
    size_strs = {'columns','rows'};
end
    
% Get solution
var_name = [fname_base '_gray_resized_' num2str(id)];
solution = sprintf('<p>When the image is loaded to your Workspace, there should be a variable named $%s/$. If you visualize the image with the command $imshow(%s)/$, a figure will appear with the image. You should be able to see that the correct answer is: %s.</p><br/><p>Another way to solve this problem is to look at the dimensions of the array. In the Workspace, the "Value" of the array should say something like $%dx%d uint8/$. These first two numbers are the number of rows and columns, respectively. Since there are more %s than %s, the correct answer is: %s.</p>', ...
    var_name,var_name,correct,size_im,size_strs{1},size_strs{2},correct);