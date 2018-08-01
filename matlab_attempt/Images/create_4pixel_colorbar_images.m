%%create_4pixel_images
clear
close all

size_im = 250;

num_shades = 4;
possible_values = floor(linspace(0,255,num_shades));


shade_inds = perms(1:num_shades);
%shade_inds = unique(shade_inds(:,1:4),'rows');

for ii = 1:size(shade_inds,1)
    
    %Make image
    im = reshape(possible_values(shade_inds(ii,1:4)),2,2);
    big_im = imresize(im,[size_im size_im],'nearest')/255;
        
    %Add a black border
    big_im(1:end,1) = 0;
    big_im(1:end,end) = 0;
    big_im(1,1:end) = 0;
    big_im(end,1:end) = 0;
    
    %Make image
    figure(1); imshow(big_im,[0 1]), set(figure(1),'Color','w');
    
    %Get position since colorbar makes it smaller later
    set(gca,'Units','inches');
    axpos = get(gca,'Position');
    shades = possible_values'/255;
    colormap(repmat(shades,1,3));
    h = colorbar();
    h.Ticks = 0.125:0.25:0.875;
    h.TickLabels = possible_values;
    h.FontSize = 12
   % h.Label.String = 'Colorbar';
    
    %Move the image back so its the original size
    set(gca,'Position',[axpos(1:2)-[0.25 0.2] axpos(3:4)])    
    
    %Set up paper size so it doesn't change with print
    set(gcf,'Units','centimeters');
    raster_size = get(gcf,'Position');
    set(gcf, 'PaperPositionMode', 'manual', ...
        'PaperUnits','centimeters', ...
        'PaperSize',raster_size(3:4), ...
        'PaperPosition',[0 0 raster_size(3:4)])
    
    set(gca,'box','on')
    print(['Cropped\gray_4pixel' num2str(ii) '_with_colorbar.jpg'],'-djpeg','-r0');
end
    


  