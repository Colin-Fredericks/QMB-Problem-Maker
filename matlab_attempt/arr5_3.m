function [correct_answer,incorrect_answers,file_name,size_im,ratio_str] = arr5_3(base_name,sizes,ratios)
% function ARR5_3 - generate answers for problem arr5.3
%
% Usage: 
%
% [CORR,INCORR,FNAME,SIZE_IM,RATIO] = arr5_3(IM_NAME,SIZES,RATIOS) 
%   IM_NAME: base file name for an iamge
%   SIZES: list of possible image sizes
%   RATIOS: list of image ratios used to make images
%
%   CORR: string with the correct answer
%   INCORR: cell array of strings with the incorrect answers
%   FNAME: name of the file to be loaded
%   RATIO: string with the ratio of sizes in the correct answer
%
% Example
%   im_name = 'moon';
%   sizes = [100,200,300,400];
%   ratios = [1 4; 1 2; 1 1; 2 1; 4 1]
%
%   [corr,incorr,fname,size_im,ratio] = arr5_3(im_name,sizes,ratios);
%

%Pick a base size 
size_choice = randsample(sizes,1);
dims = size_choice*ratios;

%Choose a correct answer
correct_ind = randi(5,1);
incorrect_ind = [1:correct_ind-1 correct_ind+1:size(ratios,1)];

correct_answer = [num2str(dims(correct_ind,1)) ' x ' ...
                  num2str(dims(correct_ind,2))];

%Get incorrect answers
incorrect_answers = cell(size(ratios,1)-1,1);
for ii = 1:size(ratios,1)-1
    incorrect_answers{ii} = [num2str(dims(incorrect_ind(ii),1)) ' x ' ...
                             num2str(dims(incorrect_ind(ii),2))];
end

%File name
file_name = [base_name '_squish' num2str(correct_ind) '.jpg'];

%Ratio str
ratio_str = [num2str(ratios(correct_ind,1)) ':' num2str(ratios(correct_ind,2))];

%Size of image
size_im = dims(correct_ind,:);