function [answer,problem_values] = if_else24()
% Create answers and generates random problem values for if_else24


%% Choose values
%Randomize the propblem values

%Pick number of rows and columns
nRows = randi([3 8],1);
nCols = randsample([3:nRows-1 nRows+1:8],1);

% Arrays to sample from
compare_symbols = {'<','>','<=','>=','==','~='};
compare_strings = {'less than','greater than','less than or equal to', ...
    'greater than or equal to','equal to','not equal to'};
rowcol_symbols = {'i','j'};
rowcol_strings = {'row','column'};

%% Sample values. Put in a while loop because we check that the resulting matrix has 3 unique values (i.e. all logical statements are used at least once)
while true

    % Now sample values
    compare_choice_indices = randsample(length(compare_symbols),2);
    compare_choice_symbols = compare_symbols(compare_choice_indices);
    compare_choice_strings = compare_strings(compare_choice_indices);

    rowcol_choice_index = randsample(length(rowcol_symbols),1);
    rowcol_choice_symbol = rowcol_symbols(rowcol_choice_index);
    rowcol_choice_string = rowcol_strings(rowcol_choice_index);

    array_values = randsample(100,3);
    ind_value = randsample(8,1);

    %User str2func to make functions from strings
    compare_func{1} = str2func(['@(i) i' compare_choice_symbols{1} num2str(ind_value)]);
    ij_func = str2func(['@(inputs) inputs(''ij''==''' rowcol_choice_symbol{1} ''')']);
    compare_func{2} = str2func(['@(i,j) j' compare_choice_symbols{2} 'i']);

    %Create array
    A = []; 
    for i = 1:nRows 
        for j =  1:nCols
            if compare_func{1}(ij_func([i j]))
                A(i,j) = array_values(1); 
            elseif compare_func{2}(i,j) 
                A(i,j) =  array_values(2); 
            else
                A(i,j) = array_values(3);
            end 
        end
    end
    
    % See if array has the 3 array_values. If so, break
    if length(unique(A))==3
        break
    end
    
end


%% Assemble output

row_choice = randsample(nRows,1);
col_choice = randsample(nCols,1);
answer = A(row_choice,col_choice);

%Now problem values
problem_values{1} = compare_choice_strings;
problem_values{2} = array_values;
problem_values{3} = rowcol_choice_string;
problem_values{4} = ind_value;
problem_values{5} = [nRows nCols];
problem_values{6} = [row_choice col_choice];
problem_values{7} = compare_choice_symbols;
problem_values{8} = rowcol_choice_symbol;
problem_values{9} = A;


%% Check to see if choices create an array will all 3 values
% i.e. that all 3 logical statements must be evaluated. If not, resample
A;

