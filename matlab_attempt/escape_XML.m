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

%First, do the easy ones. Need to do amp first so it doesn't interfere with
%the others
str = strrep(str,'&','&amp;');
%str = strrep(str,'"','&quot;');  %<-maybe add back in, but not necessary
%str = strrep(str,'''','&apos;'); %<-maybe add back in, but not necessary

%Regular expression for matching an html or xml tag
% Note: I hate using this and don't understand regex
%tag_expression = '<[^(><)]+>';
tag_expression = '<(?:"[^"]*"[''"]*|''[^'']*''[''"]*|[^''">])+>';
[tag_starts,tag_ends] = regexp(str,tag_expression);

%Find all < and > characters (including tags)
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

