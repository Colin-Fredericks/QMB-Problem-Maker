function [correct, incorrect,right_choice] = nested14(color)
% function NESTED14 - code for QMB problem nested14
%
%   [correct,incorrect] = nested14(color)
%

% Figure out which color was selected by the question. They are in reverse
% order here due to the way nchoosek works.
colors = {'blue','green','red'};
right_ind = strcmp(colors,color);
wrong_ind = find(~right_ind);

% Assemble the strings to be placed in the loops
choices = nchoosek(1:3,2);
right_choice = mat2string(choices(right_ind,:));
wrong_choice1 = mat2string(choices(wrong_ind(1),:));
wrong_choice2 = mat2string(choices(wrong_ind(2),:));

% Format for sprintf. Only thing to print is the choice
format = ['$$[nRows,nColumns,nChannels] = size(myImage);\n' ...
            'for i = 1:nRows\n'  ...
            '    for j = 1:nColumns\n'  ...
            '        for k = %s\n'  ...
            '            myImage(i,j,k) = 0;\n' ...
            '        end\n' ...
            '    end\n' ...
            'end\n' ...
            'figure, imshow(myImage)/$$'];
   
    
%Insert strings into answers
right_answer = sprintf(format,right_choice);
wrong_answer{1} = sprintf(format,wrong_choice1);
wrong_answer{2} = sprintf(format,wrong_choice2);
wrong_answer{3} = sprintf(format,'1:nChannels');
wrong_answer{4} = sprintf(format,'1');
wrong_answer{5} = sprintf(format,'2');
wrong_answer{6} = sprintf(format,'3');

% Decide which answers to display. Always have correct answer
correct = right_answer;

% ALways have 1:nChannels
incorrect{1} = wrong_answer{3};

% Pick one of the wrong_choices randomly
incorrect{2} = wrong_answer{randi(2,1)};

% Randomply pick two of the single number wrong answers
sample_ind = randsample(4:6,2); 
incorrect{3} = wrong_answer{sample_ind(1)};
incorrect{4} = wrong_answer{sample_ind(2)};


    
