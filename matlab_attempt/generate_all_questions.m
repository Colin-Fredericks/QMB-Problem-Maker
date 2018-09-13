%Generate all array questions
clear
close all

addpath('Problem functions')

fpath = 'C:\Users\brian\Google Drive\Quant Methods for Biology\Adaptive\Sections\3. Arrays\';
fname = [fpath 'Array questions.xlsx'];
[~,sheets] = xlsfinfo(fname);
sheets = sheets(strncmp(sheets,'CG',2));

num_dynamic = 30;

for ii = [14 17 18]%1:length(sheets)
    parse_excel(fname,'sheet',sheets{ii},'num_dynamic',num_dynamic);
    fprintf('Finished sheet %s (%d of %d)\n',sheets{ii},ii,length(sheets))
end