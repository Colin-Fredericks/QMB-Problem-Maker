%Generate all array questions
clear
close all

fname = 'C:\Users\brian\Google Drive\Quant Methods for Biology\Adaptive\Sections\2. Basics\Basics questions.xlsx';

addpath('Problem functions')

sheets = {'CG0.2'};
problems = {{'arithmetic3'}};

num_dynamic = 10;
for ii = 1:length(sheets)
    if isempty(problems)
        parse_excel(fname,'sheet',sheets{ii},'num_dynamic',num_dynamic);
    else
        parse_excel(fname,'sheet',sheets{ii},'num_dynamic',num_dynamic,'problem_list',problems{ii});
    end
    fprintf('Finished sheet %s (%d of %d)\n',sheets{ii},ii,length(sheets))
end