function LoadRandomArray(x)
% LoadRandomArray - Loads a "random" array
%
%   LoadRandomArray(x) loads a random array to the Workspace with seed x

%Seed the RNG
rng('default');
rng(x);

% Repeat to make sure the numbers are different
sizeArray = randi(256,1,2);
while sizeArray(1)==sizeArray(2)
    sizeArray = randi(256,1,2);
end

% Assign array to base workspace
outputArray = randi([0 255],sizeArray);
assignin('base','myArray',outputArray)






