%Generate single question
clear
close all

addpath('util')
file = 'Problem descriptions\Loop questions';

sheet = 'CG3.1.2';
num_dynamic = 4;

problems = {'loop0.2'};

%Make the excel file
parse_excel(file,'sheet',sheet,'num_dynamic',num_dynamic, ...
    'problem_list',problems);

% Use matlab to run the batch file that calls the python script to make the 
% xml files. I can't believe I just wrote that sentence
!make_xml



