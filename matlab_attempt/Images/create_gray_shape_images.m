%%create_4pixel_images
clear
close all

size_im = 250;

%Grid for images
im_size = 10;
x = linspace(-1,1,im_size);
y = x;
[Y,X] = meshgrid(y,x);

%Possible shapes 3D functions
func_handles{1} = @(X,Y) X-Y; ...
func_handles{2} = @(X,Y) X.^2-Y.^2;
func_handles{3} = @(X,Y) X.^2-Y;
func_handles{4} = @(X,Y) sqrt(X.^2 + Y.^2);
% func_handles{5} = @(X,Y) X;
% func_handles{6} = @(X,Y) Y;
% func_handles{7} = @(X,Y) 1 - abs(Y);
% func_handles{8} = @(X,Y) 1 - abs(X);
% func_handles{9} = @(X,Y) Y - X;
% func_handles{10} = @(X,Y) Y.^2 - X.^2;
% func_handles{11} = @(X,Y) Y.^2 - X;
% func_handles{12} = @(X,Y) -sqrt(X.^2 + Y.^2);
% func_handles{13} = @(X,Y) X.*Y;
% func_handles{14} = @(X,Y) sin(pi*X).*sin(pi*Y);
% func_handles{15} = @(X,Y) sin(pi*X);
% func_handles{16} = @(X,Y) sin(pi*Y);
% func_handles{17} = @(X,Y) sin(pi*Y)+sin(pi*X);
% func_handles{18} = @(X,Y) sin(pi*Y)-sin(pi*X);
% func_handles{19} = @(X,Y) sin(3*pi*sqrt(X.^2 + Y.^2))./(sqrt(X.^2 + Y.^2)+eps);

for jj = 1:length(func_handles); 
    

    %Create an image with max and min values as the defined range
    im = func_handles{jj}(X,Y);
    im = (im - min(im(:))) / (max(im(:)) - min(im(:)));
    %im = round(im*diff(gray_pairings(ii,:)) + gray_pairings(ii,1));

    %Interpolate to make bigger
    big_im = imresize(im,[size_im size_im],'nearest');

    %Add a 1-pixel black border
    big_im(1:end,1) = 0;
    big_im(1:end,end) = 0;
    big_im(1,1:end) = 0;
    big_im(end,1:end) = 0;

    %Resize and show
    fig = figure(1);        
    imshow(big_im,[]);
    fig.Color = 'w';


    %Print the image
    imwrite(big_im,sprintf('Cropped\\gray_shape%d.jpg',jj));
    %print(sprintf('Cropped\\gray_shape%d.jpg',jj),'-djpeg','-r0');
end
