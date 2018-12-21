function [answer,explanation] = function9(xORy,location,values)

% There are 4 locations we can pause at, and we can ask for x or y at each
% point
switch location
    case 1
        if xORy == 'x'
            answer = values(2);            
        else
            answer = values(1);
        end
        explanation = sprintf('This location is inside the function but before any operations have occurred. The order of the values in the function definition is $myAdd(x,y)/$, but this was called in a the code snippet with $myAdd(y,x)/$, i.e. $myAdd(%d,%d)/$. The values of $y/$ and $x/$ are therefore switched from the initial assignnment, so at this point, $x = %d/$ and $y = %d/$', ...
                values(2),values(1),values(2),values(1));
    case 2
        if xORy == 'x'
            answer = values(2) + 1;
        else
            answer = sum(values) + 1;
        end
        explanation = sprintf('This location is inside the function after the operations have take place. Recall that the function was called from the code snippet with $myAdd(y,x) = myAdd(%d,%d)/$. Once inside the function, $x = %d/$ and $y  = %d/$. The operations then take place, so $x = x + 1 = %d + 1 = %d/$ and $y = x + y = %d + %d = %d/$. Therefore, the new values are $x = %d/$ and $y = %d/$.', ...
            values(2),values(1), values(2), values(1),values(2),values(2)+1,values(2)+1,values(1),sum(values)+1,values(2)+1,sum(values)+1);
    case 3
        if xORy == 'x'
            answer = values(1);
       else
            answer = values(2);
        end
        explanation = sprintf('This location is in the code snippet after the values of $x/$ and $y/$ have initially been declared, but before any reassignment can occur by calling $myAdd/$. Therefore, the values are still $x = %d/$  and $y = %d/$', ...
            values(1),values(2));
    case 4
        if xORy == 'x'
            answer = sum(values) + 1;
        else
            answer = values(2);
        end
        explanation = sprintf('This location is after the function $myAdd()/$ has been called. Due to the function having a different scope, the value of $y/$ at this point has not changed from it''s initial value, so $y = %d/$. However, $x/$ has been overwritten with the output the function $myAdd(y,x)/$. The values of $x/$ and $y/$ inside the function will be different because of its scope, but perhaps you can notice that this function is commutative, i.e. $myAdd(%d,%d) = myAdd(%d,%d)/$. This function adds the inputs together (plus 1), so the output of $myAdd(%d,%d)/$ is $%d + %d + 1 = %d/$. This value is saved to $x/$ so the final value of $x = %d/$', ...
            values(2),values(2),values(1),values(1),values(2),values(2),values(1),values(2),values(1),sum(values)+1,sum(values)+1 );
end
            
            