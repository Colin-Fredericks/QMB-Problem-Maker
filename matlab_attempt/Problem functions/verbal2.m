function [picked_answers,correctness,question,solution] = verbal2(varargin)
% VERBAL2 - Make asnwers for QMB problem verbal2
%
%   [correct,incorrect,solution] = verbal2()
%
% --------------------------Explanation -----------------------------------
% This problem has 3 variables and 2 operations. Based on the way the
% question is written, there are 8 possible ways of writing the answers.
% Let V1, V2, and V3 standard for variable1, variable2, etc. and S1, S2
% stand for symbol1, symbol2. The eight ways to write answers are:
%
%   1. V1 S1 V2 S2 V3
%   2. V1 S1 V3 S2 V2
%   3. V1 S1 (V2 S2 V3)
%   4. V1 S1 (V3 S2 V2)
%   5. V2 S2 V3 S1 V1
%   6. V3 S2 V2 S1 V1
%   7. (V2 S2 V3) S1 V1
%   8. (V3 S2 V2) S1 V1
%
% There are 12 possible questions we can ask, pairing up the operations
% possible_operation1 = {'Add','Multiply','Divide','Subtract'};
% possible_operation2 = {'product','sum','difference'}
% Let 1-4 stand for operation1 and A-C stand for operation2. Each questions
% can have different right answers from the list of 8 above. Here are the
% 12 possible combinations and which of the 8 answers are correct for that
% question
%
%   1A, Add x to the product of y and z             ---> 1:8
%   2A, Multiply x by the product of y and z        ---> 1:8
%   3A, Divide x by the product of y and z          ---> 1:4
%   4A, Subtract x from the product of y and z      ---> 5:8
%   1B, Add x to the sum of y and z                 ---> 1:8
%   2B, Multiply x by the sum of y and z            ---> [3,4,7,8]
%   3B, Divide x by the sum of y and z              ---> [3,4]
%   4B, Subtract x from the sum of y and z          ---> 5:8
%   1C, Add x to the difference of y and z          ---> [1,3,5,7]
%   2C, Multiply x by the difference of y and z     ---> [3,7]
%   3C, Divide x by the difference of y and z       ---> [3]
%   4C, Subtract x from the difference of y and z   ---> [5,7]
%
% --------------------End explanation -------------------------------------

%Input parameters
possible_names = 'abcdfghkmnpqrtvwxyz';

