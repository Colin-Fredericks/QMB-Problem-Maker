function [correct,incorrect,problem_values] = compound2(array_name)
% [answers,correctness,problem_values] = compound2()
%
%
%

if nargin<1
    array_name = randsample('ABCDEFGHKMNPQRTUVWXYZ',1);
end
andor_symbol = randsample('&|',1);
array_length = 15;%randi(3,1)*10;
values = randsample(2:array_length-2,2);
compare_symbols= randsample({'<','>','<=','>='},2,true);

% Make function handles (to avoid using eval)
function_handle1 = str2func(['@(x) x' compare_symbols{1} num2str(values(1))]);
function_handle2 = str2func(['@(x) x' compare_symbols{2} num2str(values(2))]);

% The two logical arrays
logical1 = function_handle1(1:array_length);
logical2 = function_handle2(1:array_length);

% Three possible cases
%   1. Overlap, different direction
%       a. AND - 1 piece in middle
%       b. OR - whole range
%       c. XOR - 2 pieces on edge
%       d. ~OR - nothing
%       e. ~AND - same as XOR, so we need A or B
%   2. Overlap, same direction
%       a. AND - 1 piece on edge
%       b. OR - 1 bigger piece on edge
%       c. XOR - 1 piece in middle
%       d. ~OR - 1 piece on other edge
%       e. ~AND - 1 bigger piece on other edge
%   3. No overlap
%       a. AND - nothing
%       b. OR - 2 pieces on edge
%       c. XOR - same as OR, so need A or B
%       d. ~OR - 1 piece in middle
%       e. ~AND - whole thing

% Make the five answer arrays
and_array = logical1 & logical2;
or_array = logical1 | logical2;
xor_array = xor(logical1,logical2);
nor_array = ~or_array;
nand_array = ~and_array;

%Problem values for displaying the question
problem_values = {array_name,andor_symbol,array_length,values, ...
    compare_symbols};

%Use or array to differentiate the three cases. We have to do this because
%it changes the choice of incorrect answers
switch length(unique(bwlabel(or_array)))
    case 1 
        if andor_symbol=='&'
            correct = ['$$' mimic_array_output(and_array,array_name) '/$$'];
            incorrect{1} = ['$$' mimic_array_output(or_array,array_name) '/$$'];
            incorrect{2} = ['$$' mimic_array_output(xor_array,array_name) '/$$'];
            incorrect{3} = ['$$' mimic_array_output(nor_array,array_name) '/$$'];
            incorrect{4} = ['$$' mimic_array_output(logical1,array_name) '/$$'];
        else
            correct = ['$$' mimic_array_output(or_array,array_name) '/$$'];
            incorrect{1} = ['$$' mimic_array_output(and_array,array_name) '/$$'];
            incorrect{2} = ['$$' mimic_array_output(xor_array,array_name) '/$$'];
            incorrect{3} = ['$$' mimic_array_output(nor_array,array_name) '/$$'];
            incorrect{4} = ['$$' mimic_array_output(logical1,array_name) '/$$'];
        end
    case 2
        if andor_symbol=='&'
            correct = ['$$' mimic_array_output(and_array,array_name) '/$$'];
            incorrect{1} = ['$$' mimic_array_output(or_array,array_name) '/$$'];
            incorrect{2} = ['$$' mimic_array_output(xor_array,array_name) '/$$'];
            incorrect{3} = ['$$' mimic_array_output(nor_array,array_name) '/$$'];
            incorrect{4} = ['$$' mimic_array_output(nand_array,array_name) '/$$'];
        else
            correct = ['$$' mimic_array_output(or_array,array_name) '/$$'];
            incorrect{1} = ['$$' mimic_array_output(and_array,array_name) '/$$'];
            incorrect{2} = ['$$' mimic_array_output(xor_array,array_name) '/$$'];
            incorrect{3} = ['$$' mimic_array_output(nor_array,array_name) '/$$'];
            incorrect{4} = ['$$' mimic_array_output(nand_array,array_name) '/$$'];
        end         
    case 3
        if andor_symbol=='&'
            correct = ['$$' mimic_array_output(and_array,array_name) '/$$'];
            incorrect{1} = ['$$' mimic_array_output(or_array,array_name) '/$$'];
            incorrect{2} = ['$$' mimic_array_output(logical1,array_name) '/$$'];
            incorrect{3} = ['$$' mimic_array_output(nor_array,array_name) '/$$'];
            incorrect{4} = ['$$' mimic_array_output(nand_array,array_name) '/$$'];
        else
            correct = ['$$' mimic_array_output(or_array,array_name) '/$$'];
            incorrect{1} = ['$$' mimic_array_output(and_array,array_name) '/$$'];
            incorrect{2} = ['$$' mimic_array_output(logical1,array_name) '/$$'];
            incorrect{3} = ['$$' mimic_array_output(nor_array,array_name) '/$$'];
            incorrect{4} = ['$$' mimic_array_output(nand_array,array_name) '/$$'];
        end          
    otherwise
        error('Something went wrong');        
end
        







