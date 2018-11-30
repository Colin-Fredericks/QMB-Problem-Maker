function [right,wrong,problem_values,explanation] = if_else8()
% if_else5
%
% [answers,correctness,explanation] = if_else8()

%Pick problem values
name = randsample('ABCDEFGHKMNPQRTUVWXYZ',1);
values = randsample(100,2);
symbols = {'<','>','<=','>=','==','~='};
phrases = {'less than','greater than','less than or equal to', ...
    'greater than or equal to','equal to','not equal to'};
choice_ind = randi(length(symbols),1);
symbol = symbols{choice_ind};
phrase = phrases{choice_ind};
other_ind = randsample([1:choice_ind-1 choice_ind+1:length(symbols)],1);
other_symbol = symbols{other_ind};
other_phrase = phrases{other_ind};


problem_values = {name,values(1),values(2),symbol,phrase};

right = sprintf([...
    '$$for i = 1:length(%s)\n'  ...
    '     if %s(i) %s %d\n' ...
    '          %s(i) = %d;\n' ...
    '     end\n' ...
    'end/$$'],name,name,symbol,values(1),name,values(2));

wrong{1} = sprintf([...
    '$$for i = 1:length(%s)\n'  ...
    '     if %s(i) %s %d\n' ...
    '          %s(i) = %d;\n' ...
    '     end\n' ...
    'end/$$'],name,name,symbol,values(2),name,values(1));
wrong{2} = sprintf([...
    '$$for i = 1:length(%s)\n'  ...
    '     if %s(i) %s %d\n' ...
    '          %s(i) = %d;\n' ...
    '     end\n' ...
    'end/$$'],name,name,other_symbol,values(1),name,values(2));
wrong{3} = sprintf([...
    '$$for i = %s\n'  ...
    '     if i %s %d\n' ...
    '          i = %d;\n' ...
    '     end\n' ...
    'end/$$'],name,symbol,values(1),values(2));
wrong{4} = 'None of these';


wrong_explain{1} = sprintf('This code switches the values of $%d/$ and $%d/$',values(1),values(2));
wrong_explain{2} = sprintf('This code uses the wrong comparator $%s/$ instead of $%s/$',other_symbol,symbol);
wrong_explain{3} = sprintf('This code will replace the value of $i/$ inside the loop with the correct value, but it won''t store the value back into $%s/$. Remember that the loop variable $i/$ is static.',name);

explanation = [];
for ii = 1:3
    explanation = [explanation '<li>' wrong{ii} '<br/> ' ...
        wrong_explain{ii} '</li>'];
end

   