function [correct_str,incorrect_str,row_str,col_str] = get_image3_answers(fname,size_im,step_sizes)
%Function GET_IMAGE3_ANSWERS: Creates answers for QMB problem 'image3'
%
%   [CORRECT,WRONG,ROW_STR,COL_STR] = get_image3_answers(FNAME,DIM,STEP) 
%   creates the answers for the multiple choice problem 'image3'. FNAME is
%   the name of the base image, e.g. 'clock.jpg'. DIM is the dimension of
%   the base image as returned by size(). STEP is an array of step sizes
%   used for the downsampling options, e.g. [2 4] implies the image was
%   downsampled by factors of 2 and 4.
%
%   CORRECT is a string with the html tag that will show the correct image,
%   e.g. <img src="clock_cropped2.jpg">. 20% of the time, the correct
%   answer will be 'None of these'
%
%   WRONG is a cell array of strings with the other four answers, either
%   <img> tags or 'None of these'
%
%   ROW_STR and COL_STR are the strings with the indices asked about in the 
%   question text, e.g. if ROW_STR = '1:2:150' and COL_STR = '1:3:120', the
%   question asked will be: 'What is the downsampled image created by
%   im(1:2:150,1:3:120)?'


% Get name for image, e.g. 'clock' or 'flower'
[~,base_name,file_ext] = fileparts(fname);

%Generate possible choices of grid, e.g. (1,4) or (2,3)
num_step = length(step_sizes);
choices = [collapse(repmat(step_sizes,num_step,1)) ...
           collapse(repmat(step_sizes',1,num_step))];

%Figure out the pixel sizes based on the size of the original image
pixel_sizes = zeros(num_step^2,2);
for ii = 1:num_step
    for jj = 1:num_step
        kk = (ii-1)*num_step + jj;
        height = length(1:step_sizes(ii):size_im(1));
        width = length(1:step_sizes(jj):size_im(2));
        pixel_sizes(kk,:) = [height width];
    end
end       
       
%Pick one to be the question choice       
question_choice = randsample(step_sizes,2,true);
question_ind = find(question_choice(1)==choices(:,1) & ...
                    question_choice(2)==choices(:,2));
row_str = ['1:' num2str(question_choice(1)) ':end'];
col_str = ['1:' num2str(question_choice(2)) ':end'];

%Now generate the answers. First, pick 4 random choices not including the
%question choice (without replacement)
answer_ind = randsample([1:question_ind-1  ...
                        question_ind+1:size(choices,1)]',4);
                    
% 80% of the time, the correctly sampled image will be one of the choices
incorrect_str = cell(4,1);
if rand<0.8 
    correct_str = ['<img src="/static/' base_name '_grid'...
        num2str(num_step) '_downsize' num2str(question_ind) file_ext ...
        '" alt=""/><p>Size is ' num2str(pixel_sizes(question_ind,2)) ' x ' ...
        num2str(pixel_sizes(question_ind,1)) ' pixels</p>'];
    for ii = 1:3
        incorrect_str{ii} = ['<img src="/static/' base_name '_grid'...
            num2str(num_step) '_downsize' num2str(answer_ind(ii)) file_ext ...
            '" alt=""/><p>Size is ' num2str(pixel_sizes(answer_ind(ii),2)) ' x ' ...
            num2str(pixel_sizes(answer_ind(ii),1)) ' pixels</p>'];
    end
    incorrect_str{4} = 'None of these';

else
    correct_str = 'None of these';
    for ii = 1:4
        incorrect_str{ii} = ['<img src="/static/' base_name '_grid'...
            num2str(num_step) '_downsize' num2str(answer_ind(ii)) file_ext ...
            '" alt=""/><p>Size is ' num2str(pixel_sizes(answer_ind(ii),2)) ' x ' ...
            num2str(pixel_sizes(answer_ind(ii),1)) ' pixels</p>'];
    end
    
end
