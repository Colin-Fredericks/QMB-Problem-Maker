function array = store(array,indices,values)
% function STORE - Helper function for writing the QMB problems in excel
%
%   new_array = store(array,indices,values) is equivalent to:
%       array(indices) = values;
%       new_array = array;
%
%   I know this is stupid. This is helpful so I can use this in the Excel
%   document that defines QMB problems
%
%   Normally, I'd have to assign something to a variable using CODE, but
%   this will allow me to skip that step.

array(indices) = values;