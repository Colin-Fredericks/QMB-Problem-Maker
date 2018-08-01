%%create_4pixel_images
clear
close all

font_size = 14;
im_size = 400;

%Grid for images
array_size = 40;
col_sizes = 40:40:160;
row_sizes = 40:40:160;

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

%Make an image for each row choice, col choice and func choice
for ii = 1:length(row_sizes)
    for jj = 1:length(col_sizes)
        
        %Skip over cases when they are equal
        if col_sizes(jj)==row_sizes(ii)
            continue;
        end
        
        %Make the grid for the function calls
        x = linspace(-1,1,col_sizes(jj));
        y = linspace(-1,1,row_sizes(ii));
        [Y,X] = meshgrid(x,y);

        for kk = func_choices 
            
            %Create an image with max and min values as the defined range
            im = func_handles{kk}(X,Y);
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
            set(gca,'Position',[ax_pos(1:2)-[0.03 0.0], ax_pos(3:4)])
            ax_pos = get(gca,'Position');


            %Print imshow
            print(sprintf('Cropped\\visualize2_imshow_row%d_col%d_func%d',ii,jj,kk),format_type,resolution);

            % Imagesc
            figure('Color','w')
            imagesc(im)
            colorbar
            set(gcf,'Position',fig_pos)
            set(gca,'Position',ax_pos)
            set(gca,'FontSize',font_size)
            xlabel('Dimension 2'), ylabel('Dimension 1')

            %Print Imagesc
            print(sprintf('Cropped\\visualize2_imagesc_row%d_col%d_func%d',ii,jj,kk),format_type,resolution);

            % Mesh
            figure('Color','w')
            mesh(im)
            set(gca,'YDir','reverse')
            set(gca,'FontSize',font_size)
            set(gcf,'Position',fig_pos)
            xlabel('Dimension 2'), ylabel('Dimension 1')
            set(gca,'XLim',[1 length(x)])
            set(gca,'YLim',[1 length(y)])
            
            %axis square

            %Print mesh
            print(sprintf('Cropped\\visualize2_mesh_row%d_col%d_func%d',ii,jj,kk),format_type,resolution);
            close all
        end
    end

end