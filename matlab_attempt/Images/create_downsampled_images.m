%Test image cropping randomization
clear
close all

im_name = 'wave';
im = imread(['Full Size\' im_name '.jpg']);
size_im = size(im);


figure(1);
imshow(im)
factors = 2:5;


figure(2);
for ii = 1:length(factors)
    for jj = 1:length(factors)
        id = (ii-1)*length(factors)+jj;
        new_im = im(1:factors(ii):end,1:factors(jj):end,:);
                
        subplot(length(factors),length(factors),id);
        imshow(new_im);
        
        imwrite(new_im,['Cropped\' im_name '_grid'  ...
            num2str(length(factors)) '_downsize' num2str(id) '.jpg']);

    end
end
        
