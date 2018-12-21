% These are images for summary statistics and will just have random data
clear
close all

font_size = 12;
im_size = 400;

%Grid for images
mins = 10:10:90;

%Printer type
format_type = '-dpng';
resolution = '-r100';

count = 0;
for ii = mins
    for jj = ii+10:10:100
        data = rand(1e4,1)*(jj-ii) + ii;
        figure('Color','w')
        plot(data,'.')
        set(gca,'FontSize',font_size)
        %axis equal
        set(gca,'box','off','YLim',[ii jj])
        
        %Print Imagesc
        count = count+1;
        print(sprintf('Cropped\\minmax_rand_%d',count),format_type,resolution);
        close

    end
end





