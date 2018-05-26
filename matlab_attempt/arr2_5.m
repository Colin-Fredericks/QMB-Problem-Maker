function [answers,store_str,retrieve_str,array_str] = arr2_5(vec_list,arr_list,max_size)
%Function ARR2_5: Creates answers for QMB problem 'arr2.5'
%
%   [ANS_STR,STO_STR,RET_STR,ARR_STR] = arr2_5(VLIST,ALIST,SMAX) 
%   creates the answers for the MC problem 'arr2.5'. VLIST and ALIST are
%   possible names for the vector and array, respectively. SMAX is the max
%   int value that will be used as an index
%
%   The output are strings used to populate the problem
%
%   Ex.
%
%   [ANS_STR,STO_STR,RET_STR,ARR_STR]] = arr2_5('abc','ABC',10) might 
%   produce the following output
%
%       ANS_STR = {'A value is being stored in A(3,6)', ...
%                  'A value is being retrieved from A(3,6)'}
%       STO_STR = 'A(3,6)'
%       RESTR = 'b_value'
%       ARR_STR = 'A'
%       

% Sample a array and vector name
array_str = randsample(arr_list,1);
vector_str = randsample(vec_list,1);
if iscell(array_str)
    array_str = array_str{1};
end
if iscell(vector_str)
    vector_str = vector_str{1};
end
vector_str = [vector_str '_value'];

%Pick random integers for indices
indices = randi(max_size,1,2);

% Pick rand to decide what the answer will be
if rand < 0.5
    store_str = [array_str '(' num2str(indices(1)) ',' num2str(indices(2)) ')'];
    retrieve_str = vector_str;    
    answers{1} = ['A value is being stored in ' store_str];
    answers{2} = ['A value is being retrieved from ' store_str]; 
else
    retrieve_str = [array_str '(' num2str(indices(1)) ',' num2str(indices(2)) ')'];
    store_str = vector_str;
    answers{1} = ['A value is being retrieved from ' retrieve_str]; 
    answers{2} = ['A value is being stored in ' retrieve_str];    
end


