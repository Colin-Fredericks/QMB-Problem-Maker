% These are images for summary statistics and will just have random data
clear
close all

font_size = 12;
im_size = 400;

%Create arrays of data for plotting and save to DATA
num_plot = 10;
bins = -1.75:

%Printer type
format_type = '-dpng';
resolution = '-r100';

for ii = 1:num_plot
    
    
    
    %Pick rest of data randomly
    data = randn(1000,1);
    myArray = data(data>-2 & data<2);
    
    %Save data
    save(sprintf('..\\Data\\hist_array_%d.mat',ii),'myArray');
    
    figure('Color','w'); hold on
    hist(myArray);
    
    %Make pretty
    set(gca,'FontSize',font_size,'box','off')
    
    %Print  
    print(sprintf('Cropped\\hist_array_%d',ii),format_type,resolution);
    close

  
end



