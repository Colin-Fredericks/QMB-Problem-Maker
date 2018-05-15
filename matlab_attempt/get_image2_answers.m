function [correct_str,incorrect_str,row_str,col_str] = get_image2_answers(fname,size_im,num_crop)
%Function GET_IMAGE3_ANSWERS: Creates answers for QMB problem 'image2'
%
%   [CORRECT,WRONG,ROW_STR,COL_STR] = get_image3_answers(FNAME,DIM,NCROP) 
%   creates the answers for the multiple choice problem 'image2'. FNAME is
%   the name of the base image, e.g. 'clock.jpg'. DIM is the dimension of
%   the base image as returned by size(). NCROP is the number of cropped 
%   images that were created. This question asks about four different 
%   versions of a cropped imaged, namely:
%       1. Original
%       2. Flipped up/down
%       3. Flipped left/right
%       4. Flipped up/down and left/right
%
%   CORRECT is a string with the html tag that will show the correct image,
%   e.g. <img src="clock_cropped2.jpg">. 20% of the time, the correct
%   answer will be 'None of these'
%
%   WRONG is a cell array of strings with the other four answers, either
%   <img> tags or 'None of these'
%
%   ROW_STR and COL_STR are the strings with the indices asked about in the 
%   question text, e.g. if ROW_STR = '150:-1:1' and COL_STR = '120:-1:1', 
%   the question asked will be: 'What is the cropped and potentially 
%   flipped image created by im(150:-1:1,120:-1:1)?'


% Get name for image, e.g. 'clock' or 'flower'
[~,base_name,file_ext] = fileparts(fname);

%Generate possible choices. There are num_crop^2 images, each with four
%flip options, so this has num_crop^2*4 rows
choices = [collapse(repmat(1:num_crop^2,4,1)) ...
           collapse(repmat((1:4)',1,num_crop^2))];

% Here is the grid of choices. I've only tried this for num_crop = 2,
% meaning there are 2^2 = 4 images.
%           orig    u/d     l/r     both
% 1st img   (1,1)   (1,2)   (1,3)   (1,4)
% 2nd img   (2,1)   (2,2)   (2,3)   (2,4)
% 3rd img   (3,1)   (3,2)   (3,3)   (3,4)
% 4th img   (4,1)   (4,2)   (4,3)   (4,4)

%Pick one to be the question choice       
question_choice = [randi(num_crop^2,1) randi(4,1)];
question_ind = find(question_choice(1)==choices(:,1) & ...
                    question_choice(2)==choices(:,2));

%Find out the row and column indices
row_pts = round(linspace(1,size_im(1),num_crop+1));
col_pts = round(linspace(1,size_im(2),num_crop+1));
quotient = floor(question_choice(1)/num_crop);
remainder = question_choice(1) - num_crop*quotient;
rows = row_pts(quotient+[1 2]);
cols = col_pts(remainder+[1 2]);

%Use those indices to create the strings used for display
if question_choice(2)==1
    row_str = [num2str(rows(1)) ':1:' num2str(rows(2))];
    col_str = [num2str(cols(1)) ':1:' num2str(cols(2))];
elseif question_choice(2)==2
    row_str = [num2str(rows(2)) ':-1:' num2str(rows(1))];
    col_str = [num2str(cols(1)) ':1:' num2str(cols(2))];
elseif question_choice(2)==3
    row_str = [num2str(rows(1)) ':1:' num2str(rows(2))];
    col_str = [num2str(cols(2)) ':-1:' num2str(cols(1))];
elseif question_choice(2)==4
    row_str = [num2str(rows(2)) ':-1:' num2str(rows(1))];
    col_str = [num2str(cols(2)) ':-1:' num2str(cols(1))];
end

%Generate the answers. First, pick 4 random choices not including the
%question choice (without replacement)
answer_ind = randsample([1:question_ind-1  ...
                        question_ind+1:size(choices,1)]',4);
                    
% 80% of the time, the correct image will be one of the choices
% 20% of the time, the correct answer will be "None of these"
incorrect_str = cell(4,1);
if rand < 0.8 
    correct_str = ['<img src="/static/' base_name '_grid'...
        num2str(num_crop) '_flip' num2str(question_ind) file_ext ...
        '" alt=""/>'];
    for ii = 1:3
        incorrect_str{ii} = ['<img src="/static/' base_name '_grid'...
            num2str(num_crop) '_flip' num2str(answer_ind(ii)) file_ext ...
            '" alt=""/>'];
    end
    incorrect_str{4} = 'None of these';

else
    correct_str = 'None of these';
    for ii = 1:4
        incorrect_str{ii} = ['<img src="/static/' base_name '_grid'...
            num2str(num_crop) '_flip' num2str(answer_ind(ii)) file_ext ...
            '" alt=""/>'];
    end
    
end
