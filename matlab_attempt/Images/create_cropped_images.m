%Test image cropping randomization
clear
close all

im_name = 'bouquet';
im = imread(['Full Size\' im_name '.jpg']);
size_im = size(im);

num_crop = 3;
row_pts = round(linspace(1,size_im(1),num_crop+1));
col_pts = round(linspace(1,size_im(2),num_crop+1));


figure
imshow(im)

figure
for ii = 1:num_crop
    for jj = 1:num_crop
        id = (ii-1)*num_crop+jj;
        cropped_im = im(row_pts(ii):row_pts(ii+1), ...
                        col_pts(jj):col_pts(jj+1),:);
        subplot(num_crop,num_crop,id);
        imshow(cropped_im);
        
        imwrite(cropped_im,['Cropped\' im_name '_grid'  ...
                            num2str(num_crop) '_crop' num2str(id) '.jpg']);
    end
end
% 
% figure
% subplot(2,2,1)
% imshow(im(randi

%<a href="/static/name_of_file.idk"></a>