%Generate all questions
clear
close all

addpath('util')
file = 'Problem descriptions\Basics questions.xlsx';

[~,sheets] = xlsfinfo(file);
sheets = sheets(strncmp(sheets,'CG',2));

num_dynamic = 1;

for ii = 1:length(sheets)
    parse_excel(fname,'sheet',sheets{ii},'num_dynamic',num_dynamic);
    fprintf('Finished sheet %s (%d of %d)\n',sheets{ii},ii,length(sheets))
end

% Use matlab to run the batch file that calls the python script 
!make_xml