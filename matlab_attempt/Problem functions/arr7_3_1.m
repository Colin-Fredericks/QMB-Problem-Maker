function [correctness,array,solution_string] = arr7_3_1(image_size,pixel,chance_none)
% function ARR7_3_1 - Function for QMB problem arry7.3.1
%
% [correct,incorrect,array,solution_str] = arr7_3_1(image_size,chance_none)
%       image_size: Size of square image in pixels
%       chance_none: Chance the answer is 'None of these'
%

%Generate random array
array = randi([0 1],image_size,image_size,3)*255;

colors = {'red','green','blue','None of these'};

% Choose if correct answer is present or not
if rand < chance_none
    
    %4th choice 'None of these' is correct
    correctness = convert_logical([0 0 0 1]);
    
    %Multiple display possibilities for wrong answers
    %   1. all high 
    %   2. all low 
    %   3. Two high, one low
    choice = randi(3,1);
    if choice == 1
        array(pixel(1),pixel(2),:) = 255;
        solution_string = sprintf('Since $myImage(%d,%d,1) = 255/$, $myImage(%d,%d,2) = 255/$, and $myImage(%d,%d,3) = 255/$, the RGB values for this pixel are all $255/$. This pixel will be white.',[pixel pixel pixel]);
    elseif choice == 2
        array(pixel(1),pixel(2),:) = 0;        
        solution_string = sprintf('Since $myImage(%d,%d,1) = 0/$, $myImage(%d,%d,2) = 0/$, and $myImage(%d,%d,3) = 0/$, the RGB values for this pixel are all $0/$. This pixel will be black.',[pixel pixel pixel]);
    elseif choice == 3
        values = [255 255 0];
        values = values(randperm(3));
        array(pixel(1),pixel(2),:) = cat(3,values(1),values(2),values(3));
        solution_string = ['Since two of the arrays have high values the color will not be red, blue, or green. It will be some other color, e.g. cyan, yellow, or magenta.'];
    end
    
else
    values = [255 0 0];
    values = values(randperm(3));
    array(pixel(1),pixel(2),:) = cat(3,values(1),values(2),values(3));
    
    correctness = convert_logical([0 0 0 0]);
    answer_ind = find(values>0);
    correctness{answer_ind} = 'TRUE';
    color = colors{answer_ind};
  
    solution_string = sprintf('Since $myImage(%d,%d,1) = %d/$, $myImage(%d,%d,2) = %d/$, and $myImage(%d,%d,3) = %d/$, the %s value is $255/$ and the others are $0/$. Therefore, this pixel will be %s.',pixel,values(1),pixel,values(2),pixel,values(3),color,color); 
end


