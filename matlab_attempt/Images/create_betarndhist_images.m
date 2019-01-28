% These are images for summary statistics and will just have random data
clear
close all

font_size = 12;
im_size = 400;

%Create arrays of data for plotting and save to DATA
% params = [1 1; ...
%           1 2; ...
%           2 1; ...
%           5 1; ...
%           1 5; ...
%           2 2; ...
%           2 5; ...
%           5 5; ...
%           0.6 0.6
%           5 2];

params = [1 1; ...
          1 5; ...
          5 5];

factors = [1 10:10:100]; 

%Printer type
format_type = '-dpng';
resolution = '-r100';

count = 1;
for ii = 1:size(params,1)
    for jj = 1:length(factors)
    
        % Generate data
        data = factors(jj)*betarnd(params(ii,1),params(ii,2),[1e4,1]);

        % Histogram
        figure('Color','w'); hold on  
        hist(data,20)
        set(gca,'FontSize',font_size,'box','off','TickDir','In')
        
        % Print histogram
        print(sprintf('Cropped\\betarnd_hist_%d',count),format_type,resolution);
        close
        
        % Plot
        figure('Color','w'); hold on  
        plot(data,'.')
        set(gca,'FontSize',font_size,'box','off','TickDir','In')

        % Print data
        print(sprintf('Cropped\\betarnd_data_%d',count),format_type,resolution);
        close
        
        count = count+1;
       
    end

  
end



