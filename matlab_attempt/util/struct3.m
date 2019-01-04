function [correct,incorrect,problem_values,explanation] = struct3()
% function STRUCT3 - Generate answers for QMB problem struct3
%
%   [correct,incorrect,problem_values,explanation] = struct3()
%

% Chance of answer being 'None of these'
chance_none = 0.2;

% Choose a struct and field name
struct_name = randsample({'S','S1','myStruct','myStructure','myStruct1', ...
    'myS','s','my_struct','my_structure1','my_struct1','s1'},1);
struct_name = struct_name{1};
field_name = randsample({'field1','field2','newField','age','height', ...
    'variable1','mass','var1','field3','val1'},1);
field_name = field_name{1};

% Random integer to save
value = randi(100,1);

% Correct answer
right_answer = sprintf('$%s.%s = %d/$',struct_name,field_name,value);

% Possible choices for wrong answers
wrong_answers = {sprintf('$%s[%d] = ''%s''/$',struct_name,value,field_name), ...
                 sprintf('$%s[''%s''] = %d/$',struct_name,field_name,value), ...
                 sprintf('$%s = %d/$',field_name,value), ...
                 sprintf('$%s = %d/$',struct_name,value), ...
                 sprintf('$%s.%s = %d/$',field_name,struct_name,value), ...
                 sprintf('$%s(''%s'') = %d/$',struct_name,field_name,value), ...
                 sprintf('$%s(1) = %d/$',struct_name,value), ...
                 sprintf('$%s{''%s''} = %d/$',struct_name,field_name,value), ...
                 sprintf('$%s(%d) = ''%s''/$',struct_name,value,field_name), ...
                 sprintf('$%s{%d} = ''%s''/$',struct_name,value,field_name), ...
                 sprintf('$%s.(%s) = %d/$',struct_name,field_name,value), ...
                 sprintf('$%s.''%s'' = %d/$',struct_name,field_name,value)};
   
% Decide if correct answer is present            
if rand>chance_none
     correct = right_answer;     
     incorrect = randsample(wrong_answers,3);
     incorrect{4} = 'None of these';
     explanation = '';
     
else
    correct = 'None of these';
    incorrect = randsample(wrong_answers,4);
    explanation = '<br/><p>However, this statement is not one of the above choices. Therefore, the correct answer is "None of these".</p>';
end
 
 
% Problem values
problem_values = {struct_name,field_name,value,right_answer}; 