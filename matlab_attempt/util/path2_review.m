function [answers,correctness,path_str,file_name,explanations] = path2()
% Function PATH2 - QMB problem path2
%
%   [answers,correctness,explanations,path_str,file_name] = path2()
%       Generates the answers for QMB problem path2. 
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
                 ['Change directory to "' path_str '"<br/> $myTable = readtable(''' file_name ''');/$'], ...
                 ['Add "' path_str '" to the path<br/> $myTable = readtable(''' file_name ''');/$'], ...
                 ['Copy "' file_name '" to the current directory<br/> $myTable = readtable(''' file_name ''');/$'], ...
    };

right_explanations = { 'Yes. You can always type the full file location as a string', ...
    'Yes. Changing your current directory will work because this is the first folder in which Matlab will look', ...
    'Yes. Matlab will search through every folder on the path for the file', ...   
    'Yes. Copying the file will work'};

%Wrong answers and explanations
wrong_answers = {['Change directory to "' root '"<br/> $myTable = readtable(''' file_name ''');/$'], ...
                 ['Add "' root '" to the path<br/> $myTable = readtable(''' file_name ''');/$'], ...
                 ['$myTable = readtable(''' file_name ''');/$'], ...
                 ['$myTable = readtable(' path_str '/' file_name ');/$'], ...
                 ['$myTable = ''' path_str '/' file_name ''';/$']};
wrong_explanations = {['No. Matlab does not search folders recursively. You would need to change your current directory to the lowest level folder, i.e. "' path_str '"'], ...
                      ['No. Matlab does not search folders recursively. You need to add the lowest level folder to the path. If you use the Set Path interface, you can select the "Add with subfolders" option and select "' root '". Then, every subfolder in "' root '" will be added to the path.'], ...
                      'No. Matlab would search the current directory for the file and would not be able to find it', ...
                      'No. You must enclose the path and file names in single quotes to create a string', ...
                      'No. This will create a string variable that has the full file name. It will not load the table'};
                 
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