%Now parse input arguments
% Parse varargin
unparsed = ParseArgin(varargin{:});
if ~isempty(unparsed)
     error(['Unable to parse input: ''' unparsed{1} '''']);
end

%Possible operations
possible_operation1 = {'Add','Multiply','Divide','Subtract'};
possible_operation2 = {'product','sum','difference'};

%Random sampling of operations and names
var_names = randsample(possible_names,3);
operation1 = randsample(possible_operation1,1);
operation1 = operation1{1};
operation2 = randsample(possible_operation2,1);
operation2 = operation2{1};

% Get helper word based on operations
help_words = {'to','by','by','from'};
help_word = help_words{ismember(possible_operation1,operation1)};

% Get symbols based on operations
symbols1 = '+*/-';
symbol1 = symbols1(ismember(possible_operation1,operation1));
symbols2 = '*+-';
symbol2 = symbols2(ismember(possible_operation2,operation2));

% Assemble the problem statement
question = ['You have three variables named $' var_names(1) '/$, $' ...
    var_names(2) '/$, and $' var_names(3) '/$. '  ...
    operation1 ' $' var_names(1) '/$ ' help_word ' the ' ...
    operation2 ' of $' var_names(2) '/$ and $' var_names(3) '/$.'];

% Assemble the 8 possible answers
answers{1} = ['$' var_names(1) ' ' symbol1 ' ' var_names(2) ' ' symbol2 ' ' var_names(3) '/$'];
answers{2} = ['$' var_names(1) ' ' symbol1 ' ' var_names(3) ' ' symbol2 ' ' var_names(2) '/$'];
answers{3} = ['$' var_names(1) ' ' symbol1 ' (' var_names(2) ' ' symbol2 ' ' var_names(3) ')/$'];
answers{4} = ['$' var_names(1) ' ' symbol1 ' (' var_names(3) ' ' symbol2 ' ' var_names(2) ')/$'];
answers{5} = ['$' var_names(2) ' ' symbol2 ' ' var_names(3) ' ' symbol1 ' ' var_names(1) '/$'];
answers{6} = ['$' var_names(3) ' ' symbol2 ' ' var_names(2) ' ' symbol1 ' ' var_names(1) '/$'];
answers{7} = ['$(' var_names(2) ' ' symbol2 ' ' var_names(3) ') ' symbol1 ' ' var_names(1) '/$'];
answers{8} = ['$(' var_names(3) ' ' symbol2 ' ' var_names(2) ') ' symbol1 ' ' var_names(1) '/$'];

% Lookup table for which answers are correct for the 12 possible
% combinations of questions (4x3 matrix), so correct_ind(3,2) would be the
% correct answers for 'Divide x by the sum of y an z'

correct_answers = {1:8,     1:8,        [1,3,5,7];  ...
                   1:8,     [3,4,7,8],  [3,7];      ...
                   1:4,     [3,4],      [3];        ...
                   5:8,     5:8,        [5,7]};

explanations = {'Multiplication and addition are both commutative, so the order does not matter. Also multiplication has higher priority than addition, so the parentheses have no effect on the operation. All of these choices will return the same correct answer.', ...
    'Addition is commutative, so the order does not matter. Also, since both operations are addition, the presence of parentheses has no effect. All of these choices will return the same correct answer.', ...
    ['Addition and subtraction have the same priority, so parentheses will have no effect. However, the use of the word "difference" means you need $' var_names(2) ' - ' var_names(3) '/$ (in that order) because subtraction is not commutative.']; ...
    'Multiplication is commutative, so the order does not matter. Also, since both operations are multiplication, the parentheses will have no effect on the final answer. All of these choices are correct.', ...
    'Multiplication and addition are both commutative, so the order does not matter. However, multiplication has a higher priority, so you must enclose the sum within parentheses to ensure it is calculated first.', ...
    ['Subtraction is not commuative, so the word "difference" implies you need $' var_names(2) ' - ' var_names(3) '/$ (in that order). You must also enclose this operation in parentheses to make sure the difference is calculated before the multiplication.']; ...
    ['Division is not commutative, so the phrase "Divide $' var_names(1) '/$ by ..." means $' var_names(1) '/$ must be first. Multiplication is commutative, though, so the order of the product does not matter. Parentheses will also have no effect.'], ... 
    ['Division is not commutative, so the phrase "Divide $' var_names(1) '/$ by ..." means $' var_names(1) '/$ must be first. Addition is commutative, so the order of the sum does not matter, but it must be enclosed in parentheses to ensure the sum is calculated first.'], ...
    ['Division is not commutative, so the phrase "Divide $' var_names(1) '/$ by ..." means $' var_names(1) '/$ must be first. Subtraction is also not commutative, so the word "difference" means you need $' var_names(2) ' - ' var_names(3) '/$ (in that order). The difference also needs to be enclosed in parentheses to ensure it is calculated first.']; ...
    ['Subtraction is not commutative, so you need " ... $- ' var_names(1) '/$" at the end of the line of code. The multiplication is commutative and higher priority than the subtraction, so the product can be in any order and with or without parentheses.'], ...
    ['Subtraction is not commutative, so you need " ... $- ' var_names(1) '/$" at the end of the line of code. The addition is commutative and the same priority as the subtraction, so the sum can be in any order and with or without parentheses.'], ...
    ['Subtraction is not commutative, so you need " ... $- ' var_names(1) '/$" at the end of the line of code. The word "difference" also implies you need $' var_names(2) ' - ' var_names(3) '/$ (in that order). Adding parentheses will have no effect.']};

% Now lookup the answers and explanation
correct_ind = correct_answers{ismember(possible_operation1,operation1), ...
                              ismember(possible_operation2,operation2)};
explanation = explanations{ismember(possible_operation1,operation1), ...
                           ismember(possible_operation2,operation2)};
                          
% Randomly pick 5 answers. Make sure there is at least 1 correct
picked_ind = randsample(1:8,5);
while ~any(ismember(picked_ind,correct_ind))
    picked_ind = randsample(1:8,5);
end

% Pick out the 5 kept answers and determine which are correct
picked_answers = answers(picked_ind);
correctness_ind = ismember(picked_ind,correct_ind);
possible_correctness = {'FALSE','TRUE'};
correctness = possible_correctness(double(correctness_ind)+1);

% Lastly. Write out the solution
if sum(correctness_ind) == 1
    beginning = ['Only the answer ' picked_answers{correctness_ind} ' is correct.'];
elseif sum(correctness_ind) == 2
    temp_answers = picked_answers(correctness_ind);
    beginning = ['Only the answers ' temp_answers{1} ' and ' temp_answers{2} ' are correct.'];
else
    temp_answers = picked_answers(correctness_ind);
    beginning = ['The answers ' strjoin(temp_answers(1:end-1),', ') ', and ' temp_answers{end} ' are correct.'];    
end
solution = [beginning ' ' explanation];   


