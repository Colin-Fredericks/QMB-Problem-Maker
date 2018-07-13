function [correct_answer,incorrect_answers,ask_str,solution_str] = str6(names,strings,chance_none)
% Function STR6 - QMB problem str6
%
%   [correct,incorrect,ask_str,solution_str] = str6(names,strings,chance_none) 
%       Generates the answers for QMB problem str6. 
%
%

%Pick a random delimiter to join strings
delims = {' ',''};
delim = delims{randsample(2,1)};

%Randomize the string order
right_order = randperm(length(strings));
wrong_order = 1:length(strings);
while all(right_order==wrong_order)
    right_order = randperm(length(strings));
end

%Generate possible answers
right_spaces = ['$' strjoin(strings(right_order),' ') '/$'];
right_nothin = ['$' strjoin(strings(right_order),'') '/$'];
right_under = ['$' strjoin(strings(right_order),'_') '/$'];
wrong_spaces = ['$' strjoin(strings(wrong_order),' ') '/$'];
wrong_nothin = ['$' strjoin(strings(wrong_order),'') '/$'];

% String for the question text
ask_str = strjoin(names(right_order),[', ''' delim ''', ']); 

%Organize answers
if rand > chance_none
    if delim==' '
        correct_answer = right_spaces;
        incorrect_answers{1} = right_nothin;
        incorrect_answers{2} = wrong_spaces;
        incorrect_answers{3} = wrong_nothin;
    else
        correct_answer = right_nothin;
        incorrect_answers{1} = right_spaces;
        incorrect_answers{2} = wrong_spaces;
        incorrect_answers{3} = wrong_nothin;
        
    end
    incorrect_answers{4} = 'None of these';   
else
    correct_answer = 'None of these';
    if delim == ' '
        incorrect_answers{1} = right_nothin;
        incorrect_answers{2} = wrong_spaces;
        incorrect_answers{3} = wrong_nothin;
        incorrect_answers{4} = right_under;
    else
        incorrect_answers{1} = right_spaces;
        incorrect_answers{2} = wrong_spaces;
        incorrect_answers{3} = wrong_nothin;
        incorrect_answers{4} = right_under;
    end
    
end

%String for solution explanation
if delim == ' '
    solution_str = ['$'' ''/$, which is a string that contains a single space character. ' ...
        'This will concatenate the words together with a single space ' ...
        'in between each word. Therefore, the value in $combined_str/$ ' ...
        'should be: ' right_spaces];
else
    solution_str = ['a double set of apostrophes $''''/$. This creates an empty string ' ...
        'with zero characters. Therefore, there are no characters in between ' ...
        'each word in $combined_str/$, so it will contain the string:' right_nothin];
end

%Add tidbit
if strcmp(correct_answer,'None of these')
    solution_str = [solution_str '. This choice is not present, so the correct ' ...
        'answer is "None of these"'];
end





