function [answers,correctness,path_str,file_name,explanations] = path3_review()
% Function PATH3 - QMB problem path3
%
%   [answers,correctness,explanations,path_str,file_name] = path3()
%       Generates the answers for QMB problem path3. 
%
%


%Set up list of strings to change the question
extensions = {'.txt','.dat','.csv','.tsv'};
file_names = {'data','results','info','experiment','report','details', ...
    'subject','exposure','neuron','trace'};
roots = {'/Users','/home','/users'};
users = {'myName','my_name','myUser','my_user','username','user_name', ...
    'UserName','default_user','default','Default'};
folders = {'Documents','Documents/Lab','Documents/Data','Data','LabData', ...
    'Documents/data_folder','the_data','folder_name','Data/files'};


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


% Set up answers and explanations. There are three categories" right, wrong, and joke
right_answers = {['$myTable = readtable(''' path_str '/' file_name ''');/$'], ...
                 ['$uiopen(''' path_str '/' file_name ''')/$'], ...
                 'Dragging the file from Finder/File Explorer into the Command Window', ...
                 ['Clicking the "Open" button on Matlab toolstrip (top left under the Home tab), navigating to "' path_str '", and selecting the file'], ...
   };

right_explanations = { 'Yes. You can always type the full file location as a string with $readtable/$', ...
    'Yes. The $uiopen/$ function will open a window that will allow you to load the table', ...
    ['Yes. This is equivalent to typing $uiopen(''' path_str '/' file_name ''')/$ into the command line'], ...   
    'Yes. Many of the things we teach can also be accomplished using the graphical interface, but they cannot be automated. You wouldn''t want to open 1000 files this way.'};

%Wrong answers and explanations
wrong_answers = {['Yelling loudly at the computer until it does what you want'], ...
                 ['Staring at the computer screen until it blinks. Somehow.'], ...   
                 ['$uiopen(' path_str '/' file_name ')/$'], ...
                 ['$myTable = readtable(' path_str '/' file_name ');/$'], ...
                 ['$myTable = ''' path_str '/' file_name ''';/$']};
wrong_explanations = {['No. Matlab is not intimidated by your threats.'], ...
                      ['No. Matlab does not blink. It waits.'], ...
                      'No. You must enclose the path and file names in single quotes to create a string', ...
                      'No. You must enclose the path and file names in single quotes to create a string', ...
                      'No. This will create a string variable that has the full file name. It will not load the file'};
                 
%Pick 1-3 correct answers
iRight = randsample(length(right_answers),randi(3,1));
answers = right_answers(iRight);
explanations = [];
for ii = iRight'
    explanations = [explanations '<li><strong>' right_answers{ii} '</strong><br/> ' ...
        right_explanations{ii} '</li>'];
end

%Add incorrect answers to make 5 answers
iWrong = randsample(length(wrong_answers), 5-length(iRight));
answers = [answers wrong_answers(iWrong)];
for ii = iWrong'
    explanations = [explanations '<li><strong>' wrong_answers{ii} '</strong><br/> ' ...
        wrong_explanations{ii} '</li>'];
end
   
%Assemble correctness
correctness = convert_logical([true(1,length(iRight)) false(1,length(answers)-length(iRight))]);




