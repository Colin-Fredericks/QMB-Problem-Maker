% These are images for summary statistics and will just have random data
clear
close all

font_size = 12;
im_size = 400;

%Create arrays of data for plotting and save to DATA
num_plot = 10;
num_pts = 10;
max_val = 15;
data_pts = randi(max_val,num_plot,num_pts);
save('..\Data\arrayguess_data.mat','data_pts')

%Printer type
format_type = '-dpng';
resolution = '-r100';

for ii = 1:num_plot
    figure('Color','w')
    plot(data_pts(ii,:),'o-')
    set(gca,'FontSize',font_size)
    %axis equal
    set(gca,'box','off','YLim',[1 max_val],'XLim',[1 num_pts],'XTick',1:num_pts,'YTick',0:max_val)

    %Print Imagesc
    
    print(sprintf('Cropped\\arrayguess_%d',ii),format_type,resolution);
    close

  
end





