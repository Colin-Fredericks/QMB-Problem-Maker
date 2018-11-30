function [answers,problem_values] = if_else23()



% <p>
% What are the values of the array $XX/$ after the following code runs?
% </p>
% <p>
% $$XX = [];
% for i = 1:nRows
%     for j =  1:NCOLS
%         if i COMPARE1 j
%             XX(i,j) = IJ_CHOICE1;
%         elseif IJ_CHOICE2 COMPARE2 VAL1
%             XX(i,j) =  VAL2;
%         else
%             XX(i,j) = 0;
%         end
%     end
% end/$$
% </p>
%% Choose values
%Randomize the propblem values
nAnswer = 5;
array_name = randsample('ABCDEFGHKMNPQRTUVWXYZ',1);
nRows = randi([3 8],1);
nCols = randsample([3:nRows-1 nRows+1:8],1);
compare = [randsample({'<','>','<=','>=','==','~='},1), ...
           randsample({'<','>','<=','>=','==','~='},1)];
ij_choice = [randsample('ij',1), randsample('ij',1)];
vals(1) = randi([1 10],1);
vals(2) = randsample([1:vals(1)-1 vals(1)+1:10],1);

%COmbine into output array
problem_values = {[nRows nCols],compare,ij_choice,vals,array_name};

