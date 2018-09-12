function [correct,incorrect,solution_string] = arr7_3_2(name,pixel,color)
% function ARR7_3_2 - Function for QMB problem arry7.3.2
%
% [correct,incorrect,solution_str] = arr7_3_2(image_size,pixel, chance_none)
%       

fmt = '$%s(%d,%d,%d)/$';

color_ind = [strcmp({'red','green','blue'},color) false(1,3)];

  
answers = {sprintf(fmt,name,pixel,1), ...
           sprintf(fmt,name,pixel,2), ...
           sprintf(fmt,name,pixel,3), ...
           sprintf(fmt,name,pixel([2 1]),1), ...
           sprintf(fmt,name,pixel([2 1]),2), ...
           sprintf(fmt,name,pixel([2 1]),3)};
       
       
correct = answers{color_ind};
incorrect = answers(~color_ind);
solution_string = sprintf('Since you are looking for a pixel intensity in the %s channel, the command must have the number $%d/$ in the third dimension spot (remember, red is the 1st channel, green is the 2nd channel, and blue is the 3rd channel). The numbers in the first two dimensions will be the row and column index. Therefore, the correct command is %s',color,find(color_ind),correct);

