function [answer,input,explanation] = function7()
% Function FUNCTION7 - QMB problem function7
%
%   [answer,explanation] = function7()
%       
%
%


switch randi([1 5],1)
    
    case 1 % Scalar
        input = randi([10 100],1);
        answer = mysteryFunction(input);        
        explanation = ['Since the input is numeric and a scalar, the output $y/$ will be the scalar value $x * (x+1) / 2/$. Using the equation with $x = ' num2str(input) '/$, the output will be $y = ' num2str(input) ' * (' num2str(input) ' + 1) / 2 = ' num2str(answer) '/$'];
    
    case 2 % Vector
        input = randi(10,1,randi([3 5],1));
        answer = mysteryFunction(input);       
        input = mat2string(input);
        explanation = ['Since the input is numeric and a vector, the output $y/$ will be the scalar value $sqrt(sum(x.^2)/$. Using the equation with $x = ' input '/$, the output will be $y = sqrt(sum(' input '.^2)) = ' num2str(answer) '/$'];
    
    case 3 % Matrix
        input = randi(10,[2 randi([2 5],1)]);
        answer = mysteryFunction(input);       
        [nRow,nCol] = size(input);
        input = mat2string(input);        
        explanation = ['Since the input is numeric and a matrix, the output $y/$ will be the scalar value $size(x,1) * size(x,2)/$. Using the equation with $x = ' input '/$, the output will be $y = ' num2str(nRow) ' * ' num2str(nCol) ' = ' num2str(answer) '/$'];
   
    case 4 % Logical
        input = rand<0.5;
        answer = mysteryFunction(input);
        input = lower(convert_logical(input));
        input = input{1};
        explanation = ['The input $' input '/$ is a logical value, so it isn''t numeric or a string, meaning both $isnumeric(x)/$ and $ischar(x)/$ will return false. Therefore, the $else/$ condition of the function will run, and the output will be $y = -1/$.']; 
    
    case 5 % string
        explain_start = 'The input is a string, i.e an array of characters. The statement $ischar(x)/$ will return $true/$. The following code snippet looks at the first letter in the string and tries to find where that letter is located in the alphabet. '; 
        if rand > 0.5
            input = randsample('a':'z',randi([3,8],1));
            answer = mysteryFunction(input);
            ordinal = ordinal_string(answer);
            input = ['''' input ''''];
            explain_end = ['Since the first letter is $' input(2) '/$, the expression $find(x(1)==lookup)/$ will return $' num2str(answer) '/$ because $' input(2) '/$ is the ' ordinal ' letter in the alphabet'];
        else
            input = randsample('A':'Z',randi([3,8],1));
            answer = mysteryFunction(input);
            input = ['''' input ''''];
            explain_end = ['However, the string $' input '/$ has only uppercase letters, and the $lookup/$ variable only has lowercase letters. The expression $find(x(1)==lookup)/$ will return an empty value, meaning $isempty(y)/$ will return $true/$. The output $y/$ will then be set to $0/$'];
        end
        explanation = [explain_start explain_end]; 
    otherwise
        error('Something went wrong');
end
end

function y = mysteryFunction(x)

if isnumeric(x)
    if isscalar(x)
        y = x * (x+1) / 2;
    elseif isvector(x)
        y = sqrt(sum(x.^2));
    elseif ismatrix(x)
        y = size(x,1) * size(x,2);
    end
elseif ischar(x)
    lookup = 'abcdefghijklmnopqrstuvwxyz';
    y = find(x(1)==lookup);
    if isempty(y)
        y = 0;
    end
else
    y = -1;
end
end