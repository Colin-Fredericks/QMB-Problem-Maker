clear
close all

% This script makes tables in text files that can be dragged and loaded
% into Matlab

addpath ..\util
rangeVariables = [2 8];
rangeObservations = [6 20];

for ii = 1:50

    T = make_random_table();
    
    writetable(T,sprintf('random_table_%d.csv',ii));
end
    
    
