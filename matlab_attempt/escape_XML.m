function str = escape_XML(str)
% ESCAPE_XML - Replaces the 5 standard escape characters with their XML
% equivalents
%
%   NEWSTR = escape_XML(STR) will replace the following 5 characters in the
%   input STR:
%           & becomes &amp;
%           < becomes &lt;
%           > becomes &gt;
%           " becomes &quot;
%           ' becomes &apos;
%   This function tries to avoid replacing XML tags so 
%       escape_XML('<p>x < 3</p>') should return '<p> x &lt; 3</p>
%

%Regular expression for matching an html or xml tag
expression = '<[^(><)]+>';

%First look for tags with this expression
[tag_starts,tag_ends] = regexp(str,expression);

%Find all < and > characters
lessThan_indices = regexp(str,'<');
greaterThan_indices = regexp(str,'>');

%Only replace characters that aren't xml/html tags
is_tag_start = ismember(lessThan_indices,tag_starts);
for ii = lessThan_indices(~is_tag_start)
    str = [str(1:ii-1) '&lt;' str(ii+1:end)];
end

%Repeat for greater than
is_tag_end = ismember(greaterThan_indices,tag_ends);
for ii = greaterThan_indices(~is_tag_end)
    str = [str(1:ii-1) '&gt;' str(ii+1:end)];
end

%Lastly, replace the easy characters
str = strrep(str,'&','&amp;');
str = strrep(str,'"','&quot;');
str = strrep(str,'''','&apos;');
