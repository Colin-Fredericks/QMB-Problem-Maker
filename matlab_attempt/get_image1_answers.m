function [correct_str,incorrect_str,row_str,col_str] = get_image1_answers(fname,row_choices,col_choices)
%Function GET_IMAGE1_ANSWERS: Creates answers for QMB problem 'image1'
%
%   [CORRECT,WRONG,ROW_STR,COL_STR] = get_image1_answers(FNAME,ROWS,COLS) 
%   creates the answers for the multiple choice problem 'image1'. FNAME is
%   the name of the base image, e.g. 'clock.jpg'. ROWS and COLS are cell 
%   arrays of strings containing the choices of indices of the cropped 
%   e.g. ROWS should be{'1:150','151:300'} if the images is 300 pixels high
%   and has been cropped into two pieces.
%
%   CORRECT is a string with the html tag that will show the correct image,
%   e.g. <img src="clock_cropped2.jpg">. 25% of the time, the correct
%   answer will be 'None of these'
%
%   WRONG is a cell array of strings with the other four answers, either
%   <img> tags or 'None of these'
%
%   ROW_STR and COL_STR are the strings with the indices asked about in the 
%   question text, e.g. if ROW_STR = '1:150' and COL_STR = '1:120', the
%   question asked will be: 'What is im(1:150,1:120)'


% Get nam for image, e.g. 'clock' or 'flower'
[~,base_name,file_ext] = fileparts(fname);

%Make sure its a square grid
if length(row_choices)~=length(col_choices)
    error('Image must be cropped into square grid!');
end
num_crop = length(row_choices);

%Generate possible choices of grid, e.g. (1,4) or (2,3)
choices = [collapse(repmat(1:num_crop,num_crop,1)) ...
           collapse(repmat((1:num_crop)',1,num_crop))];

%Pick one to be the question choice       
question_choice = randi(num_crop,1,2);
question_ind = find(question_choice(1)==choices(:,1) & ...
                    question_choice(2)==choices(:,2));
row_str = row_choices{question_choice(1)};
col_str = col_choices{question_choice(2)};

%Now generate the answers. First, pick 4 random choices
answer_ind = randsample([1:question_ind-1  ...
                        question_ind+1:size(choices,1)]',4);
                    
% 75% of the time, the correct cropped image will be one of the choices
incorrect_str = cell(4,1);
if rand<0.75 
    correct_str = ['<img src="/static/' base_name '_cropped'...
        num2str(question_ind) file_ext '" alt=""/>'];
    for ii = 1:3
        incorrect_str{ii} = ['<img src="/static/' base_name '_cropped'...
            num2str(answer_ind(ii)) file_ext '" alt=""/>'];
    end
    incorrect_str{4} = 'None of these';

else
    correct_str = 'None of these';
    for ii = 1:4
        incorrect_str{ii} = ['<img src="/static/' base_name '_cropped'...
            num2str(answer_ind(ii)) file_ext '" alt=""/>'];
    end
    
end
