function [answer,location,file_name,shades,shade] = arr7_4(grays,choices,shades,locations)
% function ARR7_1 - Function for QMB problem arry7.1
%
% [correct,incorrect,fname,shades] = arr7_4(grays,choices,shades)
%       grays: List of values to be used in array answers (grayscale values)
%       choices: array of indices to be used in array
%       chades: cell array of strings used for image alt-text   
%


%Pick an image
choice_ind = randsample(size(choices,1),1);
file_name = ['gray_4pixel' num2str(choice_ind), '_with_colorbar.jpg'];

%Pick a pixel to ask about
ask_ind = randi(4,1);
location = locations{ask_ind};

%Get the answer by sorting the grays
answer = grays(choices(choice_ind,ask_ind));
shade = shades(choices(choice_ind,ask_ind));

%Shades are used for alt-text on image. Rearrange according to chosen image
%shades = {'black','dark gray','light gray','white'};
shades = shades(choices(choice_ind,:));
