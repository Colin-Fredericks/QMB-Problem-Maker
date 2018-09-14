function excel_data = xls_read_as_string(fileName,sheet)
% XLS_READ_AS_STRING calls xls_read and converts everything to strings
%
%   C = xls_read__as_string(FN) will open excel file with name FN and
%   output the data as a cell array of strings in C. Numeric data is
%   converted to strings with the default num2str function. Empty cells are 
%   filled with empty strings. Boolean values are filled with 'true' and
%   'false'

if nargin < 2
    sheet = 1;
end

[num,txt,raw] = xlsread(fileName,sheet);

%Pull out the part of raw we want 
num_cols = min(size(txt,2) + size(num,2),size(raw,2));
num_rows = min( max(size(txt,1),size(num,1)), size(raw,1));
excel_data = raw(1:num_rows,1:num_cols);


%Replace NaNs from raw data with empty arrays for ease of use
ind_nan = cellfun(@isnan,excel_data,'UniformOutput',false); %Places w/ nan
ind_nan(~cellfun(@isscalar,ind_nan)) = {false}; %Ignore places with >1 element
excel_data(cell2mat(ind_nan)) = {''}; %Replace with ''

%Convert all numbers to strings 
ind_num = cellfun(@isnumeric,excel_data);
excel_data(ind_num) = num2cellstr(cell2mat(excel_data(ind_num)));

%Convert all logicals to strings
ind_bool = cellfun(@islogical,excel_data);
ind_true = cell2mat(excel_data(ind_bool));
sub_bool = find(ind_bool);
excel_data(sub_bool(ind_true)) = {'true'};
excel_data(sub_bool(~ind_true)) = {'false'};


