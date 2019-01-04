function [correct,incorrect,problem_values,explanation] = struct4()
% function struct4 - Generate answers for QMB problem struct4
%
%   [correct,incorrect,problem_values,explanation] = struct4()
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

% Correct answer
right_answer = sprintf('$%s.%s/$',struct_name,field_name);

% Possible choices for wrong answers
wrong_answers = {sprintf('$%s(%s)/$',struct_name,field_name), ...
                 sprintf('$%s(''%s'')/$',struct_name,field_name), ...
                 sprintf('$%s[''%s'']/$',struct_name,field_name), ...
                 sprintf('$%s{''%s''}/$',struct_name,field_name), ...
                 sprintf('$%s.(%s)/$',struct_name,field_name), ...                 
                 sprintf('$%s.%s/$',field_name,struct_name), ...
                 sprintf('$%s.''%s''/$',struct_name,field_name), ...
                 sprintf('$%s{%s}/$',struct_name,field_name), ...                 
                 sprintf('$return(''%s'',''%s'')/$',struct_name,field_name), ...
                 sprintf('$extract(''%s'',''%s'')/$',struct_name,field_name) };
                 
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
problem_values = {struct_name,field_name,right_answer}; 