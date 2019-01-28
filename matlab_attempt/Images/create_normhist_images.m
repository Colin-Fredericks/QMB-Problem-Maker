% These are images for summary statistics and will just have random data
clear
close all

font_size = 12;
im_size = 400;

stddevs = [1 5 10];
means = 10:10:100; 

%Printer type
format_type = '-dpng';
resolution = '-r100';

count = 1;
for ii = 1:length(stddevs)
    for jj = 1:length(means)
    
        % Generate data
        data = means(jj) + stddevs(ii)*randn(1e5,1);
        
        % Histogram
        figure('Color','w'); hold on  
        hist(data,40)
        set(gca,'FontSize',font_size,'box','off','TickDir','In')
        xl = get(gca,'XLim');
        set(gca,'XTick',xl(1):stddevs(ii):xl(2));
        
        % Print histogram
        print(sprintf('Cropped\\normhist_%d',count),format_type,resolution);
        close
        
        % Plot
        %figure('Color','w'); hold on  
        %plot(data,'.')
        %set(gca,'FontSize',font_size,'box','off','TickDir','In')

        % Print data
        %print(sprintf('Cropped\\betarnd_data_%d',count),format_type,resolution);
        %close
        
        count = count+1;
       
    end
  
end



