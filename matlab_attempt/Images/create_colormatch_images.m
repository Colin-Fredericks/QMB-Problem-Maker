% These are images for summary statistics and will just have random data
clear
close all

font_size = 12;
im_size = 400;

%Create arrays of data for plotting and save to DATA
num_plot = 50;
color_symbols = 'rgbk';
linestyle_symbols = {'-','--',':','-.'};
marker_symbols = 'o+*xsd^v';

%Printer type
format_type = '-dpng';
resolution = '-r100';


line_width = 1.2;
linespec = {};
count = 1;
while count < num_plot

    %Pick a color, 
    color = randsample(color_symbols,1);
    marker = randsample(marker_symbols,1);
    linestyle = randsample(linestyle_symbols,1);
    
    % Check to see if this pattern has already been picked
    already_exists = false;
    for ii = 1:size(linespec,1)
        if strcmp([color,marker,linestyle{1}],strjoin(linespec(ii,:),''))
            already_exists = true;
        end
    end
    
    % Skip if exists
    if already_exists
        continue;
        disp('Skipping');
    end
        
    %Add to linespec
    linespec(end+1,1:3) = {color,marker,linestyle{1}};
    
    % Make the plot    
    figure('Color','w'); hold on
    data = randi(100,1,10);
    plot(data,[color,marker,linestyle{1}],'LineWidth',line_width, ...
        'MarkerSize',7);

    %Make pretty
    set(gca,'FontSize',font_size,'box','off')    
    
    %Print  
    print(sprintf('Cropped\\colormatch_%d',count),format_type,resolution);
    close
    count = count+1;

  
end


save ..\Data\colormatch_data linespec


