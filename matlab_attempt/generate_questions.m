%Generate all array questions
clear
close all

fname = 'Array questions.xlsx';

addpath('Problem functions')

sheets = {'CG1.1.1', 'CG1.1.2', 'CG1.1.3', 'CG1.1.5', 'CG1.1.6', ...
          'CG1.2.1', 'CG1.2.2', 'CG1.2.3', 'CG1.2.4', 'CG1.2.5', ...
          'CG1.2.6', 'CG1.2.7', 'CG1.3.1', 'CG1.3.2', 'CG1.3.3', ...
          'CG1.4.1','CG1.4.2'};

num_dynamic = 1;
for ii = 1%:length(sheets)
    parse_excel(fname,'sheet',sheets{ii},'num_dynamic',num_dynamic);
    fprintf('Finished sheet %s (%d of %d)\n',sheets{ii},ii,length(sheets))
end