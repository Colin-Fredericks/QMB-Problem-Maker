%%create_4pixel_images
clear
close all

size_im = 200;

num_shades = 4;
possible_values = floor(linspace(0,255,num_shades));


shade_inds = perms(1:num_shades);
%shade_inds = unique(shade_inds(:,1:4),'rows');

for ii = 1:size(shade_inds,1)
    im = reshape(possible_values(shade_inds(ii,1:4)),2,2);
    big_im = imresize(im,[size_im size_im],'nearest')/255;
    figure(1); imshow(big_im,[0 1]), set(figure(1),'Color','w');
    imwrite(big_im,['Cropped\gray_4pixel' num2str(ii) '.jpg']);
end
    


  