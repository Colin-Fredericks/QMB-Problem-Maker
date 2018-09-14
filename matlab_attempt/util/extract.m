function values = extract(array,varargin)
% function EXTRACT - Helper function for writing the QMB problems in excel
%
%   values = extract(array,indices) is equivalent to:
%   values = array(indices);
%
%   values = extract(array,row_indices,col_indices) is equivalent to:
%   values = array(row_indices,col_indices). 
%
%   values = extract(array,dim1_ind,dim2_ind,dim3_ind, ...) will extract
%   values according to each dimension.
%
%

if nargin == 2
    values = array(varargin{1});
elseif nargin > 2
    string_args = cellfun(@mat2string,varargin,'UniformOutput',false);
    values = eval(['array(' strjoin(string_args,',') ');']);
else
    error('Extract must have 2 or more input arguments');
end