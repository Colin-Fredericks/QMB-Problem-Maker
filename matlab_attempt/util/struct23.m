function [answer,problem_values] = struct23()
% function struct23 - Generate answers for QMB problem struct23
%
%   [answer,problem_values,explanation] = struct23()
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
struct_name = randsample('ABCDEFGHKMNPQRTUVWXYZ',2);

% Pick the number of fields. The two structs need to have a different
% number of fields
num_possible = 4;
num_field = randsample(num_possible,2);

%Create a Nx2 array that has the struct index in column 1 and filed indices
%in column 2
indexes = [1+zeros(num_field(1),1), randsample(length(data),num_field(1)); ...
           2+zeros(num_field(2),1), randsample(length(data),num_field(2))];
       
% Now shuffle
indexes = indexes(randperm(size(indexes,1)),:);

% Loop through the chosen fields, adding lines to the code snippet
lines = cell(size(indexes,1),1);
for ii = 1:size(indexes,1)   

    % Pick a value to store in the struct
    value = data{indexes(ii,2)}{randi(6,1)};

    %Add a line to the code snippet
    lines{ii} = sprintf('%s.%s = ''%s'';',struct_name(indexes(ii,1)), ...
        field_names{indexes(ii,2)},value);
 
end

% Join lines and add formatting.
snippet = ['$$' strjoin(lines,newline) '/$$'];

%Choose which struct to ask about
ask_ind = randi(2,1);
ask_choice = struct_name(ask_ind);
answer = num_field(ask_ind);

%Fields of answer struct
rows = indexes(:,1)==ask_ind;
fields = field_names(indexes(rows,2));

%Problem values
problem_values = {struct_name,num_field,snippet,ask_choice,fields};
    
    