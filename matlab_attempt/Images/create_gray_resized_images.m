%Test image cropping randomization
clear
close all

im_name = 'spiral';
im = imread(['Full Size\' im_name '.jpg']);
size_im = size(im);

sizes = [200 310 420 530 640];

figure
imshow(im)

figure
for ii = 1:length(sizes)
    for jj = 1:length(sizes)
        if ii~=jj
            id = (ii-1)*length(sizes)+jj;
            new_im = rgb2gray(imresize(im,[sizes(ii) sizes(jj)]));
            subplot(length(sizes),length(sizes),id);
            imshow(new_im);

            imwrite(new_im,['Cropped\' im_name '_gray_resized_' num2str(id) '.jpg']);
        end
    end
end
% 
% figure
% subplot(2,2,1)
% imshow(im(randi

%<a href="/static/name_of_file.idk"></a>