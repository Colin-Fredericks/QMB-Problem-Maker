function myAnswer = replaceValues(myArray)
% function replaceValues(myArray)

for i = 1:length(myArray)
    % ---------------------------------------------------------------------
    % Insert your code here that will replace the values in myArray with
    % the single value given in the problem. This will be an if statement
    % and can be done in 3 lines. For example
    %
    %   if LOGICAL_STATEMENT
    %       REPLACE_STATEMENT;
    %   end
    %
    % You need to write in the correct logical and replace statements to do
    % the desired task
    % ---------------------------------------------------------------------
end

myAnswer = checksum(myArray);

end

% Hopefully not in the final version
function value = checksum(myArray)
% Checksum function for getting a single number from an array. 
%
% DO NOT EDIT THIS FUNCTION
value = sum(myArray(:)) + length(myArray(:));
value = mod(value,1500);
end