function str = escape_XML(str)
% ESCAPE_XML - Replaces the 5 standard characters with their XML
% equivalents
%
%   STR = escape_XML(STR) will replace the following 5 characters in the
%   input STR:
%           & becomes &amp;
%           < becomes &lt;
%           > becomes &gt;
%           " becomes &quot;
%           ' becomes &apos;
%   This script tries to avoid replacing XML tags so 
%       escape_XML('<p>x < 3</p>') should return '<p> x &lt; 3</p>
%

