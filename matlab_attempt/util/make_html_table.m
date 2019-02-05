function html_str = make_html_table(T,width,border)
% MAKE_HTML_TABLE - convert Matlab table to HTML table
%
%   html_str = make_html_table(T)
%
%   html_str = make_html_table(T,width,border) allows you to set the width
%   of the table (percentage of the total) and the thickness of the border.
%       width -  integer from 1 to 100. default: 100
%       border - integer >=1. Default: 1
%   If either is empty [], then that tag is left out

% Handle input
if nargin < 3
    border = 1;
end
if nargin < 2
    width = 100;
end

% Decide whether to include border and width tags
width_tag = '';
if ~isempty(width)
    width_tag = sprintf(' style="width:%d%%"',width);
end
border_tag = '';
if ~isempty(border)
    border_tag = sprintf(' border="%d"',border);
end

% Table tags
open_tag= sprintf('<table%s%s>\n',width_tag,border_tag);
close_tag = '</table>';

% Make header row
header = ['<tr>' newline];
varNames = T.Properties.VariableNames;
for name = varNames
    header = [header sprintf('\t<th>%s</th>\n',name{1})];
end
header = [header '</tr>'];

% Make body rows
body = '';
for ii = 1:size(T,1)
    body = [body '<tr>' newline];        
    for jj = 1:size(T,2)
        body = [body sprintf('\t<td>%s</td>\n',entry2str(T{ii,jj}))];
    end
    body = [body '</tr>' newline];
end


% Assemble full table
html_str = [open_tag header body close_tag];


end


function str = entry2str(entry)
% This function tries to convert the input to a string, regardless of type

% If string, return itself
if ischar(entry)
    str = entry;
% If cell array of strings, return first element
elseif iscellstr(entry)
    str = entry{1};
% If other type of cell array, return num2str of first element
elseif iscell(entry)
    str = num2str(entry{1});
% For eveything else, use num2str
else
    str = num2str(entry);
end

end