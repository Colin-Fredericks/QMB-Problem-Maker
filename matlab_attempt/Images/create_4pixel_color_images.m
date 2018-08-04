clear
close all

num_pixels = 4;
choices = zeros(num_pixels,3^num_pixels);
rgb_triplets = [1 0 0;0 1 0;0 0 1]*255;

size_im = 200;

for ii = 1:3^num_pixels
    
    %Choose which color each pixel is
    [p1,p2,p3,p4] = ind2sub([3 3 3 3],ii);
    color_ind  = [p1,p2,p3,p4]';
    
    %Assemble the image
    image =reshape(rgb_triplets(color_ind,:),[2 2 3]);
    
    %Create the large version
    big_im = imresize(image,[size_im size_im],'nearest')/255;
    
   
    
    %Add the outline
    big_im(:,1,:) = 0;
    big_im(:,end,:) = 0;
    big_im(1,:,:) = 0;
    big_im(end,:,:) = 0;
    
    %Add the two lines in the middle
    big_im(:,round(size_im/2),:) = 0;
    big_im(round(size_im/2),:,:) = 0;
    
    
    figure(1); imshow(big_im,[0 1]), set(figure(1),'Color','w');
    imwrite(big_im,['Cropped\gray_4pixel_color_' num2str(ii) '.jpg']);

    
    
end
    