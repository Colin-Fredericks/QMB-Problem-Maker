function [correct_str,incorrect_str,row_str,col_str,size_im,description] = image2(fname,num_crop,chance_none)
%Function IMAGE2: Creates answers for QMB problem 'image2'
%
%   [CORRECT,WRONG,ROW_STR,COL_STR,SIZE_IM,DESCRIP] = image2(FNAME,NCROP,PNONE) 
%   creates the answers for the multiple choice problem 'image2'. FNAME is
%   the name of the base image, e.g. 'clock.jpg'. NCROP is the number of 
%   cropped images that were created. This question asks about 
%   four different versions of a cropped imaged, namely:
%       1. Original
%       2. Flipped up/down
%       3. Flipped left/right
%       4. Flipped up/down and left/right
%
%   CORRECT is a string with the html tag that will show the correct image,
%   e.g. <img src="clock_cropped2.jpg">. Some of the time, the correct
%   answer will be 'None of these'
%
%   WRONG is a cell array of strings with the other four answers, either
%   <img> tags or 'None of these'
%
%   ROW_STR and COL_STR are the strings with the indices asked about in the 
%   question text, e.g. if ROW_STR = '150:-1:1' and COL_STR = '120:-1:1', 
%   the question asked will be: 'What is the cropped and potentially 
%   flipped image created by im(150:-1:1,120:-1:1)?'

%Only works for num_crop == 2
if num_crop~=2
    error('Code currently only works with num_crop==2');
end

%Load iamge to get the size
full_name = ['Images\Full Size\' fname];
im = imread(full_name);
size_im = [size(im,1) size(im,2)];

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
question_ind = randi(size(choices,1),1);
question_choice = choices(question_ind,:);
                
%-------- This part needs to be fixed if num_crop will ever be >2 ---------

%Find out the row and column indices
row_pts = round(linspace(1,size_im(1),num_crop+1));
col_pts = round(linspace(1,size_im(2),num_crop+1));
if question_choice(1) == 1
    rows = row_pts(1:2);
    cols = col_pts(1:2);
elseif question_choice(1) == 2
    rows = row_pts(1:2);
    cols = col_pts(2:3);
elseif question_choice(1) == 3
    rows = row_pts(2:3);
    cols = col_pts(1:2);
elseif question_choice(1) == 4
    rows = row_pts(2:3);
    cols = col_pts(2:3);
end

% String for helping to explain the solution. Right now just works for a
% 2x2 grid, i.e. num_crop = 2
pieces = {'top left';    'top right';  ...
          'bottom left'; 'bottom right'};        

% -------------------------------------------------------------------------

% Choices for various flips
flip_strings = {'unaltered, i.e. not flipped in any way'; ...
                'flipped upside down'; ...
                'flipped left/right, i.e. a mirror image'; ...
                'flipped left/right and up/down'};     
            
% Create the strings used for display
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

                    
% Some of the time, the correct image will be one of the choices
% Other times, the correct answer will be "None of these"
incorrect_str = cell(4,1);
alt_pre = 'A piece from an image that was cropped into a 2x2 grid and potentially flipped in one or both dimensions. This particular piece is from the ';
alt_post = ' and has been ';
if rand > chance_none 
    
    %Assemble the alt text
    alt_str = [alt_pre pieces{question_choice(1)} alt_post flip_strings{question_choice(2)} '.'];
    
    %XML answer to display the correct piece
    correct_str = ['<img src="/static/' base_name '_grid'...
        num2str(num_crop) '_flip' num2str(question_ind) file_ext ...
        '" alt="' alt_str '"/>'];
    for ii = 1:3
        
        %Create alt text for wrong answers
        answer_choice = choices(answer_ind(ii),:);
        alt_str = [alt_pre pieces{answer_choice(1)} alt_post flip_strings{answer_choice(2)} '.'];
        
        %XML for displaying wrong answer
        incorrect_str{ii} = ['<img src="/static/' base_name '_grid'...
            num2str(num_crop) '_flip' num2str(answer_ind(ii)) file_ext ...
            '" alt="' alt_str '"/>'];
    end
    incorrect_str{4} = 'None of these';

% Assemble answers if the correct choice is "None of these"
else
    correct_str = 'None of these';
    for ii = 1:4
        answer_choice = choices(answer_ind(ii),:);
        alt_str = [alt_pre pieces{answer_choice(1)} alt_post flip_strings{answer_choice(2)} '.'];
        incorrect_str{ii} = ['<img src="/static/' base_name '_grid'...
            num2str(num_crop) '_flip' num2str(answer_ind(ii)) file_ext ...
            '" alt="' alt_str '"/>'];
    end
    
end

% Description cell array has the two pieces of the al string used for the
% correct answer
description = {pieces{question_choice(1)}, flip_strings{question_choice(2)}};
