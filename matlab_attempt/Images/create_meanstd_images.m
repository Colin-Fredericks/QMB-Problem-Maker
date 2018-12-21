% These are images for summary statistics and will just have random data
clear
close all

font_size = 12;
im_size = 400;

%Grid for images
means  = 100:-2:0;
stds = 1;

%Printer type
format_type = '-dpng';
resolution = '-r100';

count = 0;
for ii = means
    for jj = stds
        data = randn(1e4,1)*jj + ii;
        figure('Color','w')
        plot(data,'.')
        set(gca,'FontSize',font_size)
        yl = get(gca,'YLim');
        %axis equal
        set(gca,'box','off','YTick',yl(1):yl(2))
        
        %Print Imagesc
        count = count+1;
        print(sprintf('Cropped\\mean_rand_%d',count),format_type,resolution);
        close

    end
end





