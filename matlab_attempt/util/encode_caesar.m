function new_str = encode_caesar(old_str,num_shift)
% ENCODE_CAESAR - Encodes a string using a Caeser Cipher
%
%
%   new_str = encode_caesar(old_str,num_shift) will encode old_str using a
%   Caesar cipher with key num_shift. Essentially, it shifts letters by
%   num_shift places in an ASCII lookup
%
%

if ~any(ismember(char(1:256),old_str))
    error('This function only supports 8-bit characters')
end

encode_ind = [256-num_shift+1:256 1:256-num_shift];
new_str = char(encode_ind(uint8(old_str)));