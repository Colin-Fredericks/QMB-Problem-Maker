function [answers,correctness,problem_values,explanation] = data24()
% function DATA224 - QMB problem data24
%
%   [correct,incorrect,problem_values,explanation] = data24()
%
%


% Pick array name
array_name = randsample('ABCDEFGHKLMNPQRTUVWXYZ',1);

%Pick a function
func_choices = {'min','max','mean','median','std','var'};
func_words = {'minimum','maximum','mean','median','standard deviation','variance'};
choice_ind = randi([1 6],1);
func_str = func_choices{choice_ind};
action_word = func_words{choice_ind};

%Pick a dimension
dim_choices = {'column','row'};
dim_ind = randi(2,1);
dim_word = dim_choices{dim_ind};

answers = {sprintf('$%s(%c)/$',func_str,array_name), ...
           sprintf('$%s(%s(%c))/$',func_str, func_str, array_name), ...
           sprintf('$%s(%c,1)/$',func_str,array_name), ...
           sprintf('$%s(%c,2)/$',func_str,array_name), ...
           sprintf('$%s(%c,0,1)/$',func_str,array_name), ...
           sprintf('$%s(%c,0,2)/$',func_str,array_name)};


% is_var (function is std or var, so the answers are different
is_var = choice_ind==5 | choice_ind==6;

      
%Determine correctness
if dim_ind==1
    if is_var
        correct_ind = [1 0 0 0 1 0];
        explanation = sprintf('Therefore, the correct answers here are %s and %s.',answers{1},answers{5});
        reference = answers{5};
    else
        correct_ind = [1 0 1 0 0 0];
        explanation = sprintf('Therefore, the correct answers here are %s and %s.',answers{1},answers{3});
        reference = answers{3};
    end
else
    if is_var
        correct_ind = [0 0 0 0 0 1];
        explanation = sprintf('Therefore, the only correct answer here is %s.',answers{6});
        reference = answers{6};
    else
        correct_ind = [0 0 0 1 0 0];
        explanation = sprintf('Therefore, the only correct answer here is %s.',answers{4});
        reference = answers{4};
    end
end
correctness = convert_logical(correct_ind);

%Problem values 
problem_values = {array_name,func_str,action_word,dim_word,reference,dim_ind};

%Explanation
if is_var
    explanation = [explanation, sprintf('</p><br/><p>The $%s/$ function requires 3 inputs to specify the dimension, since the 2nd input is a weighting option. Therefore, you can use either $%s(%c,[],%d)/$ or $%s(%c,0,%d)/$, since both $0/$ and $[]/$ will produce the same result. You could also type $%s(%c,1,%d)/$, but this will produce slightly different numbers.', ...
        func_str,func_str,array_name,dim_ind,func_str,array_name,dim_ind,func_str,array_name,dim_ind)];
end
if dim_ind==1
    explanation = [explanation, sprintf('</p><br/><p>Also, the default behavior for $%s(%c)/$ without the additional input is to take %s of each %s. Therefore, $%s(%c)/$ is also an acceptable answer, but the more explicit %s is often better for code readability.', ...
        func_str,array_name,action_word,dim_word,func_str,array_name,reference)];
end

    
       
