function str = mat2string(mat)
% Function MAT2STRING
%
%   Same function as mat2str but uses commas and spaces after semicolons
%   
%   mat2str(zeros(2)) returns '[0 0;0 0]'
%
%   mat2string(zeros(2)) returns '[0, 0; 0, 0]'
 
str = strrep(strrep(mat2str(mat),' ',', '),';','; ');

end