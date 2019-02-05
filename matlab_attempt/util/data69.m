function [answers,correctness,array_name,explanation] = data69()
% function data69 - Generate answers for QMB problem data69
%
%   [answers,correctness,array_name,explanation] = data69()
%


array_name = 'myArray';%upper(randsample('abcdefghkpqrtuvwxyz',1));

% Right answers
right_answers{1} = sprintf('nanmean(%s)',array_name);
right_answers{2} = sprintf('mean(%s,''omitnan'')',array_name);
right_answers{3} = sprintf('sum(%s(~isnan(%s)))/sum(~isnan(%s))', ...
    array_name,array_name,array_name);
right_answers{4} = sprintf(['mySum = 0;\nmyCount = 0;\n' ...    
                            'for i = 1:length(%s)\n' ...
                            '    if ~isnan(%s(i))\n' ...
                            '        mySum = mySum + %s(i);\n' ...
                            '        myCount = myCount + 1;\n' ...
                            '    end\n' ...
                            'end\n' ...
                            'mySum/myCount'],array_name,array_name,array_name);
right_answers{5} = sprintf('mean(%s(~isnan(%s)))',array_name,array_name);
right_answers{6} = sprintf(['isNumber = ~isnan(%s);\n' ...
                            'mean(%s(isNumber)'],array_name,array_name);
% Wrong answers
wrong_answers{1} = sprintf('mean(%s)',array_name);
wrong_answers{2} = sprintf('mean(%s,''ignorenan'')',array_name);
wrong_answers{3} = sprintf('sum(%s)/length(%s)', ...
    array_name,array_name);
wrong_answers{4} = sprintf(['mySum = 0;\nmyCount = 0;\n' ...    
                            'for i = 1:length(%s)\n' ...                            
                            '    mySum = mySum + %s(i);\n' ...
                            '    myCount = myCount + 1;\n' ...
                            'end\n' ...
                            'mySum/myCount'],array_name,array_name);
wrong_answers{5} = sprintf('mean(%s(isnan(%s)))',array_name,array_name);
wrong_answers{6} = sprintf(['isNumber = isnan(%s);\n' ...
                            'mean(%s(isNumber)'],array_name,array_name);

% Explanations for right answers
wrong_explain{1} = 'No. Using just the $mean/$ function will return a $NaN/$ value.';
wrong_explain{2} = 'No. The correct option is $''omitnan''/$, not $''ignorenan''/$.';
wrong_explain{3} = sprintf('No. This would calculate the mean for a numeric array without $NaN/$ values, but for $%s/$, this would return $NaN/$.',array_name);                 
wrong_explain{4} = sprintf('No. This would calculate the mean for a numeric array without $NaN/$ values, but for $%s/$, this would return $NaN/$.',array_name);
wrong_explain{5} = sprintf('No. This answer attempts to use logical indexing, but the statement $%s(isnan(%s))/$ will return the values in %s that <em>are</em> $NaN/$ values. This line is actually taking the mean of just the $NaN/$ values.',array_name,array_name,array_name);
wrong_explain{6} = sprintf('No. This answer attempts to use logical indexing, but the statement $%s(isnan(%s))/$ will return the values in %s that <em>are</em> $NaN/$ values. These lines are actually taking the mean of just the $NaN/$ values.',array_name,array_name,array_name);

% Explanations for the wrong answers
% Explanations for right answers
right_explain{1} = 'Yes. The $nanmean/$ function is designed for exactly this purpose.';
right_explain{2} = 'Yes. The $''omitnan''/$ option is designed for exactly this purpose.';
right_explain{3} = sprintf('Yes. This answer uses some complicated logical indexing to find the correct answer. Note that this uses $~isnan(%s)/$ meaning the locations in the array that are <em>not</em> $NaN/$ values.',array_name);                 
right_explain{4} = 'Yes. The $if/$ block inside this loop checks to make sure each number is not an $NaN/$ value before updating the $mySum/$ and $myCount/$ variables that are used to calculate the mean.';
right_explain{5} = sprintf('Yes. This answer uses logical indexing. The statement $%s(~isnan(%s))/$ will return the values in $%s/$ that are not $NaN/$ values.',array_name,array_name,array_name);
right_explain{6} = sprintf('Yes. The $isNumber/$ variable is a logical array that contains the locations in $%s/$ that are not $NaN/$ values. This is then used as a logical index when calling the $mean/$ funciton.',array_name);


%Pick 2-3 correct answers. Always include one of the first two
iRight = [randsample(1:2,randi(2,1)) randsample(3:length(right_answers),1)];
answers = right_answers(iRight);
explanation = [];
for ii = iRight
    explanation = [explanation '<li>$$' right_answers{ii} '/$$<br/> ' ...
        right_explain{ii} '</li>'];
end

%Add incorrect answers to make 5 answers
iWrong = randsample(length(wrong_answers), 5-length(iRight));
answers = [answers wrong_answers(iWrong)];
for ii = iWrong'
    explanation = [explanation '<li>$$' wrong_answers{ii} '/$$<br/> ' ...
        wrong_explain{ii} '</li>'];
end
   
% Add formatting to answers
for ii = 1:length(answers)
    answers{ii} = ['$$' answers{ii} '/$$'];
end

%Assemble correctness
correctness = convert_logical([true(1,length(iRight)) false(1,length(answers)-length(iRight))]);

