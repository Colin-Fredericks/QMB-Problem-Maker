function Acol = collapse(A)
% COLLAPSE - collapse N-dimensional array into column vector
%
%   Ac = collapse(A) will reshape the N-dimensionsal array A into a column
%   vector. It is equivalent to the usage Ac = A(:) but is useful since can
%   be used in combination with another function. For example:
%
%   This works, but requires an extra line and variable
%       A = magic(4);
%       B = A(:);
%   This doesn't work:
%       B = magic(4)(:); %<------FAILS
%   Now we can do it in one line:
%       B = collapse(magic(4));
%       

Acol = reshape(A,numel(A),1);