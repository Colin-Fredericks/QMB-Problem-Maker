function logical_cell = convert_logical(logical_array)
% CONVERT_LOGICAL - Converts a logical array to a cell array of strings
%
%    C = convert_logical(L) will lake logical array L and convert is to a
%    cell array of strings with 'FALSE' at the false locations and 'TRUE'
%    at the true locations
%

possible_strings = {'FALSE','TRUE'};
logical_cell = possible_strings(double(logical_array)+1);
