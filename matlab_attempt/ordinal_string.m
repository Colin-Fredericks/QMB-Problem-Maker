function str = ordinal_string(int_value,do_html)
% function ORDINAL_STRING - converts integer to ordinal, e.g. 1 -> '1st'
%
%   S = ordinal_string(I) takes integer I can converts it to a string with
%   the correct ordinal suffix in S, e.g. 23 -> '23rd'. If I is an array,
%   then S will be a cell array of string the same size as I
%
%   S = ordinal_string(I,DO_HTML) will put the suffix as a superscript if
%   DO_HTML is true. This uses the sup tag, to 12 -> '12<sup>th</sup>'. The
%   default value for DO_HTML is false
%
%   
%


%Handle input
if nargin<2
    do_html = false;
end

%Run if numeric
if isnumeric(int_value)
    
    %Iterate over int values
    str = cell(size(int_value));
    for ii = 1:numel(int_value)
        if mod(int_value(ii),1)==0
            
            % Get string and ordinal suffix
            base = num2str(int_value(ii));
            suffix = ordinal_lookup(int_value(ii));
            
            %Add html tags
            if do_html
                suffix = ['<sup>' suffix '</sup>'];
            end
            
            %Add to cell array
            str{ii} = [base suffix];
        else
            error('Input must be an integer')
        end
    end
else
    error('Input must be a numeric array');
end

%Return first element if input was just a single int
if length(int_value)==1
    str = str{1};
end

end


function suffix = ordinal_lookup(int_value)
% function ORDINAL_LOOKUP
%
%   S = ordinal_lookup(I) Returns the appropriate string suffix to make the
%   input integer I and ordinal, e.g.
%       1 -> 'st'
%       12 -> 'th
%       42 -> 'nd'
%       79 -> 'th
%   and so on...


if int_value==11 || int_value==12 || int_value==13
    suffix = 'th';
else
    remainder = mod(int_value,10);
    if remainder==1
        suffix = 'st';
    elseif remainder==2
        suffix = 'nd';
    elseif remainder==3
        suffix = 'rd';
    else
        suffix = 'th';
    end
end

end

