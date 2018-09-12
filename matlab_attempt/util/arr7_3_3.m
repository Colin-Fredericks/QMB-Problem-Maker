function [correct,incorrect,image,solution_str] = arr7_3_3(chance_none)
% ARR7_3_3 - QMB problem 7.3.3
%
% [correct,incorrect,image,solution_string] = arr7_3_3(chance_none)
%
%


%Assemble the array, a 2x2 image with each pixel is randomly red, green, or
%blue
color_ind = randi(3,4,1);
rgb_triplets = [1 0 0;0 1 0;0 0 1]*255;
image =reshape(rgb_triplets(color_ind,:),[2 2 3]);

%Assemble the choices so we know which image to show
num_pixels = 4;
choices = zeros(num_pixels,3^num_pixels);
for ii = 1:3^num_pixels
    [p1,p2,p3,p4] = ind2sub(repmat(3,1,num_pixels),ii);
    choices(:,ii)  = [p1;p2;p3;p4];
end


% Pick the right and some wrong answers
right_choice = ismember(choices',color_ind','rows');
wrong_choices = randsample([1:find(right_choice)-1 find(right_choice)+1:size(choices,2)],4);

%Format for the alt text
colors = {'red';'green';'blue'};
alt_format = 'A 2 x 2 pixel color image with color (starting top left and going clockwise): %s, %s, %s, and %s'; 


%Assemble answers
if rand > chance_none
    
    %Correct answer is present 
    correct_alt_text = sprintf(alt_format, ...
        colors{color_ind(1)},colors{color_ind(3)}, ...
        colors{color_ind(4)},colors{color_ind(2)});
    correct = sprintf('<img src="/static/gray_4pixel_color_%d.jpg" alt="%s"/>', ...
        find(right_choice),correct_alt_text); 
    
    %Pick three of the wrong answers
    for ii = 1:3
        wrong_ind = choices(:,wrong_choices(ii));
        alt_text = sprintf(alt_format, ...
            colors{wrong_ind(1)},colors{wrong_ind(3)}, ...
            colors{wrong_ind(4)},colors{wrong_ind(2)});
        incorrect{ii} = sprintf('<img src="/static/gray_4pixel_color_%d.jpg" alt="%s"/>', ...
            wrong_choices(ii),alt_text);
    end
    
    %The last wrong answer is none of the above
    incorrect{4} = 'None of these';
    
    %Format to print solution string
    solution_fmt = '<p>To determine the color of a pixel, you need to find which channel has the value $255/$. For example, at some pixel in row $i/$, column $j/$, if $myImage(i,j,1) = 0/$, $myImage(i,j,2) = 0/$, and $myImage(i,j,3) = 255/$, then the pixel will be blue since the last "sheet" (the blue channel) has the value $255/$.</p><p>The values in your given array indicate that the pixel colors should be (starting top left and going clockwise): %s, %s, %s, and %s. Therefore, the correct answer is:</p><p>%s</p>';
    
else
    
    %Correct answer is none of the above
    correct = 'None of these';
    
    %Use all four wrong answers
    for ii = 1:4
        wrong_ind = choices(:,wrong_choices(ii));
        alt_text = sprintf(alt_format, ...
            colors{wrong_ind(1)},colors{wrong_ind(3)}, ...
            colors{wrong_ind(4)},colors{wrong_ind(2)});
        incorrect{ii} = sprintf('<img src="/static/gray_4pixel_color_%d.jpg" alt="%s"/>', ...
            wrong_choices(ii),alt_text);
    end
    
    %Format to print solution string
    solution_fmt = '<p>To determine the color of a pixel, you need to find which channel has the value $255/$. For example, at some pixel in row $i/$, column $j/$, if $myImage(i,j,1) = 0/$, $myImage(i,j,2) = 0/$, and $myImage(i,j,3) = 255/$, then the pixel will be blue since the last "sheet" (the blue channel) has the value $255/$.</p><p>The values in your given array indicate that the pixel colors should be (starting top left and going clockwise): %s, %s, %s, and %s. This image is not one of the choices. Therefore, the correct answer is:</p><p>%s</p>';
end

%Solution string
solution_str = sprintf(solution_fmt, ...
    colors{color_ind(1)},colors{color_ind(3)}, ...
    colors{color_ind(4)},colors{color_ind(2)}, correct);
