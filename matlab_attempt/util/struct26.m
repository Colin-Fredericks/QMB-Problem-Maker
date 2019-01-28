function [answer,problem_values] = struct26()
% function struct26 - Generate answers for QMB problem struct26
%
%   [answer,problem_values,explanation] = struct26()
%


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

% Get the stucture name
struct_name = randsample('ABCDEFGHKMNPQRTUVWXYZ',1);

% Pick the number of fields. The two structs need to have a different
% number of fields
num_field = randi([4 length(data)],1);

%Which fields to sample
indexes = randsample(length(data),num_field);

% Loop through the chosen fields, adding lines to the code snippet
lines = cell(length(indexes),1);
values = lines;
for ii = 1:length(indexes)   

    % Pick a value to store in the struct
    values{ii} = data{indexes(ii)}{randi(6,1)};

    %Add a line to the code snippet
    lines{ii} = sprintf('%s.%s = ''%s'';',struct_name, ...
        field_names{indexes(ii)},values{ii});
 
end

% Join lines and add formatting.
snippet = ['$$' strjoin(lines,newline) '/$$'];

% Choose which field to ask about. Answer is this field value
line_ind = randi(length(indexes),1);
answer = values{line_ind};

%Fields of answer struct
fields = field_names(indexes);
field_choice = find(indexes==indexes(line_ind));

%Problem values
problem_values = {struct_name,num_field,snippet,field_choice,fields};
    
    