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

%Pick number of structs
num_struct = randi(array_range,1);

% Pick indexes used for struct generation
indexes = [];
for ii = 1:num_struct
    num_field = randi(max_fields,1);
    indexes = [indexes; ii+zeros(num_field,1),  ...
        randsample(length(data),num_field)];
end

% Now shuffle
indexes = indexes(randperm(size(indexes,1)),:);
num_lines = size(indexes,1);

% Now remove a couple of lines. Don't remove the last line
% since that will be the largest index
num_remove = floor(num_lines*frac_remove);
rm_ind = randsample(1:num_lines-1,num_remove);
indexes(rm_ind,:) = [];
num_lines = size(indexes,1);

lines = cell(num_lines,1);
values = lines;
fields = lines;
for ii = 1:num_lines
    
    iS = indexes(ii,1);
    iF = indexes(ii,2);
    iV = randi(length(data{iF}),1);
    
    % Store value
    values{ii} = data{iF}{iV};
    fields{ii} = field_names{iF};

    % Add a line and evaluate
    lines{ii} = sprintf('myStruct(%d).%s = ''%s''',iS, ...
        field_names{iF},values{ii});
    myStruct(iS).(field_names{iF}) = values{ii};

end

% Make code snippet
snippet = ['$$' strjoin(lines,newline) '/$$'];

%Problem values
varargout = {snippet,indexes(:,1),fields,values,myStruct};

    
    