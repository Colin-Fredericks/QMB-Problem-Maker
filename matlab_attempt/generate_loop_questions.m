%Generate all array questions
clear
close all

fname = 'C:\Users\brian\Google Drive\Quant Methods for Biology\Adaptive\Sections\5. Loops\Loop questions.xlsx';

addpath('Problem functions')

sheets = {'CG3.1.5'};
problems = {{'grow_loop4'}};


num_dynamic = 5;
for ii = 1:length(sheets)
    if isempty(problems)
        parse_excel(fname,'sheet',sheets{ii},'num_dynamic',num_dynamic);
    else
        parse_excel(fname,'sheet',sheets{ii},'num_dynamic',num_dynamic,'problem_list',problems{ii});
    end
    fprintf('Finished sheet %s (%d of %d)\n',sheets{ii},ii,length(sheets))
end