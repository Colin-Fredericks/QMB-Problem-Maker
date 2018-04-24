function Acell = num2cellstr(A,fmt)
% NUM2CELLSTR - convert numerical array to cell array of strings. This 
% calls num2str iteratively
%
%   S = num2cell(A) returns a cell array the same size as A with each
%   element a string as would be returned by num2str
%
%   S = num2cell(A,fmt) uses the format string in fmt to pass to num2str
%

Acell = cell(size(A));
for ii = 1:numel(A)
    if nargin<2
        Acell{ii} = num2str(A(ii));
    else
        Acell{ii} = num2str(A(ii),fmt);
    end
end 