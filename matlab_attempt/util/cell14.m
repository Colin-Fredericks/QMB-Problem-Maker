function [answer,explanation,problem_values] = cell14()
%Function CELL14: Creates answers for QMB problem 'cell14'
%
%   [answer,explanation,problem_values] = cell14()


% Pick names
names = randsample('ABCDEFGHPQRSTUVWXYZ',3);

% Pick size of arrays. Have either the number of rows match or the number 
% of columns
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

% Get answer. 4 possible cases
if is_rowmatch
    
    % Matching rows with comma delimiter: success
    if is_comma
        sizeCC = [nRows(1),sum(nCols)];
        answer = sizeCC(ask_ind);
        explanation = sprintf('Both $%c/$ and $%c/$ have %d rows, so these cell arrays can be concatenated side by side. The new cell array $%c/$ will have %d rows and %d columns.</p><br/><p>This question asks for the number of %s in $%c/$, so the correct answer is $%d/$.', ...
            names(1),names(2),nRows(1),names(3),sizeCC(1),sizeCC(2),ask_dim_word,names(3),answer);
        
    % Matching rows with semicolon: error
    else
        answer = exp(1);
        explanation = sprintf('This is not the case here. $%c/$ has %d columns, while $%c/$ has %d columns. This will cause an error, so the correct answer is $e/$.', ...
            names(1),nCols(1),names(2),nCols(2));
    end
else
    
    % Matching columns with a comma: error
    if is_comma
        answer = exp(1);
        explanation = sprintf('This is not the case here. $%c/$ has %d rows, while $%c/$ has %d rows. This will cause an error, so the correct answer is $e/$.', ...
            names(1),nRows(1),names(2),nRows(2));
    
    % Matching columns with a semicolon: success
    else
        sizeCC = [sum(nRows),nCols(1)];
        answer = sizeCC(ask_ind);
        explanation = sprintf('Both $%c/$ and $%c/$ have %d columns, so these cell arrays can be concatenated one on top of the other. The new cell array $%c/$ will have %d rows and %d columns.</p><br/><p>This question asks for the number of %s in $%c/$, so the correct answer is $%d/$.', ...
            names(1),names(2),nCols(1),names(3),sizeCC(1),sizeCC(2),ask_dim_word,names(3),answer);        
    end
end
    

% Problem values 
problem_values = {names,nRows,nCols,delimiter,ask_dim_word};


