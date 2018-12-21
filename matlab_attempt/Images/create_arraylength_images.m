% These are images for summary statistics and will just have random data
clear
close all

font_size = 12;
im_size = 400;

%Create arrays of data for plotting and save to DATA
lengths = 5e3:-100:100;

%Printer type
format_type = '-dpng';
resolution = '-r100';

for ii = 1:length(lengths)
    figure('Color','w')
    data = rand(1,lengths(ii));
    plot(data)
    set(gca,'FontSize',font_size)
    %axis equal
    xticks = round(linspace(0,lengths(ii),6));
    set(gca,'box','off','XLim',[0 lengths(ii)],'XTick',xticks)

    %Print Imagesc
    
    print(sprintf('Cropped\\arraylength_%d',ii),format_type,resolution);
    close

  
end





