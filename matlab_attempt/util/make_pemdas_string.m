function [str,answer] = make_pemdas_string(num_values,varargin)
% MAKE_PEMDAS_STRING - generate PEMDAS problems (order of operations)
%
%
%   PSTR = make_pemdas_str(NVAL) will make a PEMDAS problem in the string 
%   PSTR that has NVAL different values (not including exponents). 
%
%       Examples: NVAL = 3
%           (4 + (7 - 3))
%           (2^0 - (1 * 4))
%           1^0 * (4 * 7)
%           4^0 * (8 - 4)
%       Examples: NVAL = 5
%           3 * (3 * (10^2 - 2)) * 4
%           7^2 * 9 + (10 * (3^1 - 3)) 
%           (4 + 7) - (4^1 - (2 * 1))
%
%   [PSTR,ANS] = make_pemdas_str(NVAL) will also return the evaluated
%   answer of PSTR.
%
%   [...] = make_pemdas_str(NVAL,'PropertyName',PropertyValue, ... ) allows
%   for the various parameters to be set
%       'p_exp' - Exponent probability. Default: 0.4
%       'p_open' - Chance of openening a parentheses at a given spot.
%           Default: 0.8
%       'o_close - Chance of closing a parentheses at a given spot.
%           Default: 0.4
%       'operation_list' - Possible math operators. Default: '+-*'
%       'exp_vals' - Possible values for exponents. Default: 0:2
%       'max_val' - Max integer value for problem. Default: 10, meaning all
%           randomly generated integers are <= 10

p_exp = 0.5;
p_open = 0.8;
p_close = 0.4;
operation_list = '+-*';
exp_vals = 0:2;
max_val = 10;

%Now parse input arguments
% Parse varargin
unparsed = ParseArgin(varargin{:});
if ~isempty(unparsed)
     error(['Unable to parse input: ''' unparsed{1} '''']);
end

%Initialize loop.
num_paren = 0;
num_count = 0;
str = [];
while num_count < num_values-1
    
    % Handle the end of previous iterations
    %First, try to close off any open parentheses
    close_paren = [];
    for jj = 1:num_paren
        close_paren(end+1) = rand < p_close;       
        
        if close_paren(end)
            if str(end) == ' '
                str = [str num2str(randi(max_val,1)) ')'];
                num_count = num_count+1;
            else
                str = [str ')'];                
            end
            if rand<p_exp
                str = [str '^' num2str(randsample(exp_vals,1))];
            end
            num_paren = num_paren - 1;                        
        end
    end
    
    if num_count == num_values-1
        break
    end

    % Start next iteration    
    % If any parentheses were closed, start with an operation before number
    if any(close_paren)
        op = randsample(operation_list,1);
        str = [str ' ' op ' '];
    end 
    
    %Open a parentheses
    if  rand < p_open
        str = [str '('];
        num_paren = num_paren+1;
    end
    
    %Pick a number
    str = [str num2str(randi(max_val,1))];
    num_count = num_count + 1;
    
    %Add an exponent
    if rand < p_exp
        str = [str '^' num2str(randsample(exp_vals,1))];
    end
    
    %Add an operation
    str = [str ' ' randsample(operation_list,1) ' '];
end

% Finish
% Add a final number if we need to
if str(end) == ' '
    str = [str num2str(randi(max_val,1))];
else
     str = [str ' ' randsample(operation_list,1) ' ' num2str(randi(max_val,1))];
end

%Close off any remaining parentheses
str = [str repmat(')',1,num_paren)];

%Evaluate for the answer
answer = eval(str);
end
    