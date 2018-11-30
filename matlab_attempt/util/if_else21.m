%% if_else5
function [answers,correctness,explanation] = if_else21()

% Possible correct answers
right{1} = sprintf([...
    '$$y = x; %%Make a copy of x\n' ...
    'for i = 1:length(x)\n'  ...
    '     if x(i) == 0\n' ...
    '          y(i) = 0;\n' ...
    '     elseif x(i) < 0\n' ...
    '          y(i) = -1;\n' ...
    '     else\n' ...
    '          y(i) = 1;\n' ...
    '     end\n' ...
    'end/$$']);
right{2} = sprintf([...
    '$$y = x; %%Make a copy of x\n' ...
    'for i = 1:length(x)\n'  ...
    '     if x(i) < 0\n' ...
    '          y(i) = -1;\n' ...
    '     elseif x(i) > 0\n' ...
    '          y(i) = 1;\n' ...
    '     else\n' ...
    '          y(i) = 0;\n' ...
    '     end\n' ...
    'end/$$']);
right{3} = sprintf([...
    '$$y = x; %%Make a copy of x\n' ...
    'for i = 1:length(x)\n'  ...
    '     if x(i) > 0\n' ...
    '          y(i) = 1;\n' ...
    '     elseif x(i) < 0\n' ...
    '          y(i) = -1;\n' ...
    '     else\n' ...
    '          y(i) = 0;\n' ...
    '     end\n' ...
    'end/$$']);
right{4} = sprintf([...
    '$$y = x; %%Make a copy of x\n' ...
    'for i = 1:length(x)\n'  ...
    '     if x(i) > 0\n' ...
    '          y(i) = 1;\n' ...
    '     elseif x(i) < 0\n' ...
    '          y(i) = -1;\n' ...
    '     end\n' ...
    'end/$$']);
right{5} = sprintf([...
    '$$y = x; %%Make a copy of x\n' ...
    'for i = 1:length(x)\n'  ...
    '     if x(i) == 0\n' ...
    '          y(i) = 0;\n' ...
    '     elseif x(i) > 0\n' ...
    '          y(i) = 1;\n' ...
    '     else\n' ...
    '          y(i) = -1;\n' ...
    '     end\n' ...
    'end/$$']);

    
% Explanations for correct answers
right_explain{1} = 'Yes. Zero values are set to $0/$, negative values are set to $-1/$, and the $else/$ keyword means the remaining positive values are set to $1/$.';
right_explain{2} = 'Yes. Negative values are set to $-1/$, positive values are set to $1/$, and the $else/$ keyword means the remaining zero values are set to $0/$.';
right_explain{3} = 'Yes. Positive values are set to $1/$, negative values are set to $-1/$, and the $else/$ keyword means the remaining zero values are set to $0/$.';
right_explain{4} = 'Yes. Positive values are set to $1/$ and negative values are set to $-1/$. This snippet has no $else/$ statement, but it is actually not needed since the zero values in $y/$ do not need to be changed.';
right_explain{5} = 'Yes. Zero values are set to $0/$, positive values are set to $1/$, and the $else/$ keyword means the remaining negative values are set to $-1/$.';

% Wrong answers
wrong{1} = sprintf([...
    '$$y = x; %%Make a copy of x\n' ...
    'for i = 1:length(x)\n'  ...
    '     if x(i) > 0\n' ...
    '          y(i) = 1;\n' ...
    '     else\n' ...
    '          y(i) = -1;\n' ...
    '     end\n' ...
    'end/$$']);
wrong{2} = sprintf([...
    '$$y = x; %%Make a copy of x\n' ...
    'for i = 1:length(x)\n'  ...
    '     if x(i) < 0\n' ...
    '          y(i) = -1;\n' ...
    '     else\n' ...
    '          y(i) = 1;\n' ...
    '     end\n' ...
    'end/$$']);
wrong{3} = sprintf([...
    '$$y = x; %%Make a copy of x\n' ...
    'for i = 1:length(x)\n'  ...
    '     if x(i) == 0\n' ...
    '          y(i) = 0;\n' ...
    '     else\n' ...
    '          y(i) = 1;\n' ...
    '     end\n' ...
    'end/$$']);
