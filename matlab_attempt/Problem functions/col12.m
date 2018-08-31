function [correct,incorrect,display] = col12(sizeA,indA,nameA)
% COL12 - QMB problem col12
%
%   [correct, incorrect, display, explanation] = col12(sizeA,indA,nameA)
%

% Get random values for matrix A
A = randi(100,sizeA);

% Display of full matrix for problem statement
display = ['$$' mimic_array_output(A,nameA) '/$$'];

% Correct answer
correct = ['$$' mimic_array_output(A(indA)) '/$$'];

% First incorrect answer: incorrect logical indexing, i.e. going across
% columns first instead of down rows
Atrans = A';
incorrect{1} = ['$$' mimic_array_output(Atrans(indA)) '/$$'];

% Second incorrect answer: Replace non indexed values with 0 and extract
% a 2D piece of the matrix 
[rows,cols] = ind2sub([sizeA sizeA],indA);
Azeros = A;
Azeros(1:indA(1)-1) = 0;
Azeros(indA(end)+1:end) = 0;
Apiece = Azeros(min(rows):max(rows),min(cols):max(cols));
incorrect{2} = ['$$' mimic_array_output(Apiece) '/$$'];

% Third incorrect answer: Repeat 2nd with transpose
Azeros = Atrans;
Azeros(1:indA(1)-1) = 0;
Azeros(indA(end)+1:end) = 0;
Azeros = Azeros';
Apiece =  Azeros(min(cols):max(cols),min(rows):max(rows));
incorrect{3} = ['$$' mimic_array_output(Apiece) '/$$'];

% Last incorrect answer: None of these
incorrect{4} = 'None of these';