%User str2func to make functions from strings
compare_func{1} = str2func(['@(i,j) i' compare{1} 'j']);
compare_func{2} = str2func(['@(i) i' compare{2} num2str(vals(1))]);
ij_func{1} = str2func(['@(inputs) inputs(''ij''==''' ij_choice(1) ''')']);
ij_func{2} = str2func(['@(inputs) inputs(''ij''==''' ij_choice(2) ''')']);

%% Generate answers

% Generate right answer
A = []; 
for i = 1:nRows 
    for j =  1:nCols
        if compare_func{1}(i,j)
            A(i,j) = ij_func{1}([i j]); 
        elseif compare_func{2}(ij_func{2}([i j])) 
            A(i,j) =  vals(2); 
        else
            A(i,j) = 0;
        end 
    end
end
right_array = A;
answer_arrays{1} = right_array;


% Wrong 1: Opposite compare 1
A = []; 
for i = 1:nRows 
    for j =  1:nCols
        if ~compare_func{1}(i,j)
            A(i,j) = ij_func{1}([i j]); 
        elseif compare_func{2}(ij_func{2}([i j])) 
            A(i,j) =  vals(2); 
        else
            A(i,j) = 0;
        end 
    end
end
wrong_arrays_hard{1} = A;
wrong_explain_hard{1} = ['No. This array was created with the wrong $if/$ logical statement $~(i ' compare{1} ' j)/$'];


% Wrong 2: Opposite compare2
A = []; 
for i = 1:nRows 
    for j =  1:nCols
        if compare_func{1}(i,j)
            A(i,j) = ij_func{1}([i j]); 
        elseif ~compare_func{2}(ij_func{2}([i j])) 
            A(i,j) =  vals(2); 
        else
            A(i,j) = 0;
        end 
    end
end
wrong_arrays_hard{2} = A;
wrong_explain_hard{2} = ['No. This array was created with the wrong $elseif/$ logical statement $~(' ij_choice(2) ' ' compare{2} ' ' num2str(vals(1)) ')/$'];

% Wrong 3: place wrong val2
A = []; 
for i = 1:nRows 
    for j =  1:nCols
        if compare_func{1}(i,j)
            A(i,j) = ij_func{1}([i j]); 
        elseif compare_func{2}(ij_func{2}([i j])) 
            A(i,j) =  vals(1); 
        else
            A(i,j) = 0;
        end 
    end
end
wrong_arrays_hard{3} = A;
wrong_explain_hard{3} = ['No. This array was created with the wrong assigment statement after $elseif/$:  $' array_name '(i,j) = ' num2str(vals(1)) '/$ instead of $' array_name '(i,j) = ' num2str(vals(2)) '/$'];

% Wrong 4: Flip ij_choice1
temp_ij_func = str2func(['@(inputs) inputs(''ji''==''' ij_choice(1) ''')']);
A = []; 
for i = 1:nRows 
    for j =  1:nCols
        if compare_func{1}(i,j)
            A(i,j) = temp_ij_func([i j]); 
        elseif compare_func{2}(ij_func{2}([i j])) 
            A(i,j) =  vals(2); 
        else
            A(i,j) = 0;
        end 
    end
end
wrong_arrays_hard{4} = A;

% Wrong 5: Flip ij_choice2
temp_ij_func = str2func(['@(inputs) inputs(''ji''==''' ij_choice(2) ''')']);
A = []; 
for i = 1:nRows 
    for j =  1:nCols
        if compare_func{1}(i,j)
            A(i,j) = ij_func{1}([i j]); 
        elseif compare_func{2}(temp_ij_func([i j])) 
            A(i,j) =  vals(2); 
        else
            A(i,j) = 0;
        end 
    end
end
wrong_arrays_hard{5} = A;


% Easy wrong 3: Flip row col
A = []; 
for i = 1:nCols
    for j =  1:nRows
        if compare_func{1}(i,j)
            A(i,j) = ij_func{1}([i j]); 
        elseif compare_func{2}(ij_func{2}([i j])) 
            A(i,j) =  vals(2); 
        else
            A(i,j) = 0;
        end 
    end
end
wrong_arrays_easy{3} = A;

% Easy wrong 2: Too big
A = []; 
for i = 1:nRows+1 
    for j =  1:nCols+1
        if compare_func{1}(i,j)
            A(i,j) = ij_func{1}([i j]); 
        elseif compare_func{2}(ij_func{2}([i j])) 
            A(i,j) =  vals(2); 
        else
            A(i,j) = 0;
        end 
    end
end
wrong_arrays_easy{2} = A;

% Easy wrong 1: Too small
A = []; 
for i = 1:nRows-1 
    for j =  1:nCols-1
        if compare_func{1}(i,j)
            A(i,j) = ij_func{1}([i j]); 
        elseif compare_func{2}(ij_func{2}([i j])) 
            A(i,j) =  vals(2); 
        else
            A(i,j) = 0;
        end 
    end
end
wrong_arrays_easy{1} = A;

% Easy wrong 4: All zeros
A = zeros(nRows,nCols);
wrong_arrays_easy{4} = A;


%% Pick answers

% First answer is correct on
answer_arrays{1} = right_array;

% Try to pick hard wrong answers to get 5 total. If we can't, fill in
% remaining spots with easy wrong answers

%Keep adding answers until we have 4
checked_hard = false(size(wrong_arrays_hard));
checked_easy = false(size(wrong_arrays_easy));
while length(answer_arrays) < nAnswer
    
    % See if all hard answers have been checked
    if ~all(checked_hard)
        
        % Find fist unchecked hard answer
        iHard = find(~checked_hard,1);
        is_unique = true;
        
        % See if its different from all the other answers
        for iAns = 1:length(answer_arrays)
            if isequal(answer_arrays{iAns},wrong_arrays_hard{iHard})
                is_unique = false;
            end
        end
        
        % If different, add to answers        
        if is_unique
            answer_arrays{end+1} = wrong_arrays_hard{iHard};
        end
        
        % Mark that this array is now checked        
        checked_hard(iHard) = true;
        
    else % Add easy answer
        
        %Find first easy answer
            iEasy = find(~checked_easy,1);
        
        % Add to answers
        answer_arrays{end+1} = wrong_arrays_easy{iEasy};
        checked_easy(iEasy) = true;
    end
end
        
%% Make answer strings

answers = cell(nAnswer,1);
for iAns = 1:nAnswer
    answers{iAns} = ['$$' mimic_array_output(answer_arrays{iAns},array_name) '/$$'];
end



% str = ['A = []; for i = 1:' num2str(nRows) ', for j =  1:' num2str(nCols) ', if i ' compare{1} ' j, A(i,j) = ' ij_choice(1) '; elseif ' ij_choice(2) compare{2} num2str(vals(1)) ', A(i,j) =  ' num2str(vals(2)) '; else, A(i,j) = 0; end, end, end'];
% eval(str);