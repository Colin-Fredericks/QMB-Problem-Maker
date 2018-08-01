function [correct_answer,incorrect_answers,im_display,img_HTML,output_gray_values] = arr7_6(chance_none)
% function ARR7_1 - Function for QMB problem arry7.2
%
% [correct,incorrect,array_str,img_HTML,gray_values] = arr7_6(chance_none)
%       chance_none: chance for "None of these" to be the correct answer
%       
%       correct = string with correct answer
%       incorrect = cell array of strings with wrong answers
%       array_str = string used to display array values
%       img_HTML = string for displaying the image
%       gray_values = 1x2 array with max and min values of array
%

%Grid for images
im_size = 10;
x = linspace(-1,1,im_size);
y = x;
[Y,X] = meshgrid(y,x);

%Possible shapes 3D functions
func_handles{1} = @(X,Y) X-Y;
func_handles{2} = @(X,Y) X.^2-Y.^2;
func_handles{3} = @(X,Y) X.^2-Y;
func_handles{4} = @(X,Y) sqrt(X.^2 + Y.^2);

%Pick a function. This will be the image displayed to the user
func_ind = randi(4,1);

%Alt text strings. One for each image
alt_base = 'A 10 x 10 pixel grayscale image with white values near '; 
alt_strs = {[alt_base 'the bottom left corner and black values near the top right corner'], ...
            [alt_base 'the top and bottom edges and black values near the left and right edges'], ...
            [alt_base 'the top left and bottom left corners and black values near the right edge'], ...
            [alt_base 'near the corners and black values near the center']};

% HTML for image
img_HTML = sprintf('<img src="/static/gray_shape%d.jpg" alt="%s"/>',func_ind,alt_strs{func_ind});

%Pick a range for array values
gray_pairings = nchoosek(0:50:250,2);


%Pick 5 choices. First choice will always the array displayed
choice_ind = randsample(size(gray_pairings,1),5);

%Create array that is scaled between the chosen gray pairing values
im = func_handles{func_ind}(X,Y);
im = (im - min(im(:))) / (max(im(:)) - min(im(:)));
im = round(im*diff(gray_pairings(choice_ind(1),:)) + gray_pairings(choice_ind(1),1));

%Make array display
im_display = mimic_array_output(im,'myImage');

%Create answers
choice_strings = cell(5,1);
alt_str_pre = 'A colorbar showing gradual shades from black to white. ';
               
%Get image display strings for each image
for ii = 1:5    
    gray_values = gray_pairings(choice_ind(ii),:);
    alt_str = [alt_str_pre sprintf('The values range from black = %d to white = %d',gray_values)];    
    file_name = sprintf('gray_colorbar%d.jpg',choice_ind(ii));
    choice_strings{ii} = sprintf('<img src ="/static/%s" alt="%s"/>',file_name,alt_str);
end

%Now set up answers
if rand<chance_none
    correct_answer = 'None of these';
    incorrect_answers = choice_strings(2:5);
else
    correct_answer = choice_strings{1};
    incorrect_answers = choice_strings(2:4);
    incorrect_answers{4} = 'None of these';    
end

output_gray_values = gray_pairings(choice_ind(1),:);