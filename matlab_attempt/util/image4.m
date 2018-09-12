function [correct_str,incorrect_str,row_str,col_str,size_im,piece_str] = image4(fname,chance_none)
%Function GET_IMAGE1_ANSWERS: Creates answers for QMB problem 'image1'
%
%   [CORRECT,WRONG,ROW_STR,COL_STR,SIZE,PIECE] =  ...
%        get_image1_answers(FNAME,NCROP,PNONE) 
%   creates the answers for the multiple choice problem 'image1'. FNAME is
%   the name of the base image, e.g. 'clock.jpg'. 
%
%   CORRECT is a string with the html tag that will show the correct image,
%   e.g. <img src="clock_cropped2.jpg">. Some of the time, the correct
%   answer will be 'None of these'
%
%   WRONG is a cell array of strings with the other four answers, either
%   <img> tags or 'None of these'
%
%   ROW_STR and COL_STR are the strings with the indices asked about in the 
%   question text, e.g. if ROW_STR = '1:150' and COL_STR = '1:120', the
%   question asked will be: 'What is im(1:150,1:120)'


%Load iamge to get the size
full_name = ['Images\Full Size\' fname];
im = imread(full_name);
size_im = [size(im,1) size(im,2)];

% Get nam for image, e.g. 'clock' or 'flower'
[~,base_name,file_ext] = fileparts(fname);

%Create row and col choices
row2 = round(size_im(1)/2);
row_choices = { '1:end', ...
               ['1:end-' num2str(row2)], ...
               ['end-' num2str(row2) ':end']};
col2 = round(size_im(2)/2);
col_choices = { '1:end', ...
               ['1:end-' num2str(col2)], ...
               ['end-' num2str(col2) ':end']};


%Generate possible choices of grid, e.g. (1,3) or (2,2)
choices = [collapse(repmat(1:3,3,1)) ...
           collapse(repmat((1:3)',1,3))];

%Pick one to be the question choice       
question_ind = randi(9,1);
question_choice = choices(question_ind,:);
row_str = row_choices{question_choice(1)};
col_str = col_choices{question_choice(2)};

%Now generate the answers. First, pick 4 random choices
answer_ind = randsample([1:question_ind-1  ...
                        question_ind+1:size(choices,1)]',4);

                    
% String for helping to explain the solution. This cell array corresponds
% to the choices array
pieces =  { 'entire image, i.e. uncropped', ...
            'left half of the image', ...
            'right half of the image',  ...
            'top half of the image', ...
            'upper left quarter of the image', ...
            'upper right quarter of the image', ...
            'bottom half of the image', ...
            'bottom left quarter of the image', ...
            'bottom right quarter of the image'};   
piece_str = pieces{question_ind};
                    
% Correct answer can be the correct piece or "None of these"
incorrect_str = cell(4,1);
alt_pre = 'A possibly cropped image. This particular piece is the ';
if rand > chance_none 
    alt_str = [alt_pre pieces{question_ind} '.'];
    correct_str = ['<img src="/static/' base_name '_endcrop'...
        num2str(question_ind) file_ext '" alt="' alt_str '"/>'];
    for ii = 1:3
        alt_str = [alt_pre pieces{answer_ind(ii)} '.'];
        incorrect_str{ii} = ['<img src="/static/' base_name '_endcrop'...
            num2str(answer_ind(ii)) file_ext '" alt="' alt_str '"/>'];
    end
    incorrect_str{4} = 'None of these';

else
    correct_str = 'None of these';
    for ii = 1:4
        alt_str = [alt_pre pieces{answer_ind(ii)} '.'];
        incorrect_str{ii} = ['<img src="/static/' base_name '_grid3_crop'...
            num2str(answer_ind(ii)) file_ext '" alt="' alt_str '"/>'];
    end
    
end


    


