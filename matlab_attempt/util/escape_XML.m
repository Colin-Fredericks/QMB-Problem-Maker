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
tag_expression = '</?\w+((\s+\w+(\s*=\s*(?:".*?"|''.*?''|[\^''">\s]+))?)+\s*|\s*)/?>'; % <--seriously wtf. Source: https://haacked.com/archive/2004/10/25/usingregularexpressionstomatchhtml.aspx/
%tag_expression = '<(?:"[^"]*"[''"]*|''[^'']*''[''"]*|[^''">])+>';
[tag_starts,~] = regexp(str,tag_expression);

%Find all < characters (including tags)
lessThan_indices = regexp(str,'<');

%Only replace < characters that aren't xml/html tags
orig_length = length(str);
is_tag_start = ismember(lessThan_indices,tag_starts);
for ii = lessThan_indices(~is_tag_start)
    ind = ii + (length(str) - orig_length);    
    str = [str(1:ind-1) '&lt;' str(ind+1:end)];
end

%Redo the tag and symbol search for > in case string has changed length
[~,tag_ends] = regexp(str,tag_expression);
greaterThan_indices = regexp(str,'>');

%Now repeat for greater than
orig_length = length(str);
is_tag_end = ismember(greaterThan_indices,tag_ends);
for ii = greaterThan_indices(~is_tag_end)
    ind = ii + (length(str) - orig_length);
    str = [str(1:ind-1) '&gt;' str(ind+1:end)];
end

