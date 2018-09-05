%%create_4pixel_images
clear
close all

font_size = 14;
im_size = 400;

%Grid for images
array_size = 10;



%Printer type
format_type = '-dpng';
resolution = '-r100';


%Possible shapes 3D functions
func_handles = {@(X,Y) X; ...
    @(X,Y) Y; ...
    @(X,Y) -X; ...
    @(X,Y) -Y; ...
    @(X,Y) X + Y; ...
    @(X,Y) -(X + Y); ...
    @(X,Y) X - Y; ...   
	@(X,Y) -(X - Y); ...
	@(X,Y) X.*Y; ...
	@(X,Y) -X.*Y};

%Choices for functions
func_choices = 1:10;

%Make the grid for the function calls
x = 1:array_size;
y = 1:array_size;
[Y,X] = meshgrid(x,y);

for kk = func_choices 

    %Create an image with max and min values as the defined range
    im = func_handles{kk}(X,Y);

    % Imagesc
    figure('Color','w')
    imagesc(im)
    colorbar
    set(gca,'FontSize',font_size)
    axis equal
    set(gca,'XTick',x,'YTick',y,'box','off','XLim',[0.5 10.5],'YLim',[0.5 10.5])
    
   
    %Print Imagesc
    print(sprintf('Cropped\\nested2_imagesc_func%d',kk),format_type,resolution);

    close all
end