%%create_4pixel_images
clear
close all

font_size = 14;
im_size = 400;

%Grid for images
array_size = 40;
x = linspace(-1,1,array_size);
y = x;
[Y,X] = meshgrid(y,x);

%Possible shapes 3D functions
func_handles = {@(X,Y) X.^2-Y.^2; ...
    @(X,Y) sqrt(X.^2 + Y.^2); ...
    @(X,Y) Y; ...
	@(X,Y) 1 - abs(Y); ...
	@(X,Y) 1 - abs(X); ...
	@(X,Y) Y - X; ...
	@(X,Y) Y.^2 - X.^2; ...
	@(X,Y) Y.^2 - X; ...
	@(X,Y) -sqrt(X.^2 + Y.^2); ...
	@(X,Y) X.*Y; ...
	@(X,Y) sin(pi*X).*sin(pi*Y); ...
	@(X,Y) sin(pi*Y); ...
    @(X,Y) sin(pi*Y)-sin(pi*X); ...
    @(X,Y) sin(3*pi*sqrt(X.^2 + Y.^2))./(sqrt(X.^2 + Y.^2)+eps) };

for jj = 1:length(func_handles)
            
    %Create an image with max and min values as the defined range
    im = func_handles{jj}(X,Y);
    im = (im - min(im(:))) / (max(im(:)) - min(im(:)));
    

    %Interpolate to make bigger
    big_im = imresize(im,[im_size im_size],'nearest');

    %Add a 1-pixel black border
    big_im(1:end,1) = 0;
    big_im(1:end,end) = 0;
    big_im(1,1:end) = 0;
    big_im(end,1:end) = 0;

    %Resize and show
    figure('Color','w')        
    imshow(big_im,[]);
    fig_pos = get(gcf,'Position');
    ax_pos = get(gca,'Position');
    set(gca,'FontSize',font_size)
    
    %Add colorbar and return to original position
    colorbar
    set(gca,'Position',[ax_pos(1:2)-[0.04 0.03], ax_pos(3:4)])
    ax_pos = get(gca,'Position');
    
    
    %Print imshow
    print_as_is(sprintf('Cropped\\visualize1_imshow%d.jpg',jj),'-djpeg');
    
    % Imagesc
    figure('Color','w')
    imagesc(im)
    colorbar
    set(gcf,'Position',fig_pos)
    set(gca,'Position',ax_pos)
    set(gca,'FontSize',font_size)
    
    %Print Imagesc
    print_as_is(sprintf('Cropped\\visualize1_imagesc%d.jpg',jj),'-djpeg');
    
    % Mesh
    figure('Color','w')
    mesh(im)
    set(gca,'YDir','reverse')
    set(gca,'FontSize',font_size)
    set(gcf,'Position',fig_pos)
    %xlabel('X'), ylabel('Y')
    %axis square
    
    %Print mesh
    print_as_is(sprintf('Cropped\\visualize1_mesh%d.jpg',jj),'-djpeg');


end