% These are images for summary statistics and will just have random data
clear
close all

font_size = 12;
im_size = 400;

% Mean values used to shift the distribution (randomly shuffled 1:50)
map = randperm(50);

%Printer type
format_type = '-dpng';
resolution = '-r100';

for jj = 1:length(map)

    % Generate data
    data = map(jj) + randn(1e5,1);

    % Histogram
    figure('Color','w'); hold on  
    hist(data,40)
    set(gca,'FontSize',font_size,'box','off','TickDir','In')
    xl = get(gca,'XLim');
    set(gca,'XTick',floor(xl(1)):ceil(xl(2)))

    % Print histogram
    print(sprintf('Cropped\\norm_shiftstd_%d',jj),format_type,resolution);
    close

end

save('..\Data\norm_shiftstd_map','map');



