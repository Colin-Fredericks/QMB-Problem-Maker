function [answer,problem_values,explanation] = struct5()
% function struct5 - Generate answers for QMB problem struct5
%
%   [answer,problem_values,explanation] = struct5()
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

% Get the two stucture names
% struct_names = {'S','myStruct','myStructure','my_struct','my_structure','s'};
% ind = randi(length(struct_names),1);
% struct_name{1} = [struct_names{ind} '1'];
% struct_name{2} = [struct_names{ind} '2'];
letters = randsample('ABCDEFGHKMNPQRTUVWXYZ',2);
struct_name{1} = letters(1);
struct_name{2} = letters(2);


% Pick the number of fields. The two structs need to have a different
% number of fields, with the sum not exceeding the length of data
num_field(1) = randi(length(data)-1,1);
choices= 1:(length(data) - num_field(1));
choices = choices(choices~=num_field(1));
num_field(2) = randsample(choices,1);

%Choose which fields to place into structs
field_inds = randsample(length(data),num_field(1) + num_field(2));

% Loop through the chosen fields, adding lines to the code snippet
snippet = '';
num_remain = num_field;
for ii = field_inds'
    
    % Pick a value to store in the struct
    value_ind = randi(6,1);
    value = data{ii}{value_ind};
    
    %Pick one of the structs. If we're out of fields for this struct,
    %switch to the other
    struct_ind = randi(2,1);
    if num_remain(struct_ind) < 1
        struct_ind = find(1:2~=struct_ind);
    end
    
    %Add a line to the code snippet
    snippet = [snippet sprintf('%s.%s = ''%s''\n',struct_name{struct_ind}, ...
        field_names{ii},value)];
    
    % Subtract 1 from num_remain
    num_remain(struct_ind) = num_remain(struct_ind)-1;
end

% Add formatting to snipper
snippet = ['$$' snippet '/$$'];

%Choose which struct to ask about
ask_ind = randi(2,1);
ask_choice = struct_name{ask_ind};
answer = num_field(ask_ind);
explanation = '';

%Problem values
problem_values = {struct_name,num_field,snippet,ask_choice};
    
    