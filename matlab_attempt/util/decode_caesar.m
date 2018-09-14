function new_str = decode_caesar(old_str,num_shift)
% DECODE_CAESAR - Encodes a string using a Caeser Cipher
%
%
%   new_str = decode_caesar(old_str,num_shift) will decode old_str using a
%   Caesar cipher with key num_shift. Essentially, it shifts letters by
%   num_shift places in an ASCII lookup table
%
%

if ~any(ismember(char(1:256),old_str))
    error('This function only supports 8-bit characters')
end

decode_ind = [num_shift+1:256 1:num_shift];
new_str = char(decode_ind(uint8(old_str)));