function output = struct17(varargin)
% function struct17 - Generate answers for QMB problem struct17
%
%   [answer,problem_values] = struct17()
%

% User variables
max_lines = 15;
range_lines = [4 12];
max_value = 100;
do_words = false;

% Parse varargin
unparsed = ParseArgin(varargin{:});
if ~isempty(unparsed)
     error(['Unable to parse input: ''' unparsed{1} '''']);
end

%Pick a structure name
style = randi(2,1);
struct_list = {'S','myStruct','myStructure','data','myData'; ...
               'S','my_struct','my_structure','data','my_data'}; 
struct_name = struct_list{style,randi(size(struct_list,2),1)};

% Pick a field name
if do_words
    field_list = {'field','newField','myField','myString','str','randomWord','randWord'; ...
                  'field','new_field','my_field','my_string','str','random_word','rand_word'};  
else
    field_list = {'field','newField','myField','myValue','val','randomValues','randInts'; ...
                  'field','new_field','my_field','my_value','val','random_values','rand_ints'};
end
field_name = field_list{style,randi(size(field_list,2),1)};

% Pick indexes of structs
num_lines = randi(range_lines,1);
indexes = sort(randsample(1:max_lines,num_lines));

%Pick values to put into struct
if do_words
    values = sample_random_words(num_lines);
else
    values = randi(max_value,1,num_lines);
end

% Create code snippet
snippet = [];
for ii = 1:num_lines
    if do_words
        snippet = [snippet sprintf('%s(%d).%s = ''%s''',struct_name,indexes(ii), ...
            field_name,values{ii}) newline];
    else
        snippet = [snippet sprintf('%s(%d).%s = %d',struct_name,indexes(ii), ...
            field_name,values(ii)) newline];
    end
   
end

%Add $$ and remove last character (a newline)
snippet = ['$$' snippet(1:end-1) '/$$'];

% Assemble output
output = {snippet,struct_name,field_name,indexes,values};
