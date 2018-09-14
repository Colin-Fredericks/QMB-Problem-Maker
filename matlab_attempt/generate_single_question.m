%Generate single question
clear
close all

addpath('util')
file = 'Excel problems\Basics questions';

sheet = 'CG0.6';
num_dynamic = 4;

problems = {'verbal1'};

%Make the excel file
parse_excel(file,'sheet',sheet,'num_dynamic',num_dynamic, ...
    'problem_list',problems);

% Use matlab to run the batch file that calls the python script to make the 
% xml files. I can't believe I just wrote that sentence
!make_xml



