clear
close all

% x = -1.5:.01:1.5;
% y = x;
% [X,Y] = meshgrid(x,y);
% 
% figure
% f = @(X,Y) X.^2 - Y.^2;
% %cos(X).*cos(Y).*exp(-X.^2 - Y.^2
% mesh(f(X,Y))
% 
% 
% figure
% imshow(f(X,Y))
% 
% figure
% imagesc(f(X,Y))
% 



im = rgb2gray(imread('Full Size\surface.jpg'));

figure; 
imshow(im,[])

figure; 
imshow(im)
% 
% 
% figure;
% mesh(double(im));
% 
% 
% figure;
% imagesc(im)
% axis off