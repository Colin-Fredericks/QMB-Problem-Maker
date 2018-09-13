%Generate all array questions
clear
close all

addpath('util')
file = 'Problem descriptions\Loop questions.xlsx';


[~,sheets] = xlsfinfo(fname);
sheets = sheets(strncmp(sheets,'CG',2));

num_dynamic = 30;

for ii = 1:length(sheets)
    parse_excel(fname,'sheet',sheets{ii},'num_dynamic',num_dynamic);
    fprintf('Finished sheet %s (%d of %d)\n',sheets{ii},ii,length(sheets))
end

% Use matlab to run the the batch file for the python code
!make_xml