wrong{4} = sprintf([...
    '$$y = x; %%Make a copy of x\n' ...
    'for i = 1:length(x)\n'  ...
    '     if x(i) > 0\n' ...
    '          y(i) = -1;\n' ...
    '     elseif x(i) < 0\n' ...
    '          y(i) = 1;\n' ...
    '     end\n' ...
    'end/$$']);
wrong{5} = sprintf([...
    '$$y = x; %%Make a copy of x\n' ...
    'for i = 1:length(x)\n'  ...
    '     if x(i) < 0\n' ...
    '          y(i) = 1;\n' ...
    '     elseif x(i) > 0\n' ...
    '          y(i) = -1;\n' ...
    '     end\n' ...
    'end/$$']);
wrong{6} = sprintf([...
    '$$y = x; %%Make a copy of x\n' ...
    'for i = 1:length(x)\n'  ...
    '     if x(i) == 0\n' ...
    '          y(i) = 0;\n' ...
    '     elseif x(i) > 0\n' ...
    '          y(i) = -1;\n' ...
    '     else\n' ...
    '          y(i) = 1;\n' ...
    '     end\n'  ...
    'end/$$']);
wrong{7} = sprintf([...
    '$$y = x; %%Make a copy of x\n' ...
    'for i = 1:length(x)\n'  ...
    '     if x(i) == 0\n' ...
    '          y(i) = 0;\n' ...
    '     elseif x(i) < 0\n' ...
    '          y(i) = 1;\n' ...
    '     else\n'  ...
    '          y(i) = -1;\n' ...
    '     end\n'  ...
    'end/$$']);
wrong{8} = sprintf([...
    '$$y = x; %%Make a copy of x\n' ...
    'for i = 1:length(x)\n'  ...
    '     if x(i) < 0\n' ...
    '          y(i) = -1;\n' ...
    '     elseif x(i) > 0\n' ...
    '          y(i) = 0;\n' ...
    '     else\n'  ...
    '          y(i) = 1;\n' ...
    '     end\n'  ...
    'end/$$']);



% Explanations for wrong problems
wrong_explain{1} = 'No. Positve values will be correctly set to $1/$, but the $else/$ keyword means this code will replace negative AND zero values with $-1/$. The zero values should stay $0/$.';
wrong_explain{2} = 'No. Negative values will be correctly set to $-1/$, but the $else/$ keyword means this code will replace positive AND zero values with $1/$. The zero values should stay $0/$.';
wrong_explain{3} = 'No. This will keep zero values as $0/$ but will replace all negative and positive values with $1/$.';
wrong_explain{4} = 'No. This will set postive values to $-1/$ and negative values to $1/$, i.e. the reverse of the correct answer.';
wrong_explain{5} = 'No. This will set postive values to $-1/$ and negative values to $1/$, i.e. the reverse of the correct answer.';
wrong_explain{6} = 'No. This will set postive values to $-1/$ and negative values to $1/$, i.e. the reverse of the correct answer.';
wrong_explain{7} = 'No. This will set postive values to $-1/$ and negative values to $1/$, i.e. the reverse of the correct answer.';
wrong_explain{8} = 'No. This set negative values to $-1/$, but positive values to $0/$ and zero values to $1/$.';


% Pick 1-3 correct answers
iRight = randsample(length(right),randi([1 3],1));
answers = right(iRight);
explanation = [];
for ii = iRight'
    explanation = [explanation '<li>' right{ii} '<br/> ' ...
        right_explain{ii} '</li>'];
end

%Add incorrect answers to make 5 answers
iWrong = randsample(length(wrong), 5-length(iRight));
answers = [answers wrong(iWrong)];
for ii = iWrong'
    explanation = [explanation '<li>' wrong{ii} '<br/> ' ...
        wrong_explain{ii} '</li>'];
end
   
%Assemble correctness
correctness = convert_logical([true(1,length(iRight)) false(1,length(answers)-length(iRight))]);
