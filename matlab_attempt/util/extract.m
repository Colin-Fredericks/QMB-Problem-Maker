function values = extract(array,indices)
% function EXTRACT - Helper function for writing the QMB problems in excel
%
%   values = extract(array,indices) is equivalent to:
%   values = array(indices);
%
%   I know this is stupid. This is helpful so I can use this in the Excel
%   document that defines QMB problems
%
%   Normally, I'd have to assign something to a variable using CODE, but
%   this will allow me to skip that step.

values = array(indices);