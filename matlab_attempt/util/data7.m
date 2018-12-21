function [answer,code_str,num_plots] = data7()
% function DATA7 - QMB problem data7
%
%   [answer,code_str] = data7()
%
%


num_plots = randi([5 10]);
hold_line = randi([2 num_plots-2]);

code_str = ['figure()' newline];
for ii = 1:num_plots
    code_str = [code_str sprintf('plot(myData(%d,:))\n',ii)];
    if ii == hold_line
        code_str = [code_str sprintf('hold on\n')];
    end
end
answer = num_plots - hold_line + 1;