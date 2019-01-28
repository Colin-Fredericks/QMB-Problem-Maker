function [correct,incorrect,problem_values,explanation] = struct21()
% function struct21 - Generate answers for QMB problem struct21
%
%   [correct,incorrect,problem_values,explanation] = struct21()
%

% Chance of answer being 'None of these'
chance_none = 0.2;

% Possible variable names
string_fields = {'firstName','lastName','eyeColor','hairColor','city'};
num_fields = {'height','age','ID','weight','number'};
struct_list = {'S','myStruct','myStructure','data','myData','myArray','myInfo','info'};

%Pick a field name
is_string = rand>0.5;
if is_string
    field_name = string_fields{randi(length(string_fields),1)};
else
    field_name = num_fields{randi(length(num_fields),1)};
end

%Pick a struct name
struct_name = struct_list{randi(length(struct_list),1)};


% Correct answer
if is_string
    right_answer = sprintf('${%s.%s}/$',struct_name,field_name);
    wrong_answer = sprintf('$[%s.%s]/$',struct_name,field_name);
else
    right_answer = sprintf('$[%s.%s]/$',struct_name,field_name);
    wrong_answer = sprintf('${%s.%s}/$',struct_name,field_name);    
end
    
% Possible choices for wrong answers
other_answers = {sprintf('$(%s.%s)/$',struct_name,field_name), ...
                 sprintf('$[%s.%s]/$',field_name,struct_name), ...
                 sprintf('${%s.%s}/$',field_name,struct_name), ...
                 sprintf('$(%s.%s)/$',field_name,struct_name), ...
                 sprintf('$%s.%s/$',struct_name,field_name), ...
                 sprintf('$%s.%s/$',field_name,struct_name), ...                 
                 sprintf('$%s(:).%s/$',struct_name,field_name), ...
                 sprintf('$%s(:).%s/$',field_name,struct_name), ...                
                 sprintf('$%s(1:end).%s/$',struct_name,field_name), ...
                 sprintf('$%s(1:end).%s/$',field_name,struct_name)  };
                 
% Decide if correct answer is present. Always make sure wrong_answer is one of the choices            
if rand>chance_none
     correct = right_answer;     
     incorrect = randsample(other_answers,2);
     incorrect{3} = wrong_answer;
     incorrect{4} = 'None of these';
     explanation = '';
     
else
    correct = 'None of these';
    incorrect = randsample(other_answers,3);
    incorrect{4} = wrong_answer;
    explanation = '<br/><p>However, this statement is not one of the above choices. Therefore, the correct answer is "None of these".</p>';
end
 
 
% Problem values
problem_values = {struct_name,field_name,is_string,right_answer}; 