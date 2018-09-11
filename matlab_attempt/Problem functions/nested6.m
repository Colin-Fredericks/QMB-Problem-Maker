function [correct,incorrect,img_src,explanation] = nested6(array_name,chance_none)
% Function NESTED6 - QMB problem nested6
%
%   [correct,incorrect] = nested6(ind,chance_none)
%       Generates the answers for QMB problem nested6. 
%
%


% Lines that define the loop operation, e.g. x+y, x-y, etc.
lines = {'i', ...
         'j', ...
         '-i', ...
         '-j', ...
         'i + j', ...
         '-(i + j)', ...
         'i - j', ...
         '-(i - j)', ...
         'i * j', ...
         '-(i * j)'};

% Pick a line to be the right answer
choice = randi(length(lines),1);

alt_pre =  'An image visualization of a 10 x 10 array with blue colors representing low values and yellow colors representing high values.';

alt_str = {'Each row of pixels in the image is a single color, ranging from blue in the top row to yellow in the bottom row. A colorbar to the side of the image has the mapping from colors in the image to values in the array: 1=blue and 10=yellow.', ...
    'Each column of pixels in the image is a single color, ranging from blue in the left column to yellow in the right column. A colorbar to the side of the image has the mapping from colors in the image to values in the array: 1=blue and 10=yellow.', ...
    'Each row of pixels in the image is a single color, ranging from yellow in the top row to blue in the bottom row. A colorbar to the side of the image has the mapping from colors in the image to values in the array: -10=blue and -1=yellow.', ...
    'Each column of pixels in the image is a single color, ranging from yellow in the left column to blue in the right column. A colorbar to the side of the image has the mapping from colors in the image to values in the array: -10=blue and -1=yellow.', ...
    'The top-left pixel is blue and the bottom-right pixel is yellow. A colorbar to the side of the image has the mapping from colors in the image to values in the array: 2=blue and 20=yellow.', ...
    'The top-left pixel is yellow and the bottom-right pixel is blue. A colorbar to the side of the image has the mapping from colors in the image to values in the array: -20=blue and -2=yellow.', ...
    'The bottom-left pixel is yellow and the top-right pixel is blue. A colorbar to the side of the image has the mapping from colors in the image to values in the array: -9=blue and 9=yellow.', ...
    'The bottom-left pixel is blue and the top-right pixel is yellow. A colorbar to the side of the image has the mapping from colors in the image to values in the array: -9=blue and 9=yellow.', ...
    'The top-left pixel is blue and the bottom-right pixel is yellow. A colorbar to the side of the image has the mapping from colors in the image to values in the array: 1=blue and 100=yellow.', ...
    'The top-left pixel is yellow and the bottom-right pixel is blue. A colorbar to the side of the image has the mapping from colors in the image to values in the array: -100=blue and -1=yellow.'};


% Get the image code
fname = ['nested2_imagesc_func' num2str(choice) '.png'];
img_src = ['<a href="/static/' fname '" target="_blank"><img src="/static/' ...
    fname '" alt="' alt_pre ' ' alt_str{choice} '"/></a>'];

% Format for printing the for loop with sprintf
for_loop_fmt = '$$for i = 1:10\n     for j = 1:10\n          %s(i,j) = %s;\n     end\nend/$$';
right_choice = sprintf(for_loop_fmt,array_name,lines{choice});

