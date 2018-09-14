function [answers,correctness,path_str,file_name,explanations] = path1()
% Function STR7 - QMB problem str7
%
%   [answers,correctness,explanations,path_str,file_name] = path1()
%       Generates the answers for QMB problem path1. 
%
%


%Set up list of strings to change the question
extensions = {'.gif','.jpg','.png','.bmp','.jpeg','.tiff','.tif'};
file_names = {'figure','subject','plot','mouse','rat', ...
    'time','watch','flower','science','star','drug','result', ...
    'cell','exposure','light','card','house','message','gel','blot', ...
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


% Set up answers and explanations. There are three categories" right, wrong, and joke
right_answers = {['Change your current directory to "' path_str '"'], ...
                 ['Add "' path_str '" to the path'], ...
                 ['Type $imread(''' path_str '/' file_name ''')/$ instead'], ...
                 ['Copy "' file_name '" to your current directory']};
right_explanations = {'Yes. Matlab will always search your current directory for the file', ...
    'Yes. Matlab will search through every folder on the path for the file', ...
    'Yes. You can always type the full file location as a string', ...
    'Yes. Copying the file will work'};

%Wrong answers and explanations
wrong_answers = {['Add "' root '" to the path'], ...
                 ['Change your current directory to "' root '"'], ...
                 'Define the function $imread/$', ...
                 ['Type $imread(' path_str '/' file_name ')/$ instead']};
wrong_explanations = {['No. Matlab does not search folders recursively. You need to add the lowest level folder to the path. If you use the Set Path interface, you can select the "Add with subfolders" option and select "' root '". Then, every subfolder in "' root '" will be added to the path.'], ...
                      ['No. Matlab does not search folders recursively. You would need to change your current directory to the lowest level folder, i.e. "' path_str '"'], ...
                      'No. The function $imread/$ is a built-in function. If you used an undefined function, then the error message would say something like "Undefined function or variable" instead of "File does not exist', ...
                      'No. You must enclose the path and file names in single quotes to create a string'};

%Joke answers and explanations
joke_answers = {'Throw your computer very hard against the wall', ...
                'Ask nicely and try again', ...
                'Scream loudly until your computer is cowed into submission', ...
                'Make your computer feel guilty by saying things like "I''m not angry, just disappointed"', ...
                'Scare your computer by threatening to replace it with a newer model', ...
                'Type $why/$ into the command line'};
joke_explanations = {'No. You will regret this. Maybe', ...
                     'No. Unfortunately, Matlab does not respond to good manners', ...
                     'No. Also, anyone nearby will not appreciate it.', ...
                     'No. This is just mean', ...
                     'No. Trust us, we''ve tried.', ...
                     'No. But it is fun. Try it yourself a few times'};

                 
%Pick 1-3 correct answers
iRight = randsample(length(right_answers),randi(3,1));
answers = right_answers(iRight);
explanations = [];
for ii = iRight'
    explanations = [explanations '<li><strong>' right_answers{ii} ':</strong> ' ...
        right_explanations{ii} '</li>'];
end

%Add incorrect answers to make 4 answers
iWrong = randsample(length(wrong_answers), 4-length(iRight));
answers = [answers wrong_answers(iWrong)];
for ii = iWrong'
    explanations = [explanations '<li><strong>' wrong_answers{ii} ':</strong> ' ...
        wrong_explanations{ii} '</li>'];
end
    
%Add 2 joke answers to make 6 total
iJoke = randsample(length(joke_answers),2);
answers = [answers joke_answers(iJoke)];
for ii = iJoke'
    explanations = [explanations '<li><strong>' joke_answers{ii} ':</strong> ' ...
        joke_explanations{ii} '</li>'];
end

%Assemble correctness
correctness = convert_logical([true(1,length(iRight)) false(1,length(answers)-length(iRight))]);




