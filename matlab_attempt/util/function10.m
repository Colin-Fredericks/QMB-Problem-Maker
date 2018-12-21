function [answer,explanation] = function10(xORy,inORout,values)

% There are 2 environments we ask about and two variables
if strcmp(inORout,'in')
    if xORy == 'x'
        answer = values(2) + 1;            
    else
        answer = values(1);
    end
    explanation = sprintf('This pause location is inside the function after the operations have take place. Recall that the function was called from the code snippet with $myAdd(y,x)/$, i.e. $myAdd(%d,%d)/$. Once inside the function, $x = %d/$ and $y  = %d/$. The operations then take place, so $x = x + 1 = %d + 1 = %d/$ and $results = x + y = %d + %d = %d/$. Therefore, the new values are $x = %d/$ and $y = %d/$.', ...
            values(2),values(1), values(2), values(1),values(2),values(2)+1,values(2)+1,values(1),sum(values)+1,values(2)+1,values(1));
else    
    if xORy == 'x'
        answer = values(1);
    else
        answer = values(2);
    end
        explanation = sprintf('This pause location is inside the function after the operations have take place. However, because the function has a different scope, the values of $x/$ and $y/$ are potentially different outside of the function. In the external environment, $x/$ and $y/$ are still their original values because any operations that occurred inside the function do not affect them. Therefore, they are still $x = %d/$ and $y = %d/$.', ...
            values(1),values(2));
 end
            
            