%%create_4pixel_images
clear
close all

size_im = 250;

gray_values = 0:50:250;

gray_pairings = nchoosek(gray_values,2);

for ii = 1:size(gray_pairings,1)
    
    %Create an image with max and min values as the defined range
    im = zeros(size_im)+gray_pairings(ii,1);
    im(1) = gray_pairings(ii,2);
    
    
    %Plot the image
    fig = figure; imshow(im,[]); 
    fig.Color = 'w';
    fig.Position = [fig.Position(1:2) 500 100];
    
    
    % Make the colorbar and move to the center
    cbar = colorbar;
    cbar.Location = 'south';
    cbar.FontSize = 12;
    cbar.Position = [0.05 0.38 0.9 0.35];  
   
    %Make sure Ticks are at max and min values
    if min(cbar.Ticks)~=gray_pairings(ii,1) || max(cbar.Ticks)~=gray_pairings(ii,2)
        
        % Figure out a nice-looking set of ticks. Worst case scenario it's
        % just two ticks at the endpoints
        num_ticks = 10;
        new_ticks = linspace(gray_pairings(ii,1),gray_pairings(ii,2),num_ticks);
        while any(mod(new_ticks,1)>0)
            num_ticks = num_ticks - 1;
            new_ticks = linspace(gray_pairings(ii,1),gray_pairings(ii,2),num_ticks);
        end
        
        %Replace the ticks
        cbar.Ticks = new_ticks;
        
    end
    
    %Delete the image
    delete(get(gca,'Children'))
    
    %Set up paper size so it doesn't change with print
    set(gcf,'Units','centimeters');
    raster_size = get(gcf,'Position');
    set(gcf, 'PaperPositionMode', 'manual', ...
        'PaperUnits','centimeters', ...
        'PaperSize',raster_size(3:4), ...
        'PaperPosition',[0 0 raster_size(3:4)])    
    
    %Print the image
    print(['Cropped\gray_colorbar' num2str(ii) '.jpg'],'-djpeg','-r0');
    
   
end
