function varargout = struct6(varargin)
% function struct6 - Generate answers for QMB problem struct6
%
%   varargout = struct6(varargin)
%
%   Inputs: must be in 'ParameterName',ParameterValue format
%       max_fields: default 3
%       array_range: default [2 5]
%       frac_remove: default 0
%
%   Outputs
%       snippet: string of code that makes the struct
%       num_struct: length of struct array
%       fields_per_struct: array wtih # of assigned fields per struct
%       all_fields: cell array of unique fields assigned

%Inputs
max_fields = 3;
array_range = [2 5];
frac_remove = 0.5;

% Parse varargin
unparsed = ParseArgin(varargin{:});
if ~isempty(unparsed)
     error(['Unable to parse input: ''' unparsed{1} '''']);
end

% Data to be sampled from for lines of code
first_name = {'James','Mary','Elizabeth','Michael','Susan','David'};
last_name = {'Smith','Johnson','Williams','Jones','Brown','Davis'};
eye_color = {'amber','blue','brown','hazel','green','gray'};
hair_color = {'brown','white','blond','auburn','red','gray'};
height = num2cellstr([172, 158, 167, 169, 165, 180]);
age = num2cellstr(randi([18 65],1,6));
city = {'Los Angeles','Chicago','New York','Boston','San Francisco','Dallas'};

% Combine to make sampling easier
data = {first_name,last_name,eye_color,hair_color,height,age,city};
field_names = {'firstName','lastName','eyeColor','hairColor','height','age','city'};

num_struct = randi(array_range,1);
lines = {};
all_fields = {};
struct_indexes = [];
for ii = 1:num_struct
    
    num_field = randi(max_fields,1);
    for jj = randsample(length(data),num_field)'
        
        % Pick a value to store in the struct
        value_ind = randi(length(data{jj}),1);
        value = data{jj}{value_ind};
        
        % Add a line
        lines{end+1} = sprintf('myStruct(%d).%s = ''%s''',ii, ...
            field_names{jj},value);
        
        % Add which fields we used so we can get the unique fields
        all_fields{end+1} = field_names{jj};
        
        %Keep track of stuct index
        struct_indexes(end+1) = ii;
        
    end
end

% For this problem, remove a couple of lines. Don't remove the last line
% since that will be the largest index and therefore the answer.
num_remove = floor(length(lines)*frac_remove);
rm_ind = randsample(1:length(lines)-1,num_remove);
lines(rm_ind) = [];
all_fields(rm_ind) = [];

%Count the number of fields assigned per struct base on lines removed
struct_indexes(rm_ind) = NaN;
fields_per_struct = hist(struct_indexes,1:num_struct)';

% Remove repeats from all_fields
all_fields = unique(all_fields);

%Shuffle and join together
lines = lines(randperm(length(lines)));
snippet = ['$$' strjoin(lines,newline) '/$$'];
    
%Problem values
varargout = {snippet,num_struct,fields_per_struct,all_fields};

    
    