%Test image cropping randomization
clear
close all

im_name = 'columns';
im = imread(['Full Size\' im_name '.jpg']);
size_im = size(im);


im_red = im;
im_red(:,:,[2 3]) = 0;
im_green = im;
im_green(:,:,[1 3]) = 0;
im_blue = im;
im_blue(:,:,[1 2]) = 0;


figure
subplot(2,2,1)
imshow(im)
subplot(2,2,2)
imshow(im_red)
subplot(2,2,3)
imshow(im_green)
subplot(2,2,4)
imshow(im_blue)
% 
% figure
% subplot(2,2,1)
% imshow(im(randi

imwrite(im_red,['Cropped\' im_name '_red.jpg']);
imwrite(im_green,['Cropped\' im_name '_green.jpg']);
imwrite(im_blue,['Cropped\' im_name '_blue.jpg']);

%<a href="/static/name_of_file.idk"></a>