% Make explanations for the answers
explanations = {['<p>Using the image and colormap, you can can infer that the first row of the array has the value $1/$, whereas the last row has the value $10/$. This is because the top row of the image is blue, which maps to the value $1/$, and the top row of the image corresponds to the first row of the array.</p><br/><p>This implies the assignment in the loop must only depend on the row variable $i/$, and the values must increase as $i/$ increases (otherwise, the first row would be yellow). Therefore, the correct way to create this array would be the code:</p><br/><p>' right_choice '</p>'], ...
    ['<p>Using the image and colormap, you can can infer that the first column of the array has the value $1/$, whereas the last column has the value $10/$. This is because the left column of the image is blue, which maps to the value $1/$, and the left column of the image corresponds to the first column of the array.</p><br/><p>This implies the assignment in the loop must only depend on the column variable $j/$, and the values must increase as $j/$ increases (otherwise, the first column would be yellow). Therefore, the correct way to create this array would be the code:</p><br/><p>' right_choice '</p>'], ...
    ['<p>Using the image and colormap, you can can infer that the first row of the array has the value $-1/$, whereas the last row has the value $-10/$. This is because the top row of the image is yellow, which maps to the value $-1/$, and the top row of the image corresponds to the first row of the array.</p><br/><p>This implies the assignment in the loop must only depend on the row variable $i/$, and the values must <em>decrease</em> as $i/$ increases (otherwise, the first row would be blue). Therefore, the correct way to create this array would be the code:</p><br/><p>' right_choice '</p>'], ...
    ['<p>Using the image and colormap, you can can infer that the first column of the array has the value $-11/$, whereas the last column has the value $-110/$. This is because the left column of the image is yellow, which maps to the value $-1/$, and the left column of the image corresponds to the first column of the array.</p><br/><p>This implies the assignment in the loop must only depend on the column variable $j/$, and the values must <em>decrease</em> as $j/$ increases (otherwise, the first column would be blue). Therefore, the correct way to create this array would be the code:</p><br/><p>' right_choice '</p>'], ...
    ['<p>Using the image and colormap, you can can infer that $XX(1,1) = 2/$ and $XX(10,10) = 20/$. This is because the top-left pixel is blue, which maps to the value $2/$, and the top-left pixel corresponds to the array value in $XX(1,1)/$.</p><br/><p>This implies the assignment into $XX/$ must increase as both $i/$ and $j/$ increase. Otherwise, you would not see this trend from blue in the top-left to yellow in the bottom-right. Therefore, the correct way to create this array would be the code:</p><br/><p>' right_choice '</p>'], ...
    ['<p>Using the image and colormap, you can can infer that $XX(1,1) = -2/$ and $XX(10,10) = -20/$. This is because the top-left pixel is yellow, which maps to the value $-2/$, and the top-left pixel corresponds to the array value in $XX(1,1)/$.</p><br/><p>This implies the assignment into $XX/$ must decrease as <em>both</em> $i/$ and $j/$ increase. Otherwise, you would not see this trend from yellow in the top-left to blue in the bottom-right. Therefore, the correct way to create this array would be the code:</p><br/><p>' right_choice '</p>'], ...
    ['<p>Using the image and colormap, you can can infer that $XX(10,1) = 9/$ and $XX(1,10) = -9/$. This is because the bottom-left pixel is yellow, which maps to the value $9/$, and the bottom-left pixel corresponds to the array value in $XX(10,1)/$.</p><br/><p>This implies the assignment into $XX/$ must increase as $i/$ increases but decrease as $j/$ increases. Otherwise, you would not see this trend from yellow in the bottom-left to blue in the top-right. Therefore, the correct way to create this array would be the code:</p><br/><p>' right_choice '</p>'], ...
    ['<p>Using the image and colormap, you can can infer that $XX(10,1) = -9/$ and $XX(1,10) = 9/$. This is because the bottom-left pixel is blue, which maps to the value $-9/$, and the bottom-left pixel corresponds to the array value in $XX(10,1)/$.</p><br/><p>This implies the assignment into $XX/$ must decrease as $i/$ increases but increase as $j/$ increases. Otherwise, you would not see this trend from blue in the bottom-left to yellow in the top-right. Therefore, the correct way to create this array would be the code:</p><br/><p>' right_choice '</p>'], ...
    ['<p>Using the image and colormap, you can can infer that $XX(1,1) = 1/$ and $XX(10,10) = 100/$. This is because the top-left pixel is blue, which maps to the value $1/$, and the top-left pixel corresponds to the array value in $XX(1,1)/$.</p><br/><p>This implies the assignment into $XX/$ must increase sharply as both $i/$ and $j/$ increase. Otherwise, you would not see this steep trend from blue in the top-left to yellow in the bottom-right. Therefore, the correct way to create this array would be the code:</p><br/><p>' right_choice '</p>'], ...
    ['<p>Using the image and colormap, you can can infer that $XX(1,1) = -1/$ and $XX(10,10) = -100/$. This is because the top-left pixel is yellow, which maps to the value $-1/$, and the top-left pixel corresponds to the array value in $XX(1,1)/$.</p><br/><p>This implies the assignment into $XX/$ must decrease sharply as both $i/$ and $j/$ increase. Otherwise, you would not see this steep trend from yellow in the top-left to blue in the bottom-right. Therefore, the correct way to create this array would be the code:</p><br/><p>' right_choice '</p>'], ...
    };

% Pick out the explanation
explanation = explanations{choice};
explanation = strrep(explanation,'XX',array_name);
    
% Determine if "None of these is the correct answer        
if rand < chance_none
    
    % Get the right answer
    correct = 'None of these';

    %Pick 3 wrong answers and "None of these"
    incorrect = {};
    other_choices = randsample([1:choice-1 choice+1:length(lines)],4);
    for ii = other_choices
        incorrect{end+1} = sprintf(for_loop_fmt,array_name,lines{ii});
    end
    
    %Add a bit to the explanation
    explanation = [explanation '<br/><p>Because this is not one of the available choices, the correct answer is "None of these".</p>'];
else
     
    correct = right_choice;
    
    % Pick 3 wrong answers
    incorrect{1} = 'None of these';
    other_choices = randsample([1:choice-1 choice+1:length(lines)],3);
    for ii = other_choices
        incorrect{end+1} = sprintf(for_loop_fmt,array_name,lines{ii});
    end
    
    
     
end