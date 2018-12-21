function [answer,code_str,num_plots,first_hold,explain] = data8()
% function DATA7 - QMB problem data7
%
%   [answer,code_str,num_plots,hold_lines] = data8()
%
%


num_plots = randi([5 10]);
hold_lines(1) = randi([2 num_plots-3],1);
hold_lines(2) = randi([num_plots-1 num_plots],1);

code_str = ['figure()' newline];
for ii = 1:num_plots
    code_str = [code_str sprintf('plot(myData(%d,:))\n',ii)];
    if ii == hold_lines(1)
        code_str = [code_str sprintf('hold on\n')];
    end
    if ii == hold_lines(2)
        code_str = [code_str sprintf('hold off\n')];
    end
end


if hold_lines(2) == num_plots-1
    answer = 1;
    explain = 'However, there is a $hold off/$ before the last $plot/$ command, meaning when this command executes, a new set of axes will be created and only the last line will be plotted. All the previous lines will be removed.';
else
    answer = num_plots - hold_lines(1) + 1;    
    explain = sprintf('The final line has a $hold off/$, which will revert Matlab to the default plotting behavior. There will still be %d lines in the plot, but any additional $plot/$ commands will reset the axes.',answer);
end
first_hold = hold_lines(1);
