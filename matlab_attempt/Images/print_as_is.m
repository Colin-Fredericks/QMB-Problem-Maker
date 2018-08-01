function print_as_is(fileName,formatType)
% PRINT_AS_IS - print figures at the current screen resolution
%   
%   print_as_is(fileName,formatType) prints the current figure to the file 
%   fileName with format formatType, e.g. '-djpeg'. The paper size is set 
%   to the current figure size and the resolution is the same as the 
%   display resolution, i.e. the '-r0' flag is included
%

%Set up paper size so it doesn't change with print
set(gcf,'Units','centimeters');
raster_size = get(gcf,'Position');
set(gcf, 'PaperPositionMode', 'manual', ...
    'PaperUnits','centimeters', ...
    'PaperSize',raster_size(3:4), ...
    'PaperPosition',[0 0 raster_size(3:4)])

% Save the file
print(fileName,formatType,'-r0');

%Change units back to the default pixels
set(gcf,'Units','pixels'); 