function [correct_answer,incorrect_answers,question_strings,solution_str] ...
    = str7(ask_names,var_name,chance_none)
% Function STR7 - QMB problem str7
%
%   [correct,incorrect,question_strings,solution_str] = str7(names,strings,chance_none) 
%       Generates the answers for QMB problem str7. 
%
%


%Set up list of strings to change the question strings
extensions = {'.gif','.jpg','.png','.bmp','.jpeg','.tiff','.tif'};
file_names = {'art','music','boy','girl','phone','cat','rabbit', ...
    'time','watch','dog','flower','science','star','drug','result', ...
    'cell','mouse','exposure','light','card','house','message','gel','blot', ...
    'instrument','image','pic','im','neuron','trace','blue','red','green'};
roots = {'/Users','/home','/users'};
users = {'myName','my_name','myUser','my_user','username','user_name', ...
    'UserName','default_user','default','Default'};
folders = {'Documents','Documents/Images','Documents/Data','Data','Images', ...
    'ImageStack','Documents/data_folder','the_data','folder_name','Data/imgs'};


%Select single instances 
root = roots{randi(length(roots),1)};
user = users{randi(length(users),1)};
folder = folders{randi(length(folders),1)};
number_suffix = sprintf('%03d',randi(99,1));
file_name = file_names{randi(length(file_names),1)};
extension = extensions{randi(length(extensions),1)};


%Now combine and save to question_strings
path_str = [root '/' user '/' folder];
file_name = [file_name number_suffix extension];
question_strings = {path_str, file_name};


%Create list of possible answer to choose from
right_answer = ['[' ask_names{1} ', ''/'', ' ask_names{2} ']'];

answers{1} = ask_names{1};
answers{2} = ask_names{2};
answers{3} = ['[' ask_names{1} ']'];
answers{4} = ['[' ask_names{2} ']'];

answers{5} = [ask_names{1} ', ' ask_names{2}];
answers{6} = [ask_names{1} ', ''/'', ' ask_names{2}];
answers{7} = [ask_names{1} ', '' '', ' ask_names{2}];
answers{8} = [ask_names{1} ', '','', ' ask_names{2}];

answers{9} = ['[' ask_names{1} ', ' ask_names{2} ']'];
answers{10} = ['[' ask_names{1} ', '' '', ' ask_names{2} ']'];
answers{11} = ['[' ask_names{1} ', '','', ' ask_names{2} ']'];

answers{12} = ['[' ask_names{1} '; ''/''; ' ask_names{2} ']'];
answers{13} = ['[' ask_names{1} '; '',''; ' ask_names{2} ']'];
answers{14} = ['[' ask_names{1} '; '' ''; ' ask_names{2} ']'];
answers{15} = [ask_names{1} '; ''/''; ' ask_names{2}];

% Set up answers
if rand > chance_none
    correct_answer = ['$' var_name ' = imread(' right_answer ')/$'];    
    wrong_answers = randsample(answers,3);
    for ii = 1:3
        incorrect_answers{ii} = ['$' var_name ' = imread('  wrong_answers{ii}  ')/$'];
    end
    incorrect_answers{4} = 'None of these';
else
    correct_answer = 'None of these';
    wrong_answers = randsample(answers,4);
    for ii = 1:4
        incorrect_answers{ii} = ['$' var_name ' = imread('  wrong_answers{ii}  ')/$'];
    end
end


%Set up question strings
ans_str = [path_str,'/' file_name];
solution_str = ['The correct way to load this image uses $' right_answer '/$ to join the path and file name into the string $''' ans_str '''/$. This is the correct argument that $imread/$ can use to load the file. Therefore, the correct choice is $' var_name ' = imread(' right_answer ')/$'];

if strcmp(correct_answer,'None of these')
    solution_str = [solution_str '. This choice is not present, so the correct answer is "None of these"'];
end