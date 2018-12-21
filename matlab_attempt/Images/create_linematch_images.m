% These are images for summary statistics and will just have random data
clear
close all

font_size = 12;
im_size = 400;

%Create arrays of data for plotting and save to DATA
lines_per_plot = 4;
num_plot = 15;

%Printer type
format_type = '-dpng';
resolution = '-r100';

colors = lines(lines_per_plot+2);
markers = 'os^d';
line_styles = {'-','--',':','-.'};
line_width = 1.5;

array_values = {};
for ii = 1:num_plot
    figure('Color','w'); hold on
    
    % Pick unique first points to be used for the alt_txt
    first_points = randsample(100,lines_per_plot);
    
    %Pick rest of data randomly
    data = [first_points, randi(100,lines_per_plot,9)];
    
    %Add data to cell array to be saved
    array_values{ii} = data;
     
    %Add lines 
    for jj = 1:lines_per_plot
        plot(data(jj,:),'Marker',markers(jj),'Color',colors(jj,:), ...
            'LineWidth',line_width','MarkerFaceColor',colors(jj,:), ...
            'LineStyle',line_styles{1},'MarkerSize',6);
    end
    
    %Make pretty
    set(gca,'FontSize',font_size,'box','off','XTick',1:10,'XLim',[1 10])
    legend('Line 1','Line 2','Line 3','Line 4','Location','NortheastOutside')    
    set(gcf,'Position',[400 400 680 420]);
    
    %Print  
    print(sprintf('Cropped\\linematch_%d',ii),format_type,resolution);
    close

  
end


save ..\Data\linematch_data array_values


