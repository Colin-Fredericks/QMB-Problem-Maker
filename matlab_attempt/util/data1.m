function [answer,minormax,img_id,range,alt_text] = data1()
% function DATA1 - QMB problem data1
%
%   [answer,minormax,img_id,range,alt_text] = data1()
%

% Get the min and max values of each image (i.e. recreate the loop that was
% used to create the images)
mins = 10:10:90;
count = 0;
values = [];
for ii = mins
    for jj = ii+10:10:100
        count = count+1;
        values(count,1:2) = [ii jj];        
    end
end
        
% Pick an image
img_id = randi(count,1);

%Pick min or max
words = {'min','max'};
choice_ind = randi(2,1);
minormax = words{choice_ind};

% Get answer
answer = values(img_id,choice_ind);
range = values(img_id,:);

alt_text = sprintf('A scatter plot of data with points that appear randomly placed. The dots are uniformly distributed across the x and y axes. The x-axis ranges from 1 to 10,000 and the y-axis ranges from %d to %d',values(img_id,:));


