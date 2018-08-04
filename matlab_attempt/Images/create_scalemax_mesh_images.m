%%create_4pixel_images
clear
close all

font_size = 14;
im_size = 400;

%Different Max values
max_values = 10:10:100;

%Grid for images
array_size = 40;

%Choices for functions
func_choices = [1,2,11];

%Printer type
format_type = '-dpng';
resolution = '-r100';


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

%Make an image for each max size
for ii = 1:length(max_values)

        
    %Make the grid for the function calls
    x = linspace(-1,1,array_size);
    y = linspace(-1,1,array_size);
    [Y,X] = meshgrid(x,y);

    for kk = func_choices 

        %Create an image with max and min values as the defined range
        im = func_handles{kk}(X,Y);
        im = max_values(ii) * (im - min(im(:))) / (max(im(:)) - min(im(:)));

        %Interpolate to make bigger
        big_im = imresize(im,[im_size im_size],'nearest');

        %Add a 1-pixel black border to the one visualized with imshow
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
        set(gca,'Position',[ax_pos(1:2)-[0.03 0.0], ax_pos(3:4)])
        ax_pos = get(gca,'Position');


        %Print imshow
        print(sprintf('Cropped\\visualize3_imshow_max%d_func%d',ii,kk),format_type,resolution);

        % Imagesc
        figure('Color','w')
        imagesc(im)
        colorbar
        set(gcf,'Position',fig_pos)
        set(gca,'Position',ax_pos)
        set(gca,'FontSize',font_size)
        xlabel('Dimension 2'), ylabel('Dimension 1')

        %Print Imagesc
        print(sprintf('Cropped\\visualize3_imagesc_max%d_func%d',ii,kk),format_type,resolution);

        % Mesh
        figure('Color','w')
        mesh(im)
        set(gca,'YDir','reverse')
        set(gca,'FontSize',font_size)
        set(gcf,'Position',fig_pos)
        xlabel('Dimension 2'), ylabel('Dimension 1')
        set(gca,'XLim',[1 length(x)])
        set(gca,'YLim',[1 length(y)])
        
        
        %Get nice Z ticks
        num_ticks = 6;
        new_ticks = linspace(0,max_values(ii),num_ticks);
        while any(mod(new_ticks,1)>0)
            num_ticks = num_ticks - 1;
            new_ticks = linspace(0,max_values(ii),num_ticks);
        end
        set(gca,'ZLim',[0 max_values(ii)],'ZTick',new_ticks)

        %axis square

        %Print mesh
        print(sprintf('Cropped\\visualize3_mesh_max%d_func%d',ii,kk),format_type,resolution);
        close all
    end


end