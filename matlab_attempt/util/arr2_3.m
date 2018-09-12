function [row_str,col_str,array_str,ans_str] = arr2_3(num_rows,num_cols,int_max)
%Function ARR2_3: Creates answers for QMB problem 'arr2.3'
%
%   [ROW_STR,COL_STR,ARRAY_STR,ANS_STR] = arr2_3(NROWS,NCOLS,IMAX) 
%   creates the answers for the checkbox problem 'arr2.3'. NROWS is the
%   number of rows for the desired matrix, NCOLS is the number of columns
%   and IMAX is maximum integer value desired. 
%
%   This script creates a matrix with randsample(IMAX,NROWS*NCOLS) and
%   picks a random value for this matrix to be asked about with ANS_STR.
%   ROW_STR and COL_STR are the row and column values that would return
%   ANS_STR. ARRAY_STR is the string used for display
%

%Sample random integers (without replacement) and arrange into matrix
values = randsample(int_max,num_rows*num_cols);
array = reshape(values,num_rows,num_cols);

%Choose and row and column to ask about. Make sure row~=col because we will
%have possible answers array(row,col) and array(col,row)
row_choice = randsample(num_rows,1);
possible_col = 1:num_cols;
col_choice = randsample(possible_col(possible_col~=row_choice),1);

%Convert row and col to string for output
row_str = num2str(row_choice);
col_str = num2str(col_choice);

%Get the "answer"
ans_value = array(row_choice,col_choice);
ans_str = num2str(ans_value);

% Field width necessary for displaying integers in the array_str 
% Essentially number of digits of max
field_width = floor(log10(int_max)) + 1;

% Format used by sprintf. Use transpose when printing
format_str = ['\n\t' repmat([' %' num2str(field_width) 'd'],1,num_cols)];
array_str = sprintf(format_str,array');
