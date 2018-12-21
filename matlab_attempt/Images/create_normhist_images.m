% These are images for summary statistics and will just have random data
clear
close all

font_size = 12;
im_size = 400;

%Create arrays of data for plotting and save to DATA
num_plot = 10;
centers = -1.75:0.5:1.75;

%Printer type
format_type = '-dpng';
resolution = '-r100';

for ii = 1:num_plot
    
    figure('Color','w'); hold on
    
    % This data sampling mimics the appearance of random integers between 0
    % and 200. However, they are never within +/-5 of the YTicks on the
    % graph so it is easier to see in which interval the bar belongs.
    % Also, the first bar is small to it doesn't block the YTick marks
    mids = 20:40:180;
    counts = randsample(mids,8,true) + randi([-15 15],1,8);
    counts(1) = randi([5 35]);
    bar(centers,counts,1,'FaceColor',[61 38 168]/255);
    grid on
    
    %Make pretty
    set(gca,'FontSize',font_size,'box','off','YTick',0:40:200,'YLim',[0 200], ...
        'XLim',[-2 2],'TickDir','In')
    
    %Print  
    print(sprintf('Cropped\\randhist_%d',ii),format_type,resolution);
    close
    
    %Save data
    save(sprintf('..\\Data\\randhist_%d.mat',ii),'counts');

  
end



