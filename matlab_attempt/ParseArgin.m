function unparsed = ParseArgin(varargin)
% PARSEARGIN -- parse input argument list.
% Usage ParseArgin('prop1', val1, 'prop2', val2, ...)
%    Assigns the values to the variables 'prop1', 'prop2', ... in the caller's
% workspace. It is not an error if the variable does not exist, but the 
% assignment is made only when it does.
%

% Ken Hancock 4 June 2003

unparsed = {};

k = 1;
while k <= nargin,
   if ischar(varargin{k}) && evalin('caller', ['exist(''' varargin{k} ''')==1']) && k<nargin,
      assignin('caller', varargin{k}, varargin{k+1});
      k = k + 2;
   else
      unparsed{end+1} = varargin{k};
      k = k + 1;
   end
end
