function [correct,incorrect,actual_output] = arr25_2(array,rows,cols,chance_none)
% Function ARR25_2 - generate info for QMB problem 25.2
%
%   [correct,incorrect] = arr25_2(array_size,array_vals,rows,cols,chance_none)
%


%Pick out pieces for display. First the correct answer
correct_piece = array(rows,cols);

%Incorrect answers. This are guaranteed to be incorrect by the way the
%problem is set up
%sorted_piece = array(sort(rows),sort(cols));
col_piece = collapse(array(rows,cols));
row_piece = col_piece';
short_piece1 = array(rows(1:end-1),cols);
short_piece2 = array(rows,cols(1:end-1));

%Make sure question knows actual output
actual_output = display(correct_piece);

%Pick answers
if rand > chance_none
   correct = display(correct_piece);
   incorrect{1} = 'None of these';
   incorrect{2} = display(col_piece);
   incorrect{3} = display(row_piece);
   incorrect{4} = display(short_piece2);
else
    correct = 'None of these';
    incorrect{1} = display(short_piece1);
    incorrect{2} = display(col_piece);
    incorrect{3} = display(row_piece);
    incorrect{4} = display(short_piece2);
end
end

%Function for creating the answer display strings
function str = display(mat)
    str = ['$$ans = ' ...
        sprintf(['\n\t' repmat(' %3d',1,size(mat,2))],mat') ' /$$'];
end