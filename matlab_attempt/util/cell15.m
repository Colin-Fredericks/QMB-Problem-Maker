function [answer,explanation,problem_values] = cell15()
%Function CELL15: Creates answers for QMB problem 'cell15'
%
%   [answer,explanation,problem_values] = cell15()


% Pick names
names = randsample('ABCDEFGHPQRSTUVWXYZ',3);

% Pick size of arrays. Have either the number of rows match or the number 
% of columns (doesn't matter which for cell15(). It did for cell14()
is_rowmatch = rand>0.5;
if is_rowmatch
    nRows = randi([2,10],1) + [0,0];
    nCols = randsample([2:nRows(1)-1 nRows(1)+1:10],2);
else
    nCols = randi([2,10],1) + [0,0];
    nRows = randsample([2:nCols(1)-1 nCols(1)+1:10],2);
end

% Pick delimiter
delimiter = randsample(',;',1);
is_comma = delimiter==',';

% Pick which dimension to ask for
ask_ind = randi(2,1);
dimensions = {'rows','columns'};
ask_dim_word = dimensions{ask_ind};

% Get answer. 2 possible cases
if is_comma
    sizeCC = [1 2];
    size_str = '1 row and 2 columns';  
else
    sizeCC = [2 1];
    size_str = '2 rows and 1 column';    
end

answer = sizeCC(ask_ind);
explanation = sprintf('This question asks for the number of %s in $%c/$, which has %s. Therefore, the correct answer is $%d/$.', ...
       ask_dim_word,names(3),size_str,answer);
    

% Problem values 
problem_values = {names,nRows,nCols,delimiter,ask_dim_word,size_str};


