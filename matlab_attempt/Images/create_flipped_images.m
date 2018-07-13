%Test image cropping randomization
clear
close all

im_name = 'time';
im = imread(['Full Size\' im_name '.jpg']);
size_im = size(im);

num_crop = 2;
row_pts = round(linspace(1,size_im(1),num_crop+1));
col_pts = round(linspace(1,size_im(2),num_crop+1));


figure(1);
imshow(im)

figure
for ii = 1:num_crop
    for jj = 1:num_crop
        id = (ii-1)*num_crop+jj;
        cropped_im = im(row_pts(ii):row_pts(ii+1), ...
                        col_pts(jj):col_pts(jj+1),:);
                    
        updown_im = cropped_im(end:-1:1,1:end,:);
        leftright_im = cropped_im(1:end,end:-1:1,:);
        both_im = cropped_im(end:-1:1,end:-1:1,:);
        
        figure(2);
        subplot(num_crop,num_crop,id);
        imshow(cropped_im);
        
        figure(3)
        subplot(num_crop,num_crop,id);
        imshow(updown_im);
        
        figure(4)
        subplot(num_crop,num_crop,id);
        imshow(leftright_im);

        figure(5);
        subplot(num_crop,num_crop,id);
        imshow(both_im);
        
        id2 = (ii-1)*4*num_crop + (jj-1)*2*num_crop;
        imwrite(cropped_im,['Cropped\' im_name '_grid'  ...
                            num2str(num_crop) '_flip' num2str(id2+1) '.jpg']);
        imwrite(updown_im,['Cropped\' im_name '_grid'  ...
                            num2str(num_crop) '_flip' num2str(id2+2) '.jpg']);
        imwrite(leftright_im,['Cropped\' im_name '_grid'  ...
                            num2str(num_crop) '_flip' num2str(id2+3) '.jpg']);
        imwrite(both_im,['Cropped\' im_name '_grid'  ...
                            num2str(num_crop) '_flip' num2str(id2+4) '.jpg']);
    end
end
% 
% figure
% subplot(2,2,1)
% imshow(im(randi

%<a href="/static/name_of_file.idk"></a>