function [correct_answer,incorrect_answers,val_display,ask_display,operator_string] = ...
    arr20_1(array_name,array_vals,operator,num,chance_none)
% function ARR20_1 - Answers for QMB problem arr20.1
%
%   [correct_answer,incorrect_answerss,display,ask_str] = ...
%           arr20_1(array_name,array_vals,chance_none)
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
ask_display = [array_name ' ' operator ' ' num2str(num)];

plus = vec_display('ans',format,array_vals + num);
minus = vec_display('ans',format,array_vals - num);
times = vec_display('ans',format,array_vals * num);
append_num = vec_display('ans',format,[array_vals num]);
remove_num = vec_display('ans',format,array_vals(array_vals~=num));
divide = vec_display('ans',format,round(array_vals/num));


%Decide if correct answer is present
if rand > chance_none
    incorrect_answers{4} = 'None of these';
    if operator == '+'
        correct_answer = plus;
        incorrect_answers{1} = append_num;
        incorrect_answers{2} = times;
        incorrect_answers{3} = minus;
        operator_string = ['add ' num2str(num) ' to'];
    elseif operator == '-'
        correct_answer = minus;
        incorrect_answers{1} = remove_num;
        incorrect_answers{2} = plus;
        incorrect_answers{3} = times;
        operator_string = ['subtract ' num2str(num) ' from'];
    elseif operator == '*'
        correct_answer = times;
        incorrect_answers{1} = minus;
        incorrect_answers{2} = divide;
        incorrect_answers{3} = plus;
        operator_string = ['multiply ' num2str(num) ' to'];
    end
else
    correct_answer = 'None of these';
    if operator == '+'
        incorrect_answers{1} = append_num;
        incorrect_answers{2} = remove_num;
        incorrect_answers{3} = minus;
        incorrect_answers{4} = times;
        operator_string = ['add ' num2str(num) ' to'];
    elseif operator == '-'        
        incorrect_answers{1} = remove_num;
        incorrect_answers{2} = plus;
        incorrect_answers{3} = times;
        incorrect_answers{4} = divide;
        operator_string = ['subtract ' num2str(num) ' from'];
    elseif operator == '*'        
        incorrect_answers{1} = append_num;
        incorrect_answers{2} = divide;
        incorrect_answers{3} = minus;
        incorrect_answers{4} = plus;
        operator_string = ['multiply ' num2str(num) ' to'];
    end
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
    
        
 
