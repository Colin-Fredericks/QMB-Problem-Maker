function [correct_answer,incorrect_answers,val_display] = ...
    arr20_2(array_name,array_vals,num,chance_none)
% function ARR20_2 - Answers for QMB problem arr20.2
%
%   [correct_answer,incorrect_answerss,display,ask_str] = ...
%           arr20_2(array_name,array_vals,chance_none)
%
%


%Flip a coin to see if row or column array
if rand < 0.5
   format = '%d ';
else
   format = '%d\n\t';
end

%Values for question display
val_display = vec_display(array_name,format,array_vals);

plus = vec_display('ans',format,array_vals + num);
first_plus = vec_display('ans',format,[array_vals(1)+num,array_vals(2:end)]);
append_single_num = vec_display('ans',format,[array_vals num]);
append_mult_num = vec_display('ans',format,[array_vals num+zeros(1,num)]);
append_zeros = vec_display('ans',format,[array_vals zeros(1,num)]);


%Decide if correct answer is present
if rand > chance_none
    incorrect_answers{4} = 'None of these';
    correct_answer = plus;
    incorrect_answers{1} = append_single_num;
    incorrect_answers{2} = append_zeros;
    incorrect_answers{3} = first_plus;
else
    correct_answer = 'None of these';
    incorrect_answers{1} = append_single_num;
    incorrect_answers{2} = append_zeros;
    incorrect_answers{3} = first_plus;
    incorrect_answers{4} = append_mult_num;
end

end

function disp_str = vec_display(name,formatSpec,vals)
%Function to display a vector of values
%
%   str = vec_display(name,formatSpec,vals) 
%
    disp_str = ['$$' name ' = ' char([10 10 9]) ...
        sprintf(formatSpec,vals) '/$$'];
end
    
        
 
